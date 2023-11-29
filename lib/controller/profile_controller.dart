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
    isLoading.value = true;
    DocumentSnapshot snapshot =
        await firestore.collection("users").doc(userUid).get();
    if (snapshot.exists) {
      isLoading.value = false;
      emailController.text = snapshot.get("emailAddress");
      phoneController.text = snapshot.get("phoneNumber");
      addressController.text = snapshot.get("address");
      
      // Update imagePath with the download URL from Firebase Storage
      String firebaseImagePath = snapshot.get("profileImage");
      if (firebaseImagePath != null && firebaseImagePath.isNotEmpty) {
        // Optionally, you can download the image to local storage if needed
        // For simplicity, this example assumes you directly use the URL
        imagePath.value = firebaseImagePath;
      } else {
        // If profileImage is not available, set a default image
        imagePath.value = 'assets/default.png';
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
          String currentLoginUid = FirebaseAuth.instance.currentUser!.uid;

        // Upload image to Firebase Storage
        UploadTask uploadImage = FirebaseStorage.instance
            .ref()
            .child("profilepicture")
            .child(currentLoginUid)
            .putFile(File(imagePath.value));

             TaskSnapshot taskSnapshot = await uploadImage;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    firestore.collection("users").doc(userUid).update({
      "phoneNumber": phoneController.text,
      "address": addressController.text,
      "profileImage": downloadUrl,
    }).then((value) {
      Get.snackbar("Success", "User details updated successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      
      // Handle success if needed
      Get.back();
    }).catchError((error) {
      // Handle update error
      print("Error updating user details: $error");
    });
  }
   Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }
}
