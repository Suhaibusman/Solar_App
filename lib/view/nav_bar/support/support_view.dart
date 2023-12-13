import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/support_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/nav_bar.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

// ignore: must_be_immutable
class SupportView extends StatelessWidget {
  SupportView({super.key});

  SupportController supportController = Get.put(SupportController());

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
                      InkWell(
                          onTap: () {
                            Get.to(() => MyBottomNavbar());
                          },
                          child: Icon(Icons.arrow_back_ios_new, color: white)),
                      smallSpaceh,
                      ctext(
                          text: 'Contact Us',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: white)
                    ],
                  ).paddingOnly(left: 20, right: 20, top: 20, bottom: 0),
                  largeSpace,
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      height: Get.height * 0.74,
                      width: Get.width * 0.88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          largeSpace,
                          smallSpace,
                          Image.asset(
                            ImageConstants.supportImage,
                            width: Get.width * 0.3,
                          ),
                          largeSpace,
                          ctext(
                              text: "Get Support",
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center,
                              fontSize: 19),
                          mediumSpace,
                          ctext(
                              text:
                                  "For any support request regards your orders or compaint please feel free to speak with us at below.",
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.center,
                              color: lightPrimaryTextColor,
                              fontSize: 13),
                          largeSpace,
                          largeSpace,
                          ctext(
                              text: "Call us: +92 7837XXXX",
                              fontWeight: FontWeight.w800,
                              textAlign: TextAlign.center,
                              color: primaryTextColor.withOpacity(.7),
                              fontSize: 13),
                          ctext(
                              text: "Mail us - solarpanel@gmail.com",
                              fontWeight: FontWeight.w800,
                              textAlign: TextAlign.center,
                              color: primaryTextColor.withOpacity(.7),
                              fontSize: 13),
                        ],
                      ),
                    ),
                  )
                ]),
          )
        ]));
  }
}
