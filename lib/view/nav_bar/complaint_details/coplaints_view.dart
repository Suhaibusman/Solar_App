import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solar_app/controller/complaint_controller.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/nav_bar.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  yourFunction(DocumentSnapshot doc) {
    Timestamp timestamp = doc['timestamp'];

    // Handle null case if needed
    DateTime complaintDate = timestamp.toDate();

    // Call the ctext function or use the formatted date as needed
    return ctext(
      text: DateFormat('yyyy-MM-dd HH:mm:ss').format(complaintDate),
      fontWeight: FontWeight.bold,
      fontSize: 11,
      color: Colors.grey.withOpacity(0.6),
    );

    // Or do something else with the complaintDate...
  }

  @override
  Widget build(BuildContext context) {
    ComplaintController complainController = Get.find<ComplaintController>();

    return Scaffold(
      backgroundColor: primarycolor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        leading: InkWell(
            onTap: () {
              Get.to(() => MyBottomNavbar());
            },
            child: Icon(Icons.arrow_back_ios_new, color: white)),
        title: ctext(
            text: "Complains",
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: white),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          SvgPicture.asset(
            SvgConstants.homeBg,
            width: Get.width,
            fit: BoxFit.fill,
          ),
          StreamBuilder<List<Map<String, dynamic>>>(
            stream: complainController.getComplains(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<Map<String, dynamic>> complainReports = snapshot.data!;
                if (complainReports.isEmpty) {
                  return const Center(child: Text("No Complain Found"));
                }

                return ListView.builder(
                  itemCount: complainReports.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> complainData = complainReports[index];

                    DateTime dateTime = complainData['timestamp']
                        .toDate(); // Convert timestamp to DateTime

                    return Card(
                      color: white,
                      elevation: 12,
                      shadowColor: btnPrimaryColor,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ctext(
                                text: complainData['title'],
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  complainController.deleteComplain(
                                      complainData['complaintNumber']);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey.withOpacity(.6),
                                ),
                              )
                            ],
                          ),
                          extraSmallSpace,
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 14,
                                color: Colors.grey.withOpacity(.6),
                              ),
                              ctext(
                                text: DateFormat('yyyy-MM-dd HH:mm:ss')
                                    .format(dateTime),
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.grey.withOpacity(.6),
                              ),
                            ],
                          ),
                          extraSmallSpace,
                          Row(
                            children: [
                              ctext(
                                text: "Status: ",
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                              ctext(
                                text: complainData['status'],
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          extraSmallSpace,
                          Row(
                            children: [
                              ctext(
                                text: "Progress: ",
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                              ctext(
                                text: complainData['progress'],
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: btnPrimaryColor,
                              ),
                              const Spacer(),
                            ],
                          )
                        ],
                      ).paddingOnly(left: 12, top: 12, bottom: 12, right: 12),
                    );
                  },
                );
                // ... (remaining code)
              } else {
                return ctext(
                    color: Colors.white,
                    text: "No Complain Found",
                    fontWeight: FontWeight.bold,
                    fontSize: 20);
              }
            },
          ),
        ],
      ),
    );
  }
}
