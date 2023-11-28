// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/login_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/custom_textfield.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';
import 'package:solar_app/view/auth/signup/signup_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  LoginController loginController = Get.put(LoginController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primarycolor,
        body: Stack(
          children: [
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
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    top: Get.height * 0.06,
                    right: 20,
                    bottom: 10,
                  ),
                  width: double.maxFinite,
                  height: Get.height * 0.78,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(35),
                    ),
                    color: const Color(0xff0D1721).withOpacity(.7),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        smallSpace,
                        Center(
                          child: ctext(
                            text: "Welcome Back!",
                            fontWeight: FontWeight.bold,
                            color: white,
                            fontSize: 32,
                          ),
                        ),
                        Center(
                          child: ctext(
                            text: "welcome back wwe missed you",
                            fontWeight: FontWeight.w500,
                            color: lightPrimaryTextColor,
                            fontSize: 13,
                          ),
                        ),
                        mediumSpace,
                        ctext(
                          text: "Email Address",
                          fontWeight: FontWeight.w600,
                          color: lightPrimaryTextColor,
                          fontSize: 13,
                        ),
                        CustomBorderTextField(
                          isobscure: false,
                          controller: loginController.emailController,
                          hint: 'Email',
                          prefix: Icon(
                            Icons.email_outlined,
                            color: lightPrimaryTextColor,
                          ),
                          valid: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }

                            return null;
                          },
                        ),
                        smallSpace,
                        ctext(
                          text: "Password",
                          fontWeight: FontWeight.w600,
                          color: lightPrimaryTextColor,
                          fontSize: 13,
                        ),
                        Obx(() {
                          return CustomBorderTextField(
                           
                             isobscure: loginController.isPass.value,
                            controller: loginController.passwordController,
                            hint: 'Password',
                            prefix: Icon(
                              Icons.key,
                              color: lightPrimaryTextColor,
                            ),
                           suffixonTap: (){
                            loginController.isPass.value =!loginController.isPass.value;
                           }, suffix: loginController.isPass.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                                
                            // valid: (value) {
                            //   if (value!.isEmpty) {
                            //     return 'Please enter your password';
                            //   }
                            //   return null;
                            // },
                          );
                        }),
                        mediumSpace,
                        Obx(() {
                          return loginController.loading.value ?const Center(child: CircularProgressIndicator()): CustomButton(
                            borderRadius: BorderRadius.circular(15),
                            height: 43,
                            mywidth: 1,
                            onPressed: () {
                              loginController.loginWithEmailAndPassword();
                              // Get.to(MyBottomNavbar());
                            },
                            child: 'Sign in',
                            gradientColors: [
                              btnPrimaryColor,
                              btnSecondaryColor,
                            ],
                            color: btnSecondaryColor,
                          );
                        }),
                        smallSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 0.4,
                              ),
                            ),
                            extraSmallSpaceh,
                            ctext(
                              text: "Or sign up with",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: lightPrimaryTextColor,
                            ),
                            extraSmallSpaceh,
                            const Expanded(
                              child: Divider(
                                thickness: 0.4,
                              ),
                            ),
                          ],
                        ),
                        mediumSpace,
                        Center(
                          child: SizedBox(
                            height: 50,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: loginController.loginLogos.length,
                              itemBuilder: (context, index) {
                                final logos = loginController.loginLogos[index];
                                return Container(
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
                                  child: Image.asset(logos),
                                );
                              },
                            ),
                          ),
                        ),
                        smallSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ctext(
                              text: "Don't have an account? ",
                              fontWeight: FontWeight.w500,
                              color: lightPrimaryTextColor,
                              fontSize: 14,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(SignUpView());
                              },
                              child: ctext(
                                text: 'Sign up',
                                fontWeight: FontWeight.bold,
                                color: btnPrimaryColor,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
