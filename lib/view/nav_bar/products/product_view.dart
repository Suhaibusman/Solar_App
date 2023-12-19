import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/product_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';
import 'package:solar_app/view/nav_bar/products/product_details_view.dart';

// ignore: must_be_immutable
class ProductView extends StatelessWidget {
  ProductView({super.key});
  ProductController productController = Get.put(ProductController());
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
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                mediumSpace,
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(Icons.arrow_back_ios_new, color: white)),
                    smallSpaceh,
                    ctext(
                        text: 'Products',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: white)
                  ],
                ).paddingOnly(left: 20, right: 20, top: 20, bottom: 40),
                Expanded(
                    child: InkWell(
                  onTap: () {
                    Get.to(const ProductDetailsView());
                  },
                  child: ListView.builder(
                      itemCount: productController.productname.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: const EdgeInsets.only(
                                top: 20, left: 15, right: 0, bottom: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: .4, color: lightPrimaryTextColor)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ctext(
                                    text: productController.productname[index],
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                    fontSize: 13),
                                smallSpace,
                                ListTile(
                                  minVerticalPadding: 0.0,
                                  leading: Container(
                                    height: 116,
                                    width: 94,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          productController
                                              .productImages[index],
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: ctext(
                                      text:
                                          productController.productTitle[index],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: white),
                                  subtitle: ctext(
                                          text: productController
                                              .productDescription[index],
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: lightPrimaryTextColor)
                                      .paddingOnly(right: 10),
                                )
                              ],
                            )).paddingOnly(bottom: 20);
                      }),
                ))
              ])
        ]));
  }
}
