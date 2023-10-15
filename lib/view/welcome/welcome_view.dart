import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';
import 'package:solar_app/view/auth/login/login_view.dart';
import 'package:solar_app/view/auth/signup/signup_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primarycolor,
      body: Stack(
        children: [
          Image.asset(ImageConstants.welcome),
          Image.asset(
            ImageConstants.ellipseLeft,
            width: Get.width * 0.4,
          ).paddingOnly(top: Get.height * 0.58),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(ImageConstants.ellipseBottom)
                .paddingOnly(top: Get.height * 0.9),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ctext(
                  text: "Get Started",
                  fontSize: 40.33,
                  fontWeight: FontWeight.w600,
                  color: white,
                  textAlign: TextAlign.center),
              Center(
                child: ctext(
                    text: "Now book your all solar related services at a click",
                    fontSize: 13.33,
                    fontWeight: FontWeight.w500,
                    color: lightPrimaryTextColor,
                    textAlign: TextAlign.center),
              ),
              largeSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                      borderRadius: BorderRadius.circular(15),
                      height: 43,
                      mywidth: 0.36,
                      onPressed: () {
                        Get.to(SignUpView());
                      },
                      child: 'Sign up',
                      gradientColors: [btnPrimaryColor, btnSecondaryColor],
                      color: btnSecondaryColor),
                  mediumSpaceh,
                  CustomButton(
                      borderRadius: BorderRadius.circular(15),
                      height: 43,
                      mywidth: 0.36,
                      onPressed: () {
                        Get.to(LoginView());
                      },
                      child: 'Sign in',
                      gradientColors: [btnPrimaryColor, btnSecondaryColor],
                      color: btnSecondaryColor)
                ],
              )
            ],
          ).paddingOnly(top: Get.height * 0.74)
        ],
      ),
    );
  }
}
