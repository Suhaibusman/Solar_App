import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/helper_widget.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class ComplaintConfirmationView extends StatelessWidget {
  const ComplaintConfirmationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarycolor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: ctext(
              text: "Confirmation Details",
              fontWeight: FontWeight.bold,
              color: white,
              fontSize: 20),
          leading: reusableBackButton(),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
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
                  Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        IconsConstants.checkIcon,
                        height: Get.height * 0.08,
                      )),
                  mediumSpace,
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 60.0, vertical: Get.height * 0.08),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            const Color(0xff616573),
                            Colors.black.withOpacity(.4),
                            const Color(0xff616573)
                          ],
                        ),
                      ),
                      child: ctext(
                          text: """Thank you for contacting us,
we will soon took into the matter!

Tracking Id:982017391""",
                          fontSize: 16,
                          color: white,
                          textAlign: TextAlign.center),
                    ),
                  ),
                  mediumSpace,
                  CustomButton(
                    borderRadius: BorderRadius.circular(50),
                    height: 70,
                    mywidth: 0.9,
                    onPressed: () {},
                    child: 'Complaint Submitted',
                    gradientColors: [
                      btnPrimaryColor,
                      Colors.black.withOpacity(.4),
                      Colors.black.withOpacity(.4),
                      btnPrimaryColor,
                    ],
                    color: const Color.fromARGB(255, 51, 55, 69),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        ImageConstants.confirmationImage,
                        height: Get.height * 0.25,
                      ))
                ]),
          ).paddingOnly(top: Get.height * 0.14)
        ]));
  }
}
