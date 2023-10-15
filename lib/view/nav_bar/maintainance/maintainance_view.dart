import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/maintainance_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

// ignore: must_be_immutable
class MaintainanceView extends StatelessWidget {
  MaintainanceView({super.key});

  MaintainanceController maintainanceController =
      Get.put(MaintainanceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarycolor,
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: true,
          leading: Icon(Icons.arrow_back_ios_new, color: white),
          title: ctext(
              text: "Maintainance",
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: white),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.bgImage), fit: BoxFit.fill)),
          child: ListView(children: [
            largeSpace,
            Container(
              height: Get.height * 0.4,
              width: double.maxFinite,
              color: white,
              child:
                  maintainanceController.buildDefaultMultiDatePickerWithValue(),
            ),
            mediumSpace,
            Accordion(
              headerBorderColor: Colors.blueGrey,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColorOpened: Colors.green,
              contentBackgroundColor: Colors.white,
              contentBorderColor: Colors.green,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              leftIcon: CircleAvatar(
                backgroundColor: primarycolor,
                radius: 18,
              ),
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  isOpen: true,
                  contentVerticalPadding: 20,
                  leftIcon: const Icon(Icons.text_fields_rounded,
                      color: Colors.white),
                  header: ctext(
                      text: 'Cleaning',
                      fontWeight: FontWeight.bold,
                      color: white,
                      fontSize: 14),
                  content: ctext(text: "loremIpsum"),
                ),
              ],
            ),
            Accordion(
              headerBorderColor: Colors.blueGrey,
              headerBorderColorOpened: Colors.transparent,
              headerBackgroundColorOpened: Colors.green,
              contentBackgroundColor: Colors.white,
              contentBorderColor: Colors.green,
              contentBorderWidth: 3,
              contentHorizontalPadding: 20,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                  isOpen: true,
                  contentVerticalPadding: 20,
                  leftIcon: const Icon(Icons.text_fields_rounded,
                      color: Colors.white),
                  header: ctext(
                      text: 'Battery Change',
                      fontWeight: FontWeight.bold,
                      color: white,
                      fontSize: 14),
                  content: ctext(text: "loremIpsum"),
                ),
              ],
            ),
          ]),
        ));
  }
}
