import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaintainanceController extends GetxController {
  RxList<DateTime> selectedDates = <DateTime>[].obs;

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
    selectedDates.add(date);
  }

  void removeDate(DateTime date) {
    selectedDates.remove(date);
  }

  buildDefaultMultiDatePickerWithValue() {
    final DateTime currentDate = DateTime.now();
    final DateTime lastSelectableDate = currentDate.add(Duration(days: 10));
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
    Future.delayed(Duration(seconds: 2), () {
      loading.value = false;
      String currentUid = FirebaseAuth.instance.currentUser!.uid;
      List<Timestamp?> timestampList = selectedDates
          .map((date) => date != null ? Timestamp.fromDate(date) : null)
          .toList();
      FirebaseFirestore.instance
          .collection("maintainance")
          .doc(currentUid)
          .set({
        "date": timestampList,
        "price": price[initialIndex.value],
        "text": text[initialIndex.value],
      });
      Get.back();
    });
  }
}
