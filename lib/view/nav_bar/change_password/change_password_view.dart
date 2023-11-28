// ignore_for_file: must_be_immutable

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
                          isobscure: changePasswordController.isOldPassVissible.value,
                           onSuffixTap: (){
                            changePasswordController.isOldPassVissible.value =!changePasswordController.isOldPassVissible.value;
                          },
                          suffixIcon: changePasswordController.isOldPassVissible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            controller:
                                changePasswordController.oldPasswordController,
                            hint: "**********",
                            type: TextInputType.emailAddress),
                        largeSpace,
                        ctext(text: "New Password"),
                        CustomUnderLineTextField(
                          onSuffixTap: (){
                            changePasswordController.isNewPassVissible.value =!changePasswordController.isNewPassVissible.value;
                          },
                          suffixIcon: changePasswordController.isNewPassVissible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                                
                          isobscure: changePasswordController.isNewPassVissible.value,
                            controller:
                                changePasswordController.newPasswordController,
                            hint: "**********",
                            type: TextInputType.emailAddress),
                        largeSpace,
                        ctext(text: "Retype Password"),
                        CustomUnderLineTextField(
                           onSuffixTap: (){
                            changePasswordController.isconfirmNewPassVissible.value =!changePasswordController.isconfirmNewPassVissible.value;
                          },
                          suffixIcon: changePasswordController.isconfirmNewPassVissible.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            isobscure: changePasswordController.isconfirmNewPassVissible.value,
                            controller:
                                changePasswordController.confirmNewPasswordController,
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
