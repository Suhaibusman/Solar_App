import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  // Loading state
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDetails();
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> fetchDetails() async {
    try {
      isLoading.value =true;
      DocumentSnapshot snapshot =
          await firestore.collection("users").doc(userUid).get();
      if (snapshot.exists) {
        isLoading.value =false;
        emailController.text = snapshot.get("emailAddress");
        phoneController.text = snapshot.get("phoneNumber");
        addressController.text = snapshot.get("address");
      } else {
        isLoading.value =true;
        phoneController.clear();
        addressController.clear();
        // Handle the case where the document does not exist
        print("User document does not exist");
      }
    } catch (error) {
      isLoading.value =false;
      // Handle errors during data fetching
      print("Error fetching user details: $error");
    } finally {
     isLoading.value =false;
    }
  }

  void addPhoneAndAddress() {
    firestore.collection("users").doc(userUid).update({
      "phoneNumber": phoneController.text,
      "address": addressController.text,
    }).then((value) {
      // Handle success if needed
      Get.back();
    }).catchError((error) {
      // Handle update error
      print("Error updating user details: $error");
    });
  }
}
