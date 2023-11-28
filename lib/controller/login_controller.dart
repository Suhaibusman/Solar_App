import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_app/data.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/widgets/nav_bar.dart';
import 'package:solar_app/view/nav_bar/home/home_view.dart';


class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List loginLogos = [IconsConstants.googleIcon, IconsConstants.facebookIcon];
  RxBool isPass = true.obs;
  RxBool loading = false.obs;
   bool isLogined =false;
   loginWithEmailAndPassword() async {
  loading.value = true;
  String emailAddress = emailController.text.toString().trim();
  String password = passwordController.text.toString().trim();

  if (emailAddress == "" || password == "") {
    Get.snackbar(
        "Error",
        "Please Enter Username and Password");
    loading.value = false;
  } else {
    try {
      loading.value = true;
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      emailController.clear();
      passwordController.clear();
      // currentloginedUid = credential.user!.uid;
      box.write("currentloginedUid", credential.user!.uid);
      final userUid = credential.user!.uid;

      // Check if the user exists in the "user" collection
      DocumentSnapshot userSnapshot =
          await firestore.collection("users").doc(userUid).get();
      if (userSnapshot.exists) {
        // User is a regular user
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;

        box.write("currentloginedName", userData["username"]);
       

        currentLoginedName = box.read("currentloginedName");
       
       Get.offAll(()=> MyBottomNavbar());

        // Navigate to HomeScreen
        // Get.offAll(()=>HomeView(
        // userName: currentLoginedName ?? box.read("currentloginedName"),
        // ));
        box.write("isLogined", true);
          isLogined=true;
        //   Navigator.popUntil(context, (route) => route.isFirst);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => HomePage(
        // userNames: currentLoginedName ?? box.read("currentloginedName"),
        // )
        //   ),
        // );
      } else {
        Get.snackbar(
            "Login Error",
            "You are not a registered user");
        // Handle the case where the user is not found in the "user" collection
      }
    } catch (e) {
      Get.snackbar(
          "Error",
          e.toString(),
      );
    }
  }
  loading.value = false;
}

}
