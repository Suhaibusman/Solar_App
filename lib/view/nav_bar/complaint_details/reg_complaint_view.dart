import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/complaint_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/custom_button.dart';
import 'package:solar_app/utils/widgets/helper_widget.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

// ignore: must_be_immutable
class RegisterComplaintView extends StatelessWidget {
  RegisterComplaintView({super.key});

  ComplaintController complaintController = Get.put(ComplaintController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primarycolor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: ctext(
              text: "Complaint Details",
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
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
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
                    child: const TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Write the description of your complaint',
                        hintStyle: TextStyle(color: Colors.white),
                        alignLabelWithHint: true,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                      style: TextStyle(color: Colors.white), // Text color
                    ),
                  ),
                ),
                mediumSpace,
                CustomButton(
                  borderRadius: BorderRadius.circular(50),
                  height: 70,
                  mywidth: 0.9,
                  onPressed: () {
                    complaintController.lodgeComplain(context);
                  },
                  child: 'Lodge your complaint',
                  gradientColors: [
                    const Color(0xff616573),
                    Colors.black.withOpacity(.4),
                    const Color(0xff616573),
                  ],
                  color: const Color.fromARGB(255, 51, 55, 69),
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(ImageConstants.loginImage))
              ])).paddingOnly(top: Get.height * 0.14)
        ]));
  }
}
