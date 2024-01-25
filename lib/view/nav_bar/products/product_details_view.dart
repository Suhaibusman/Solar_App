import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/product_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/helper_widget.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find<ProductController>();
    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: ctext(
                text: "Details",
                fontWeight: FontWeight.bold,
                color: white,
                fontSize: 20),
            leading: reusableBackButton(),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: primarycolor,
          body: Stack(children: [
            SvgPicture.asset(
              SvgConstants.homeBg,
              width: Get.width,
              fit: BoxFit.fill,
            ),
            CarouselSlider.builder(
              itemCount: productController.productImages.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Container(
                height: Get.height * 0.35,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            productController.productImages[itemIndex]),
                        // AssetImage(ImageConstants.monocrystalineImage),
                        fit: BoxFit.fill)),
              ),
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 01,
                aspectRatio: 2.0,
                initialPage: 2,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  height: Get.height * 0.72,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ctext(
                            text: "Monocrystalline solar panels",
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                        // ctext(
                        //     text: "w5-320Wp to W5-350Wp",
                        //     fontWeight: FontWeight.w500,
                        //     color: lightPrimaryTextColor,
                        //     fontSize: 13),
                        ctext(
                            text:
                                "If you are searching for the best solar panels in Pakistan for your solar system ,the intermark so,ar system are the best choice for you. Intermark solar system is a leading company in manufacturing monocrystalline Tier 1 solar panels in Pakistan as well as also a trustworthy company that offers a 25-year linear panel warranty",
                            fontWeight: FontWeight.w500,
                            color: lightPrimaryTextColor,
                            fontSize: 13),
                        mediumSpace,
                        ctext(
                            text: "Main Features",
                            fontWeight: FontWeight.w600,
                            color: btnPrimaryColor,
                            fontSize: 15),
                        // mediumSpace,
                        ctext(
                            text:
                                "• High efficiency: average 21% with wVrty PERC, black Silicon technology high power output and conversion efficiency up to 21.0% with half-cell technology",
                            fontWeight: FontWeight.w500,
                            color: lightPrimaryTextColor,
                            fontSize: 13),
                        smallSpace,
                        ctext(
                            text:
                                "• Anti-PID: Anti-LID,tested in accordance PID FREE to the IECC 62804",
                            fontWeight: FontWeight.w500,
                            color: lightPrimaryTextColor,
                            fontSize: 13),
                        smallSpace,
                        ctext(
                            text:
                                "• Better performace at low irradiance: LOW LIGHT higher yield, Better EL test results no cracks",
                            fontWeight: FontWeight.w500,
                            color: lightPrimaryTextColor,
                            fontSize: 13),
                        smallSpace,
                        ctext(
                            text:
                                "• Passing IEC61215 IEC6130 Dynamic mechanical load test",
                            fontWeight: FontWeight.w500,
                            color: lightPrimaryTextColor,
                            fontSize: 13),
                        smallSpace,
                        ctext(
                            text:
                                "• Full automatic Production line, all the process are under control and traceable",
                            fontWeight: FontWeight.w500,
                            color: lightPrimaryTextColor,
                            fontSize: 13),
                        mediumSpace,
                        InkWell(
                          onTap: () {
                            productController.openCompanyWebsite();
                          },
                          child: Center(
                            child: ctext(
                                text: "https://intermarkproduct.com/",
                                fontWeight: FontWeight.w600,
                                color: btnPrimaryColor,
                                fontSize: 15),
                          ),
                        ),
                        // ctext(

                        //     text: "72 cells Monocrystalline solar PV module",
                        //     fontWeight: FontWeight.w600,
                        //     color: btnPrimaryColor,
                        //     fontSize: 13),
                        mediumSpace,
                        // GridView.builder(
                        //   padding: EdgeInsets.zero,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   gridDelegate:
                        //       SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 3,
                        //     mainAxisSpacing: 5.0,
                        //     crossAxisSpacing: 5.0,
                        //     childAspectRatio: MediaQuery.of(context)
                        //             .size
                        //             .width *
                        //         .6 /
                        //         (MediaQuery.of(context).size.height * 0.25 / 1),
                        //   ),
                        //   itemCount: 6,
                        //   itemBuilder: (context, index) {
                        //     return Container(
                        //       decoration: BoxDecoration(
                        //           color: white,
                        //           borderRadius: BorderRadius.circular(25)),
                        //       child: Column(
                        //         children: [
                        //           Container(
                        //             height: 45,
                        //             width: 45,
                        //             decoration: BoxDecoration(
                        //                 border: Border.all(
                        //                     width: 1,
                        //                     color: lightPrimaryTextColor),
                        //                 borderRadius:
                        //                     BorderRadius.circular(35)),
                        //             child: Icon(Icons.add,
                        //                 color: lightPrimaryTextColor),
                        //           ),
                        //           extraSmallSpace,
                        //           ctext(
                        //               text: "Battery",
                        //               fontSize: 12,
                        //               fontWeight: FontWeight.w400,
                        //               color: lightPrimaryTextColor)
                        //         ],
                        //       ),
                        //     );
                        //   },
                        // ),
                        // smallSpace,
                        // ctext(
                        //     text: "Cell",
                        //     fontWeight: FontWeight.bold,
                        //     color: btnPrimaryColor,
                        //     fontSize: 16),
                        // ctext(
                        //     text:
                        //         "- 72 (1265) Monocrystalline solar PV module cillicon cell",
                        //     fontWeight: FontWeight.w500,
                        //     color: lightPrimaryTextColor,
                        //     fontSize: 11),
                        // ctext(
                        //     text: "- Minimum mon cracks 0.5",
                        //     fontWeight: FontWeight.w500,
                        //     color: lightPrimaryTextColor,
                        //     fontSize: 11),
                        // smallSpace,
                        // ctext(
                        //     text: "Frame",
                        //     fontWeight: FontWeight.bold,
                        //     color: btnPrimaryColor,
                        //     fontSize: 16),
                        // ctext(
                        //     text: "- 40 mm anodized aluminium alloy Robust",
                        //     fontWeight: FontWeight.w500,
                        //     color: lightPrimaryTextColor,
                        //     fontSize: 11),
                        // ctext(
                        //     text: "- 72 cells Monocrystalline solar PV module",
                        //     fontWeight: FontWeight.w500,
                        //     color: lightPrimaryTextColor,
                        //     fontSize: 11),
                        // smallSpace,
                        // ctext(
                        //     text: "Junction Box",
                        //     fontWeight: FontWeight.bold,
                        //     color: btnPrimaryColor,
                        //     fontSize: 16),
                        // ctext(
                        //     text:
                        //         "- 72 (1265) Monocrystalline solar PV module cillicon cell",
                        //     fontWeight: FontWeight.w500,
                        //     color: lightPrimaryTextColor,
                        //     fontSize: 11),
                        // ctext(
                        //     text: "- Better best, higher safely",
                        //     fontWeight: FontWeight.w500,
                        //     color: lightPrimaryTextColor,
                        //     fontSize: 11),
                        // mediumSpace
                      ],
                    ),
                  )),
            )
          ])),
    );
  }
}
