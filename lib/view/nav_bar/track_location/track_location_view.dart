import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class TrackLocationView extends StatelessWidget {
  const TrackLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(ImageConstants.mapImage),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Lottie.asset(ImageConstants.location),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  height: Get.height * 0.26,
                  width: Get.width * 1,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ctext(
                          text: "Track us",
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      ctext(
                          text: "We are here to solve your problems",
                          fontWeight: FontWeight.w500,
                          color: lightPrimaryTextColor,
                          fontSize: 12),
                      smallSpace,
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              ImageConstants.monocrystalineImage,
                              height: 70,
                              width: Get.width * 0.3,
                              fit: BoxFit
                                  .cover,
                            ),
                          ),
                          mediumSpaceh,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ctext(
                                  text: "Solar Comapny",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              extraSmallSpace,
                              SizedBox(
                                width: Get.width * 0.5,
                                child: Row(
                                  children: [
                                    ctext(
                                        text: "Message",
                                        fontWeight: FontWeight.w500,
                                        color: lightPrimaryTextColor,
                                        fontSize: 12),
                                    const Spacer(),
                                    Icon(CupertinoIcons.chat_bubble_2_fill,
                                        color: btnPrimaryColor),
                                    extraSmallSpace,
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.5,
                                child: Row(children: [
                                  ctext(
                                      text: "Call",
                                      fontWeight: FontWeight.w500,
                                      color: lightPrimaryTextColor,
                                      fontSize: 12),
                                  const Spacer(),
                                  Icon(CupertinoIcons.phone_circle_fill,
                                      color: btnPrimaryColor),
                                  extraSmallSpace,
                                ]),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
