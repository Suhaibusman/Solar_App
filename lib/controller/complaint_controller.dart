import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';
import 'package:solar_app/view/nav_bar/complaint_details/complaint_confirmation_view.dart';

class ComplaintController extends GetxController {
  RxList<DateTime> selectedDates = <DateTime>[].obs;
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
      onValueChanged: (dates) {
        },
    );
  }

  String _getValueText(CalendarDatePicker2Type type, List<DateTime> dates) {
    return dates.map((date) => date.toLocal().toString()).join(", ");
  }

  void lodgeComplain(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(25)
             ),
          child: ListView(children: [
            smallSpace,
            ctext(
                text: "Select Date", fontSize: 18, fontWeight: FontWeight.bold),
            ctext(
                text: "select according to your availability",
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: lightPrimaryTextColor),
            smallSpace,
            Container(
              height: Get.height * 0.33,
              width: double.maxFinite,
              color: white,
              child: buildDefaultMultiDatePickerWithValue(),
            ),
            mediumSpace,
            CustomButton(
              borderRadius: BorderRadius.circular(15),
              height: 43,
              mywidth: 1,
              onPressed: () {
                Get.to(ComplaintConfirmationView());
              },
              child: 'Submit',
              gradientColors: [
                btnPrimaryColor,
                btnSecondaryColor,
              ],
              color: btnSecondaryColor,
            ),
            ]).paddingSymmetric(horizontal: 15, vertical: 10),
        );
      },
    );
  }
}
