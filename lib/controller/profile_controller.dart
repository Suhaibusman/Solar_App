import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController emailController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
final userUid = FirebaseAuth.instance.currentUser!.uid;
 

 @override
 void onInit() {
    super.onInit();
    fetchDetails();
 }
 
 void fetchDetails()async{
  
    DocumentSnapshot snapshot =
        await firestore.collection("users").doc(userUid).get();
    emailController.text = snapshot.get("emailAddress");
    phoneController.text = snapshot.get("phoneNumber");
    addressController.text = snapshot.get("address");
   
 
 }
 void addPhoneAndAddress(){
   firestore.collection("users").doc(userUid).update({
     "phoneNumber":phoneController.text,
     "address":addressController.text
   });
   Get.back();
 }
}
