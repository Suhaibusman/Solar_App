import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool loading = false.obs;
RxBool isOldPassVissible = true.obs;
RxBool isNewPassVissible = true.obs;
RxBool isconfirmNewPassVissible = true.obs;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

// var auth = FirebaseAuth.instance;
// var currentUser = FirebaseAuth.instance.currentUser;
final FirebaseAuth _auth = FirebaseAuth.instance;
void changePassword()async{

loading.value = true;
String oldPass = oldPasswordController.text.toString().trim();
    String newPass = newPasswordController.text.toString().trim();
    String confirmNewPass = confirmNewPasswordController.text.toString().trim();

    if (oldPass == "" || newPass == "" || confirmNewPass == "") {
      Get.snackbar( "Change Password Error", "Please Fill All The Values");
      loading.value = false;
    }else   if (newPass != confirmNewPass) {
      Get.snackbar( "Change Password Error", "New Password and Retype Password not match");
      loading.value = false;
    }
 else {
  final User? user = _auth.currentUser;

    if (user != null) {
      try {
        loading.value = true;
        // Sign in the user with their current password for reauthentication
        final AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPasswordController.text,
        );

        await user.reauthenticateWithCredential(credential);

        // Change the password
        await user.updatePassword(newPasswordController.text);
        loading.value =false;
        // Clear the password fields
        oldPasswordController.clear();
        newPasswordController.clear();
        confirmNewPasswordController.clear();

        Get.snackbar("Password Change", "Password changed successfully!");
      } catch (e) {
        loading.value = false;
        Get.snackbar("Error", "Error changing password: $e");
      }
    } else {
      loading.value = false;
      Get.snackbar("Error", "No user found");
    }
  }

}
}

