// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';
import 'package:solar_app/view/nav_bar/complaint_details/complaint_confirmation_view.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ComplaintController extends GetxController {
  var selectedValue = 'Urgent'.obs;
  bool goToNext = false;
  RxBool loading = false.obs;
  RxDouble ratingValue = 3.0.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<DateTime> selectedDates = <DateTime>[].obs;
  RxString imagePath = "".obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String status = "Pending"; // Default status
  String userUid = FirebaseAuth.instance.currentUser!.uid;
  List<DateTime> multiDatePickerValueWithDefaultValue = [];
  RxList<DocumentSnapshot<Object?>> complaints = <DocumentSnapshot>[].obs;

  void addDate(DateTime date) {
    selectedDates.add(date);
  }

  void removeDate(DateTime date) {
    selectedDates.remove(date);
  }

  buildDefaultMultiDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Colors.indigo,
    );

    return CalendarDatePicker2(
      config: config,
      value: selectedDates.where((date) => date != null).toList(),
      onValueChanged: (dates) {},
    );
  }

  void lodgeComplain(context, complainDocId) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(25)),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                smallSpace,
                ctext(
                    text: "Rate us!",
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                ctext(
                    text: "We are always here for you",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: lightPrimaryTextColor),
                smallSpace,
                Center(
                  child: RatingBar.builder(
                    itemSize: 32,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 0.2),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 13,
                    ),
                    onRatingUpdate: (rating) {
                      goToNext = true;
                      ratingValue.value = rating;
                    },
                  ),
                ),
                mediumSpace,
                CustomButton(
                  borderRadius: BorderRadius.circular(15),
                  height: 43,
                  mywidth: 1,
                  onPressed: () {
                    goToNext = true;

                    addRating(complainDocId);
                    fetchComplainUid(complainDocId);
                    // Get.to(
                    //     ComplaintConfirmationView(complainUid: complainDocId));
                  },
                  child: 'Submit',
                  gradientColors: [
                    btnPrimaryColor,
                    btnSecondaryColor,
                  ],
                  color: btnSecondaryColor,
                ),
                mediumSpace
              ]).paddingSymmetric(horizontal: 15, vertical: 10),
        );
      },
    );
  }

  Future<List<DocumentSnapshot>> getComplains() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userComplain =
        firestore.collection("users").doc(userUID).collection("complain");
    QuerySnapshot complainSbapshot = await userComplain.get();

    if (complainSbapshot.docs.isNotEmpty) {
      return complainSbapshot.docs;
    }
    return [];
  }

  void addComplain(context) async {
    loading.value = true;
    try {
      if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
        loading.value = false;
        Get.snackbar("Complain Error", "Please fill in all the values");
      } else if (imagePath.isEmpty) {
        loading.value = false;
        Get.snackbar("Complain Error", "Please upload your image");
      } else {
        String complainNumber = generateComplaintNumber();
        String currentLoginUid = FirebaseAuth.instance.currentUser!.uid;

        // Upload image to Firebase Storage
        UploadTask uploadImage = FirebaseStorage.instance
            .ref()
            .child("complain")
            .child(currentLoginUid)
            .putFile(File(imagePath.value));

        TaskSnapshot taskSnapshot = await uploadImage;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Prepare data to be added to Firestore
        Map<String, dynamic> complainData = {
          'title': titleController.text,
          'description': descriptionController.text,
          'status': selectedValue.value,
          'complaintNumber': complainNumber,
          'complainpicture': downloadUrl,
          'timestamp': FieldValue.serverTimestamp(),
        };

        // Add data to Firestore
        await firestore
            .collection("users")
            .doc(userUid)
            .collection("complain")
            .add(complainData)
            .then((DocumentReference document) {
          // Access the document ID here
          String complainDocId = document.id;

          firestore
              .collection("users")
              .doc(userUid)
              .collection("complain")
              .doc(complainDocId)
              .update({"status": "pending", "rating": ratingValue.toString()});
          lodgeComplain(context, complainDocId);
          // If you want to navigate to a new screen with the complainDocId:

          // Get.to(ComplaintConfirmationView(
          //    complainUid: complainDocId
          //   ));

          loading.value = false;
        });
        loading.value = false;

        Get.snackbar("Complain Submitted", "Your Complain Has been submitted");
        // Clear text fields after submitting the complaint
        imagePath.value = "";
        titleController.clear();
        descriptionController.clear();
        // lodgeComplain(context , complainDocId);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  String generateComplaintNumber() {
    // Generate a random complaint number based on current timestamp
    DateTime now = DateTime.now();
    String timestamp = now.microsecondsSinceEpoch.toString();
    return 'CMP$timestamp';
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  Future addRating(complainDocId) async {
    firestore
        .collection("users")
        .doc(userUid)
        .collection("complain")
        .doc(complainDocId)
        .update({
      "status": "pending",
      "progress": "in process",
      "rating": ratingValue.toString()
    });
  }

  fetchComplainUid(complainDocId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(userUid)
          .collection("complain")
          .doc(complainDocId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? userData =
            snapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          // Extract the complaint number from userData
          String complaintNumber = userData["complaintNumber"];

          // Use Get.to to navigate to the ComplaintConfirmationView
          Get.to(ComplaintConfirmationView(complainUid: complaintNumber));

          // Optionally, you can return the complaint number or null based on your requirements
          return complaintNumber;
        } else {
          // Handle the case where user data is null
          Get.snackbar("Error", "User data is null.");
          return null;
        }
      } else {
        // Handle the case where the user document does not exist
        Get.snackbar("Error", "User document does not exist.");
        return null;
      }
    } catch (e) {
      // Handle errors
      print('Error fetching complain UID: $e');
      Get.snackbar("Error", "An error occurred while fetching complain UID.");
      return null;
    }
  }

  Future<void> sendEmail() async {
    // Set up the Gmail SMTP server
    final smtpServer = gmail("your@gmail.com", "your_password");

    // Create our message.
    final message = Message()
      ..from = const Address("your@gmail.com", "Your Name")
      ..recipients.add("suhaibusman54@gmail.com")
      ..subject = "New Complaint Submitted"
      ..text = "A new complaint has been submitted.";

    try {
      // Send the email
      final sendReport = await send(message, smtpServer);

      print('Message sent: ' + sendReport.toString());
    } catch (e) {
      print('Error sending email: $e');
    }
  }

  void deleteComplain(String id) {
    String currentUid = FirebaseAuth.instance.currentUser!.uid;
    firestore
        .collection("users")
        .doc(currentUid)
        .collection("complain")
        .doc(id)
        .delete();
  }
  // void deleteComplain(String id) {
  //   // Assuming Complain class has an 'id' property
  //   complaints.removeWhere((complain) => complain.id == id);
  // }
}
