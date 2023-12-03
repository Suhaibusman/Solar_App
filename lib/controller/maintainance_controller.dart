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
  List price = ["15", "25", "35"];
  List text = ["Cleaning", "Battery", "Inventor"];
  RxInt initialIndex = 0.obs;
  RxInt selectedIndex = 0.obs;
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
      // ignore: unnecessary_null_comparison
      value: selectedDates.where((date) => date != null).toList(),
      onValueChanged: (dates) {},
    );
  }
}
