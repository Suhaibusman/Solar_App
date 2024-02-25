// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxString imagePath = "".obs;
  final userUid = FirebaseAuth.instance.currentUser!.uid;

  // Loading state
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDetails();
    getProfileImage();
  }

  @override
  void onClose() {
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future getProfileImage() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    // Check if the profileImage field exists and is not null
    if (userDoc.exists) {
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null && userData['profileImage'] != null) {
        imagePath.value = userData['profileImage'] as String;
      } else {
        imagePath.value =
            "https://www.plslwd.org/wp-content/plugins/lightbox/images/No-image-found.jpg";
      }
    }
  }

  Future<void> fetchDetails() async {
    try {
      isLoading.value = true;
      DocumentSnapshot snapshot =
          await firestore.collection("users").doc(userUid).get();
      if (snapshot.exists) {
        isLoading.value = false;
        emailController.text = snapshot.get("emailAddress");
        phoneController.text = snapshot.get("phoneNumber");
        addressController.text = snapshot.get("address");
        imagePath.value = snapshot.get("profileImage");

        String firebaseImagePath = snapshot.get("profileImage") ?? "";
        if (firebaseImagePath != null && firebaseImagePath == "") {
          imagePath.value = firebaseImagePath;
        } else {
          imagePath.value =
              'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/640px-Image_not_available.png';
        }
      } else {
        isLoading.value = true;
        phoneController.clear();
        addressController.clear();
        // Handle the case where the document does not exist
        print("User document does not exist");
      }
    } catch (error) {
      isLoading.value = false;
      // Handle errors during data fetching
      print("Error fetching user details: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPhoneAndAddress() async {
    try {
      // Start loading state
      isLoading.value = true;

      String currentLoginUid = FirebaseAuth.instance.currentUser!.uid;

      // Check if the imagePath is not null or empty
      if (imagePath.value != null && imagePath.value.isNotEmpty) {
        // Upload image to Firebase Storage
        File imageFile = File(imagePath.value);
        UploadTask uploadImage = FirebaseStorage.instance
            .ref()
            .child("profilepicture")
            .child(currentLoginUid)
            .putFile(imageFile);

        TaskSnapshot taskSnapshot = await uploadImage;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Update user details in Firestore
        await firestore.collection("users").doc(userUid).update({
          "phoneNumber": phoneController.text,
          "address": addressController.text,
          "profileImage": downloadUrl,
        });

        // Stop loading state
        isLoading.value = false;

        // Show success snackbar
        Get.snackbar(
          "Success",
          "User details updated successfully",
        );

        // Navigate back
        Get.back();
      } else {
        // Stop loading state
        isLoading.value = false;

        // Show error snackbar
        Get.snackbar("Error", "Image path is null or empty",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);

        print("Image path is null or empty. Image not uploaded.");
      }
    } catch (error) {
      // Stop loading state
      isLoading.value = false;

      // Handle update error
      Get.snackbar("Error", "Failed to update user details: $error",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);

      print("Error updating user details: $error");
    }
  }

  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File convertedFile = File(image.path);
      imagePath.value = convertedFile.path;
    }
  }
}
