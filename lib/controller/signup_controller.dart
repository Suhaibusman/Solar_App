import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/constants/image_constant.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  List signUpLogos = [IconsConstants.googleIcon, IconsConstants.facebookIcon];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool loading = false.obs;
  RxBool isPassVisible = true.obs;
  signUpWithEmailAndPassword(
      ) async {
        loading.value =true;
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String userName = nameController.text.toString().trim();

    if (emailAddress == "" || password == "" || userName == "") {
      Get.snackbar( "Sign up Error", "Please Fill All The Values");
     loading.value = false;
    }  else {
      try {
         loading.value = true;
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        await firestore.collection("users").doc(credential.user!.uid).set({
          "username": userName,
          "emailAddress": emailAddress,
          "Password": password
        });
        if (credential.user != null) {
           loading.value = false;
          Get.snackbar( "Sign Up Successfully",
              "The User With This Email: $emailAddress is Registered Successfully");
          emailController.clear();
          passwordController.clear();
          nameController.clear();
        }
      } on FirebaseAuthException catch (e) {
    loading.value = false;
        Get.snackbar( "Error", e.toString());
      } catch (e) {
        loading.value = false;
        Get.snackbar( "Error", e.toString());
      }
    }
}}
