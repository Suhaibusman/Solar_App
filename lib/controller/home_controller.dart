import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:solar_app/data.dart';
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

  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   super.onInit();
  //   checkMaintenanceDate();
  // }

  RxBool isNotificationEnabled =
      false.obs; // Track notification status as observable

  // void toggleNotificationStatus() async {
  //   // Toggle notification status
  //   isNotificationEnabled.value = !isNotificationEnabled.value;

  //   // Toggle notification permission
  //   if (isNotificationEnabled.value) {
  //     await NotificationService.enableNotifications();
  //   } else {
  //     await NotificationService.disableNotifications();
  //   }
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

  void checkMaintenanceDate() async {
    // Get the current user's UID
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Reference to the Firestore collection
    var maintenanceDocRef =
        FirebaseFirestore.instance.collection("maintainance").doc(uid);

    // Get the document snapshot
    var docSnapshot = await maintenanceDocRef.get();

    // Check if the document exists and contains the 'date' field
    if (docSnapshot.exists &&
        docSnapshot.data() != null &&
        docSnapshot.data()!['date'] != null) {
      // Get the maintenance date from the document
      String maintenanceDate = docSnapshot.data()!['date'];

      // Get tomorrow's date
      DateTime tomorrow = DateTime.now().add(Duration(days: 1));
      String tomorrowDate =
          "${tomorrow.day}-${tomorrow.month}-${tomorrow.year}";

      // Compare the dates
      if (maintenanceDate == tomorrowDate) {
        // If the dates match, show a notification
        NotificationService.showNotification(
            title: "Maintenance Alert", body: "Tommorow is your maintenance");
      }
    }
  }
}
