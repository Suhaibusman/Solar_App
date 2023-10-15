import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primarycolor,
          body: Stack(children: [
            Container(
              child: SvgPicture.asset(
                SvgConstants.homeBg,
                width: Get.width,
                fit: BoxFit.fill,
              ),
            ),
            Container(
                height: Get.height * 0.8,
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Column(
                  children: [
                    Container(
                      height: Get.height * 0.35,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  ImageConstants.monocrystalineImage),
                              fit: BoxFit.fill)),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: white,
                        ),
                      ).paddingOnly(top: 30, left: 15),
                    ),
                    // Image.asset(ImageConstants.monocrystalineImage),
                    mediumSpace,
                    ctext(
                        text: "Monocrystalline solar panels",
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    smallSpace,
                    ctext(
                            text:
                                """If you see a solar panel with black cells, it’s most likely a monocrystalline panel. These cells appear black because of how light interacts with the pure silicon crystal.
    
    While the solar cells themselves are black, monocrystalline solar panels have a variety of colors for their back sheets and frames. The back sheet of the solar panel will most often be black, silver or white, while the metal frames are typically black or silver.""",
                            fontSize: 18)
                        .paddingSymmetric(horizontal: 20)
                  ],
                ))
          ])),
    );
  }
}
