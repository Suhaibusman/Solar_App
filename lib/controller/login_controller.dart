import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/constants/image_constant.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List loginLogos = [IconsConstants.googleIcon, IconsConstants.facebookIcon];
  RxBool isPass = true.obs;
}
