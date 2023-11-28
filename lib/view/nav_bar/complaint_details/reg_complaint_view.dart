import 'package:dotted_border/dotted_border.dart';
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
              text: "New Complain",
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height * 0.87,
              width: Get.width * 1,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
                color: const Color(0xff192444).withOpacity(.4),
              ),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    mediumSpace,
                    ctext(
                        text: "Complain Title",
                        color: lightPrimaryTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    extraSmallSpace,
                    Container(
                      height: 50,
                      width: Get.width * 1,
                      decoration: BoxDecoration(
                          color: primarycolor,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Complain Title',
                          hintStyle: TextStyle(color: lightPrimaryTextColor),
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16.0),
                        ),
                        style:
                            const TextStyle(color: Colors.white),
                      ),
                    ),
                    smallSpace,
                    ctext(
                        text: "Description",
                        color: lightPrimaryTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    extraSmallSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [primarycolor, primarycolor],
                        ),
                      ),
                      child: TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Write the description of your complaint',
                          hintStyle: TextStyle(color: lightPrimaryTextColor),
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16.0),
                        ),
                        style:
                            const TextStyle(color: Colors.white),
                      ),
                    ),
                    smallSpace,
                    ctext(
                        text: "Status",
                        color: lightPrimaryTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    extraSmallSpace,
                    Container(
                        height: Get.height * 0.08,
                        width: Get.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primarycolor,
                        ),
                        child: Obx(
                          () => Row(
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    activeColor: btnPrimaryColor,
                                    value: 'Urgent',
                                    groupValue:
                                        complaintController.selectedValue.value,
                                    onChanged: (value) {
                                      complaintController.selectedValue.value =
                                          value!;
                                    },
                                  ),
                                  ctext(
                                      text: "Urgent",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: lightPrimaryTextColor),
                                ],
                              ),
                              smallSpaceh,
                              Row(
                                children: [
                                  Radio(
                                    activeColor: btnPrimaryColor,
                                    value: 'Medium',
                                    groupValue:
                                        complaintController.selectedValue.value,
                                    onChanged: (value) {
                                      complaintController.selectedValue.value =
                                          value!;
                                    },
                                  ),
                                  ctext(
                                      text: "Medium",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: lightPrimaryTextColor),
                                ],
                              ),
                              smallSpaceh,
                              Row(
                                children: [
                                  Radio(
                                    activeColor: btnPrimaryColor,
                                    value: 'Low',
                                    groupValue:
                                        complaintController.selectedValue.value,
                                    onChanged: (value) {
                                      complaintController.selectedValue.value =
                                          value!;
                                    },
                                  ),
                                  ctext(
                                      text: "Low",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: lightPrimaryTextColor),
                                ],
                              ),
                            ],
                          ),
                        )),
                    smallSpace,
                    ctext(
                        text: "Upload Photo",
                        color: lightPrimaryTextColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                    smallSpace,
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 15),
                        height: Get.height * 0.13,
                        width: Get.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: primarycolor,
                        ),
                        child: DottedBorder(
                          dashPattern: const [6, 3, 2, 3],
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(8),
                          color: btnPrimaryColor,
                          strokeWidth: 1,
                          borderPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add, color: lightPrimaryTextColor),
                                smallSpaceh,
                                ctext(
                                    text: "Photo",
                                    fontWeight: FontWeight.bold,
                                    color: lightPrimaryTextColor,
                                    fontSize: 13),
                              ],
                            ),
                          ),
                        )),
                    mediumSpace,
                    CustomButton(
                        borderRadius: BorderRadius.circular(15),
                        height: 43,
                        mywidth: 1,
                        onPressed: () {
                          complaintController.lodgeComplain(context);
                        },
                        child: 'Submit',
                        gradientColors: [btnPrimaryColor, btnSecondaryColor],
                        color: btnSecondaryColor),
                  ]).paddingSymmetric(horizontal: 16, vertical: 12)),
            ),
          )
        ]));
  }
}
