import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MaintainanceController extends GetxController {
  RxList<DateTime> selectedDates = <DateTime>[].obs;
  List<DateTime> multiDatePickerValueWithDefaultValue = [];

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

  List text = ["Cleaning", "Battery", "Inventor"];
  RxInt initialIndex = 0.obs;

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
      // ignore: unnecessary_null_comparison
      value: selectedDates.where((date) => date != null).toList(),
      onValueChanged: (dates) {},
    );
  }
}
