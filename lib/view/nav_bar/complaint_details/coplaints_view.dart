import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:solar_app/controller/complaint_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';
import 'package:solar_app/view/nav_bar/complaint_details/reg_complaint_view.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    ComplaintController complainController = Get.find<ComplaintController>();
    return Scaffold(
      backgroundColor: primarycolor,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: Icon(Icons.arrow_back_ios_new, color: white),
        title: ctext(
            text: "Complains",
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: white),
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            onTap: () {
              Get.to(() => RegisterComplaintView());
            },
            child: CircleAvatar(
              radius: 16,
              backgroundColor: btnPrimaryColor,
              child: Icon(Icons.add, color: white),
            ),
          ),
          mediumSpaceh
        ],
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: complainController.getComplains(),
        builder: (context , snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
      }else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    }
          else if (snapshot.hasData) {
     
      List<DocumentSnapshot<Object?>>? complainReports = snapshot.data;
 if (complainReports!.isEmpty) {
              return const Center(child: Text( "No Complain Found"));
            }
      return ListView.builder(
        itemCount: complainReports.length,
        itemBuilder: (context, index) {
          DocumentSnapshot doc = complainReports[index];
          // Build the UI for displaying favorite doctors
          return Card(
                  color: white,
                  elevation: 12,
                  shadowColor: btnPrimaryColor,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ctext(
                              text: doc["title"],
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black),
                          const Spacer(),
                          Icon(
                            Icons.delete,
                            color: Colors.grey.withOpacity(.6),
                          )
                        ],
                      ),
                      extraSmallSpace,
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined,
                              size: 14, color: Colors.grey.withOpacity(.6)),
                          ctext(
                              text: " Date: Noc 10 2023",
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: Colors.grey.withOpacity(.6)),
                        ],
                      ),
                      extraSmallSpace,
                      Row(
                        children: [
                          ctext(
                              text: "Status: ",
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                          ctext(
                              text: "Pending",
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: Colors.red),
                        ],
                      ),
                      extraSmallSpace,
                      Row(
                        children: [
                          ctext(
                              text: "Progress: ",
                              fontWeight: FontWeight.bold,
                              fontSize: 11),
                          ctext(
                              text: "Done",
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: btnPrimaryColor),
                          const Spacer(),
                          RatingBar.builder(
                            itemSize: 16,
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 0.2),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 13,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      )
                    ],
                  ).paddingOnly(left: 12, top: 12, bottom: 12, right: 12),
                );
               },
      );
    } else {
      return const Text('No favorite doctors found.');
    }}
      ),
    );
  }
}
