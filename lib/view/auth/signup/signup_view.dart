// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/signup_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/custom_textfield.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  SignUpController signUpController = Get.put(SignUpController());

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
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              ImageConstants.loginImage,
              width: Get.width * 0.47,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 10, right: 20, bottom: 20),
              width: double.maxFinite,
              height: Get.height * 0.8,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                ),
                color: const Color(0xff0D1721).withOpacity(.7),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    smallSpace,
                    Center(
                      child: ctext(
                          text: "Get Started Free",
                          fontWeight: FontWeight.bold,
                          color: white,
                          fontSize: 32),
                    ),
                    Center(
                      child: ctext(
                          text: "Free Forever. No Credit Card Needed",
                          fontWeight: FontWeight.w500,
                          color: lightPrimaryTextColor,
                          fontSize: 13),
                    ),
                    mediumSpace,
                    ctext(
                        text: "Name",
                        fontWeight: FontWeight.w600,
                        color: lightPrimaryTextColor,
                        fontSize: 13),
                    CustomBorderTextField(
                        isobscure: false,
                        controller: signUpController.nameController,
                        hint: 'Name',
                        prefix: Icon(Icons.email_outlined,
                            color: lightPrimaryTextColor)),
                    smallSpace,
                    ctext(
                        text: "Email Address",
                        fontWeight: FontWeight.w600,
                        color: lightPrimaryTextColor,
                        fontSize: 13),
                    CustomBorderTextField(
                        isobscure: false,
                        controller: signUpController.emailController,
                        hint: 'Email Address',
                        prefix: Icon(Icons.person_2_outlined,
                            color: lightPrimaryTextColor)),
                    smallSpace,
                    ctext(
                        text: "Password",
                        fontWeight: FontWeight.w600,
                        color: lightPrimaryTextColor,
                        fontSize: 13),
                    Obx(() {
                      return CustomBorderTextField(
                          isobscure: signUpController.isPassVisible.value,
                          controller: signUpController.passwordController,
                          hint: 'Password',
                          suffixonTap: () {
                            signUpController.isPassVisible.value =
                                !signUpController.isPassVisible.value;
                          },
                          suffix: signUpController.isPassVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          prefix:
                              Icon(Icons.key, color: lightPrimaryTextColor));
                    }),
                    mediumSpace,
                    Obx(() {
                      return signUpController.loading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                              borderRadius: BorderRadius.circular(15),
                              height: 43,
                              mywidth: 1,
                              onPressed: () {
                                signUpController.signUpWithEmailAndPassword();
                              },
                              child: 'Sign up',
                              gradientColors: [
                                btnPrimaryColor,
                                btnSecondaryColor
                              ],
                              color: btnSecondaryColor);
                    }),
                    smallSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(
                            child: Divider(
                          thickness: 0.4,
                        )),
                        extraSmallSpaceh,
                        ctext(
                            text: "Or sign up with",
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: lightPrimaryTextColor),
                        extraSmallSpaceh,
                        const Expanded(
                            child: Divider(
                          thickness: 0.4,
                        )),
                      ],
                    ),
                    mediumSpace,
                    Center(
                      child: SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  signUpController.signInWithGoogle();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(right: 25),
                                  height: 40,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      width: .5,
                                      color: lightPrimaryTextColor,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.grey.withOpacity(.3),
                                        const Color(0xff353C43),
                                        const Color(0xff222A33),
                                        const Color(0xff19232D),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(IconsConstants.googleIcon),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  signUpController.signInWithFacebook();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.only(right: 25),
                                  height: 40,
                                  width: 65,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(
                                      width: .5,
                                      color: lightPrimaryTextColor,
                                    ),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Colors.grey.withOpacity(.3),
                                        const Color(0xff353C43),
                                        const Color(0xff222A33),
                                        const Color(0xff19232D),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child:
                                      Image.asset(IconsConstants.facebookIcon),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          )
        ]));
  }
}
