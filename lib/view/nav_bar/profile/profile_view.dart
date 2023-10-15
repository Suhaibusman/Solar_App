import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/profile_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_textfield.dart';
import 'package:solar_app/utils/widgets/helper_widget.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarycolor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: ctext(
              text: "Profile",
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
                  Center(
                    child: Container(
                      padding: const EdgeInsets.only(
                          right: 15, left: 15, top: 15, bottom: 15),
                      height: Get.height * 0.78,
                      width: Get.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          mediumSpace,
                          Container(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.6, color: lightPrimaryTextColor),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: ListTile(
                                minVerticalPadding: 0.0,
                                leading: Container(
                                  height: 70,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: .3),
                                 ),
                                ),
                                title: ctext(
                                    text: "Your Name",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13),
                                subtitle: ctext(
                                    text: "Client No: 0",
                                    fontWeight: FontWeight.w400,
                                    color: lightPrimaryTextColor,
                                    fontSize: 12),
                                trailing: const Icon(Icons.camera_alt),
                              )),
                          largeSpace,
                          ctext(text: "Your Mail ID"),
                          CustomUnderLineTextField(
                              controller: profileController.emailController,
                              hint: "abc@gmail.com",
                              type: TextInputType.emailAddress),
                          largeSpace,
                          ctext(text: "Phone Number"),
                          CustomUnderLineTextField(
                              controller: profileController.emailController,
                              hint: "+92 332 283628",
                              type: TextInputType.emailAddress),
                          largeSpace,
                          ctext(text: "Address"),
                          CustomUnderLineTextField(
                              controller: profileController.emailController,
                              hint: "abc street, Apt R-42, pechs society",
                              type: TextInputType.emailAddress),
                        ],
                      ),
                    ),
                  ),
                  largeSpace,
                ]),
          ).paddingOnly(top: Get.height * 0.14)
        ]));
  }
}
