import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/constants/image_constant.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  List signUpLogos = [IconsConstants.googleIcon, IconsConstants.facebookIcon];
}
