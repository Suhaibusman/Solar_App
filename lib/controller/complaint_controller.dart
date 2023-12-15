// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:solar_app/data.dart';
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
  RxList<DocumentSnapshot> complainReports = <DocumentSnapshot>[].obs;
  RxList<DocumentSnapshot<Object?>> complaints = <DocumentSnapshot>[].obs;
  final databaseRef = FirebaseDatabase.instance.ref("complain");

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

  Stream<List<DocumentSnapshot>> getComplaintsStream() {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    String subcollectionName = box.read("currentloginedName");

    CollectionReference userComplain = firestore
        .collection("complain")
        .doc(userUID)
        .collection(subcollectionName);

    return userComplain.snapshots().map((querySnapshot) {
      // Convert QuerySnapshot to List<DocumentSnapshot>
      return querySnapshot.docs.toList();
    });
  }

  Future<List<Map<String, dynamic>>> getComplains() async {
    String loggedInUid = FirebaseAuth.instance.currentUser!.uid;

    CollectionReference userComplain = firestore.collection("complain");

    QuerySnapshot complainSnapshot = await userComplain.get();

    List<Map<String, dynamic>> complainDataList = [];

    if (complainSnapshot.docs.isNotEmpty) {
      complainSnapshot.docs.forEach((DocumentSnapshot document) {
        Map<String, dynamic> complainData =
            document.data() as Map<String, dynamic>;
        // Check if the 'uid' in the document matches the current logged-in UID
        if (complainData['uid'] == loggedInUid) {
          complainDataList.add(complainData);
        }
      });
    }

    return complainDataList;
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
          'uid': currentLoginUid,
          'title': titleController.text,
          'description': descriptionController.text,
          'status': selectedValue.value,
          'complaintNumber': complainNumber,
          'complainpicture': downloadUrl,
          'timestamp': FieldValue.serverTimestamp(),
          'progress': 'pending',
          'emailAddress': FirebaseAuth.instance.currentUser!.email,
        };

        // Add data to Firestore

        await firestore.collection("complain").add(complainData);

        // .add(complainData);
        // await firestore
        //     .collection("complain")
        //     .doc(userUid)
        //     .collection(box.read("currentloginedName"))
        //     .add(complainData);
        // await databaseRef
        //     .child(userUid)
        //     .child(box.read("currentloginedName"))
        //     .set(complainData);
        // await FirebaseDatabase.instance
        //     .ref("complain")
        //     .child(userUid)
        //     .child(box.read("currentloginedName"))
        //     .push()
        //     .set(complainData);
        // await firestore.collection("comp").add(complainData);
        loading.value = false;

        Get.snackbar("Complain Submitted", "Your Complain Has been submitted");
        Get.to(() => ComplaintConfirmationView(complainUid: complainNumber));
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

  void deleteComplain(String uid) async {
    try {
      String currentUid = FirebaseAuth.instance.currentUser!.uid;

      // Get a reference to the complain collection
      CollectionReference complainCollection = firestore.collection("complain");

      // Query for the document with the given 'uid' and the current logged-in UID
      QuerySnapshot querySnapshot =
          await complainCollection.where('uid', isEqualTo: currentUid).get();

      // Check if any document is found
      if (querySnapshot.docs.isNotEmpty) {
        // Delete the first document found (assuming 'uid' is unique)
        await querySnapshot.docs.first.reference.delete();

        // You might want to update your local list here as well
        complainReports.removeWhere((doc) => doc['uid'] == uid);

        Get.snackbar("Complain Deleted", "Your Complain has been Deleted");
      } else {
        Get.snackbar("Error", "Complain not found");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  // void deleteComplain(String id) {
  //   // Assuming Complain class has an 'id' property
  //   complaints.removeWhere((complain) => complain.id == id);
  // }
}
