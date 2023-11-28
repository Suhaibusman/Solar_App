import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
RxBool isOldPassVissible = true.obs;
RxBool isNewPassVissible = true.obs;
RxBool isconfirmNewPassVissible = true.obs;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
}
