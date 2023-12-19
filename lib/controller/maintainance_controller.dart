// ignore_for_file: unnecessary_null_comparison

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solar_app/data.dart';

class MaintainanceController extends GetxController {
  RxList<DateTime> selectedDates = <DateTime>[].obs;

  String formatSelectedDates(RxList<DateTime> dates) {
    // Format the list of DateTime to display only the date
    List<String> formattedDates = dates.map((date) {
      return DateFormat('dd-MM-yyyy').format(date);
    }).toList();

    // Join the formatted dates into a single string
    return formattedDates.join(', ');
  }

  // List images = [
  //   ImageConstants.monocrystalineImage,
  //   ImageConstants.polycrystallineImage,
  //   ImageConstants.thinFilmImage,
  // ];
  List maintainanceIcons = [
    Icons.cleaning_services_rounded,
    Icons.battery_2_bar_rounded,
    Icons.inventory
  ];
  List price = ["15", "25", "35"];
  List text = ["Cleaning", "Battery", "Inventor"];
  RxInt initialIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
  RxBool loading = false.obs;
  void addDate(DateTime date) {
    date = DateTime(date.year, date.month, date.day);
    selectedDates.add(date);
  }

  void removeDate(DateTime date) {
    selectedDates.remove(date);
  }

  buildDefaultMultiDatePickerWithValue() {
    final DateTime currentDate = DateTime.now();
    final DateTime lastSelectableDate =
        currentDate.add(const Duration(days: 10));
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.single,
      currentDate: currentDate,
      firstDate: currentDate,
      lastDate: lastSelectableDate,
      selectedDayHighlightColor: Colors.indigo,
    );

    return CalendarDatePicker2(
      config: config,
      value: selectedDates,
      onValueChanged: (List<DateTime?> dates) {
        if (dates.isNotEmpty && dates.first != null) {
          // Assuming you want to add only the first selected date to the list
          selectedDates.clear();
          selectedDates.add(dates.first!);
        }
      },
    );
  }

  addMaintainance() {
    loading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      loading.value = false;
      String currentUid = FirebaseAuth.instance.currentUser!.uid;
      FirebaseFirestore.instance
          .collection("maintainance")
          .doc(currentUid)
          .set({
        "uid": currentUid,
        "date": formatSelectedDates(selectedDates),
        "price": price[initialIndex.value],
        "issue": text[initialIndex.value],
        "emailAddress": FirebaseAuth.instance.currentUser!.email,
        "phoneNumber": box.read("currentLoginedPhoneNumber"),
        "userName": box.read("currentloginedName"),
        "progress": "pending",
      });
      Get.back();
    });
  }

  Future<bool> checkMaintainanceInProgress() async {
    String currentUid = FirebaseAuth.instance.currentUser!.uid;
    try {
      // Check if the document with the current user's UID exists in the "maintainance" collection
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("maintainance")
          .doc(currentUid)
          .get();

      // Return true if the document exists, indicating maintainance is in progress
      return documentSnapshot.exists;
    } catch (e) {
      // Handle error
      // print('Error checking maintainance: $e');
      return false;
    }
  }
}
