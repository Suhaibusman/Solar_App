// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:solar_app/controller/home_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/helper_widget.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class HomeView extends StatelessWidget {
  final String userName;
  HomeView({
    Key? key,
    required this.userName,
  }) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: primarycolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: ctext(
            text: "Home",
            fontWeight: FontWeight.bold,
            color: white,
            fontSize: 20),
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundColor: btnPrimaryColor,
            child: Icon(
              Icons.notifications,
              color: white,
            ),
          ),
          smallSpaceh,
          InkWell(
            onTap: () {
              homeController.signout();
            },
            child: CircleAvatar(
              radius: 18,
              backgroundColor: btnPrimaryColor,
              child: Icon(
                Icons.exit_to_app,
                color: white,
              ),
            ),
          ),
          smallSpaceh,
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            SvgConstants.homeBg,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ctext(
                    text: "Hi $userName",
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: white),
                ctext(
                    text: "How can I help you?",
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: lightPrimaryTextColor),
                extraSmallSpace,
                Container(
                  height: 3,
                  width: 70,
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(25)),
                ),
                mediumSpace,
                Container(
                  height: Get.height * 0.75,
                  decoration: BoxDecoration(
                      color: const Color(0xff192444).withOpacity(.4),
                      borderRadius: BorderRadius.circular(30)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 45.0,
                      crossAxisSpacing: 35.0,
                      childAspectRatio: MediaQuery.of(context).size.width *
                          .9 /
                          (MediaQuery.of(context).size.height * 0.9 / 2),
                    ),
                    padding: EdgeInsets.only(top: Get.height * 0.05),
                    itemCount: homeController.grinImagesList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(homeController.pagesView[index]);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(homeController.grinImagesList[index]),
                              extraSmallSpace,
                              ctext(
                                  text: homeController.gridTextList[index],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ).paddingOnly(left: 20, right: 20),
          ).paddingOnly(top: Get.height * 0.1)
        ],
      ),
    );
  }
}
