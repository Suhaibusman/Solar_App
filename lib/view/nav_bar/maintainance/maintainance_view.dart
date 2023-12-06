import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/maintainance_controller.dart';
import 'package:solar_app/data.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/helper_widget.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

// ignore: must_be_immutable
class MaintainanceView extends StatelessWidget {
  MaintainanceView({super.key});

  MaintainanceController maintainanceController =
      Get.put(MaintainanceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primarycolor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          automaticallyImplyLeading: true,
          leading: reusableBackButton(),
          title: ctext(
              text: "Maintainance",
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: white),
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
          future: maintainanceController.checkMaintainanceInProgress(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while checking
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Handle error
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              bool isInProgress = snapshot.data as bool;
              if (isInProgress) {
                // Show Maintenance in Progress page
                return const Center(child: Text('Maintainance in Progress '));
              } else {
                // Show your regular page
                return buildRegularPage();
              }
            }
          },
        ),
      ),
    );
  }

  Widget buildRegularPage() {
    return Stack(
      children: [
        SvgPicture.asset(
          SvgConstants.homeBg,
          width: Get.width,
          fit: BoxFit.fill,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow),
                ctext(
                    text: " 4.1",
                    fontWeight: FontWeight.w600,
                    color: white,
                    fontSize: 17),
              ],
            ),
            extraSmallSpace,
            ctext(
                text: "Solar Panel Service",
                fontWeight: FontWeight.w700,
                color: white,
                fontSize: 17),
            extraSmallSpace,
            Obx(() {
              return ctext(
                  text:
                      "Pricing: \$ ${maintainanceController.price[maintainanceController.initialIndex.value]}",
                  fontWeight: FontWeight.w600,
                  color: white,
                  fontSize: 15);
            }),
          ],
        ).paddingOnly(top: Get.height * 0.1, left: 20, right: 20),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            ImageConstants.loginImage,
            height: Get.height * 0.14,
          ).paddingOnly(top: Get.height * 0.12, right: 20),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Get.height * 0.65,
            width: Get.width * 1,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
              color: white,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mediumSpace,
                  ctext(
                      text: "Select Service",
                      fontWeight: FontWeight.w700,
                      fontSize: 17),
                  extraSmallSpace,
                  SizedBox(
                    height: Get.height * 0.12,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          bool isSelected = index ==
                              maintainanceController.initialIndex.value;
                          return GestureDetector(
                            onTap: () {
                              maintainanceController.initialIndex.value = index;
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              height: Get.height * 0.12,
                              width: Get.width * 0.24,
                              decoration: BoxDecoration(
                                color: lightPrimaryTextColor.withOpacity(.3),
                                borderRadius: BorderRadius.circular(13),
                                border: isSelected
                                    ? Border.all(
                                        width: 2, color: btnPrimaryColor)
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    maintainanceController
                                        .maintainanceIcons[index],
                                    size: 35,
                                    color: lightPrimaryTextColor,
                                  ),
                                  extraSmallSpace,
                                  ctext(
                                    text: maintainanceController.text[index],
                                    fontSize: 11,
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  ),
                  mediumSpace,
                  ctext(
                      text: "Select Date",
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                  ctext(
                      text: "select according to your availability",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lightPrimaryTextColor),
                  const Divider(),
                  Container(
                    padding: EdgeInsets.zero,
                    height: Get.height * 0.33,
                    width: double.maxFinite,
                    color: white,
                    child: maintainanceController
                        .buildDefaultMultiDatePickerWithValue(),
                  ),
                  const Divider(),
                  mediumSpace,
                  Obx(() {
                    return maintainanceController.loading.value
                        ? const Center(child: CircularProgressIndicator())
                        : CustomButton(
                            borderRadius: BorderRadius.circular(15),
                            height: 43,
                            mywidth: 1,
                            onPressed: () {
                              (box.read("currentLoginedPhoneNumber") == "" ||
                                      box.read("address") == "")
                                  ? Get.snackbar("Error",
                                      "Please Add Phone Number in Profile")
                                  : maintainanceController.addMaintainance();
                            },
                            child: 'Submit',
                            gradientColors: [
                              btnPrimaryColor,
                              btnSecondaryColor
                            ],
                            color: btnSecondaryColor);
                  }),
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 12),
            ),
          ),
        )
      ],
    );
  }
}
