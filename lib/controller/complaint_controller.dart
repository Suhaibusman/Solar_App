// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';
import 'package:solar_app/view/nav_bar/complaint_details/complaint_confirmation_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ComplaintController extends GetxController {
  var selectedValue = 'Urgent'.obs;

final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<DateTime> selectedDates = <DateTime>[].obs;
  RxString imagePath = "".obs;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String status = "Pending"; // Default status
  String userUid = FirebaseAuth.instance.currentUser!.uid;
  List<DateTime> multiDatePickerValueWithDefaultValue = [];

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


  void lodgeComplain(context) {
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
                    onRatingUpdate: (rating) {},
                  ),
                ),
                mediumSpace,
                CustomButton(
                  borderRadius: BorderRadius.circular(15),
                  height: 43,
                  mywidth: 1,
                  onPressed: () {
                    Get.to(const ComplaintConfirmationView());
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
  
  

  

  void addComplain() async {
  try {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      Get.snackbar("Complain Error", "Please fill in all the values");
    } else if (imagePath.isEmpty) {
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
          .add(complainData);

      // Clear text fields after submitting the complaint
      titleController.clear();
      descriptionController.clear();
    }
  } catch (e) {
    Get.snackbar("Error", e.toString());
  }
}
 String generateComplaintNumber() {
    // Generate a random complaint number based on current timestamp
    DateTime now = DateTime.now();
    String timestamp = now.microsecondsSinceEpoch.toString();
    return 'CMP$timestamp';
  }
  
  Future getImage()async{
    final ImagePicker picker= ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      imagePath.value = image.path.toString();
    }
  }
}


 

