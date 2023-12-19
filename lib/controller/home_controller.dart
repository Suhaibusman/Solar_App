import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:solar_app/data.dart';
import 'package:solar_app/notifications/firebase_notifications.dart';
import 'package:solar_app/notifications/notification.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/view/nav_bar/change_password/change_password_view.dart';
import 'package:solar_app/view/nav_bar/chat_view/chat_view.dart';
import 'package:solar_app/view/nav_bar/complaint_details/reg_complaint_view.dart';
import 'package:solar_app/view/nav_bar/maintainance/maintainance_view.dart';
import 'package:solar_app/view/nav_bar/products/product_view.dart';
import 'package:solar_app/view/nav_bar/support/support_view.dart';
import 'package:solar_app/view/splash/splash_view.dart';

class HomeController extends GetxController {
  List gridTextList = [
    "Product",
    "Chatbot",
    "Complaint",
    "Maintainance",
    "Contact Us",
    "Change Password"
  ];

  List grinImagesList = [
    IconsConstants.productIcon,
    IconsConstants.botIcon,
    IconsConstants.complaintIcon,
    IconsConstants.calenderIcon,
    IconsConstants.contactusIcon,
    IconsConstants.passwordIcon,
  ];

  List pagesView = [
    ProductView(),
    ChatScreen(),
    RegisterComplaintView(),
    MaintainanceView(),
    SupportView(),
    ChangePasswordView()
  ];

  Notification notification = Notification();
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   notification.requestNotificationPermissions();
  // }

  void signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      box.remove("currentLoginUsername");
      box.remove("currentLoginedPhoneNumber");
      box.remove("currentloginedUid");
      box.remove("address");

      box.remove("isLogined");
      box.erase();

      Get.offAll(const SplashScreen());
    } catch (e) {}
  }

  Future<void> checkMaintenanceDate() async {
    // Get the current user's UID
    String currentUid = FirebaseAuth.instance.currentUser!.uid;

    // Get the Firestore document for the current user
    DocumentSnapshot maintenanceDoc = await FirebaseFirestore.instance
        .collection('maintainance')
        .doc(currentUid)
        .get();

    // Check if the document exists and has a 'date' field
    if (maintenanceDoc.exists && maintenanceDoc.data() != null) {
      dynamic dateData = maintenanceDoc.data();

      // Check if 'date' is a List and contains valid timestamp data
      if (dateData is List<dynamic> && dateData.isNotEmpty) {
        Timestamp timestamp = dateData.first;
        DateTime maintenanceDate = timestamp.toDate();

        // Check if maintenanceDate is tomorrow
        if (isTomorrow(maintenanceDate)) {
          // Show notification
          await NotificationService.showNotification(
            title: 'Maintenance Alert',
            body: 'Tomorrow is your maintenance',
          );
        }
      }
    }
  }

  bool isTomorrow(DateTime date) {
    DateTime tomorrow = DateTime.now().add(Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }
}
