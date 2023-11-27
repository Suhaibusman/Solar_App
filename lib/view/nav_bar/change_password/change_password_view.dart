import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/change_password-controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/custom_textfield.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});

  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarycolor,
        body: Stack(children: [
          SvgPicture.asset(
            SvgConstants.homeBg,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  mediumSpace,
                  Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: white,
                      ),
                      smallSpaceh,
                      ctext(
                          text: 'Change Password',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: white)
                    ],
                  ).paddingOnly(left: 20, right: 20, top: 20, bottom: 40),
                  largeSpace,
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    height: Get.height * 0.69,
                    width: Get.width * 0.88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        largeSpace,
                        ctext(text: "Old Password"),
                        CustomUnderLineTextField(
                            controller:
                                changePasswordController.emailController,
                            hint: "**********",
                            type: TextInputType.emailAddress),
                        largeSpace,
                        ctext(text: "New Password"),
                        CustomUnderLineTextField(
                            controller:
                                changePasswordController.emailController,
                            hint: "**********",
                            type: TextInputType.emailAddress),
                        largeSpace,
                        ctext(text: "Retype Password"),
                        CustomUnderLineTextField(
                            controller:
                                changePasswordController.emailController,
                            hint: "**********",
                            type: TextInputType.emailAddress),
                        largeSpace,
                        Center(
                          child: CustomButton(
                              borderRadius: BorderRadius.circular(15),
                              height: 43,
                              mywidth: 0.75,
                              onPressed: () {},
                              child: 'Change Password',
                              gradientColors: [
                                btnPrimaryColor,
                                btnSecondaryColor
                              ],
                              color: btnSecondaryColor),
                        ),
                      ],
                    ),
                  )
                ]),
          )
        ]));
  }
}
