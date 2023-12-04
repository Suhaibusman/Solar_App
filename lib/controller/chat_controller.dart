import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  TextEditingController msgController = TextEditingController();
  RxList<Map<String, dynamic>> messages = <Map<String, dynamic>>[].obs;
  String formattedTime = "";
  final greetings = ["hi", "hello", "hey"];
  late DialogFlowtter dialogFlowtter;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    print("ChatController initialized");
    _firestore
        .collection("chats")
        .doc(_auth.currentUser!.uid)
        .collection("messages")
        .orderBy('currenttime')
        .snapshots()
        .listen((QuerySnapshot<Map<String, dynamic>> snapshot) {
      print("Messages: ${snapshot.docs.map((doc) => doc.data()).toList()}");
      messages.assignAll(snapshot.docs.map((doc) => doc.data()).toList());
    });
  }

  String getCurrentTime() {
    final DateTime now = DateTime.now();
    final String formattedTime =
        DateFormat('h:mm a').format(now); // Format for "10:14 PM"

    return formattedTime;
  }

  Future<void> sendMessage({message}) async {
    await firestore
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("messages") // Create a sub-collection for messages
        .add({
      message: {
        'isSent': true,
        'isReceived': false,
        'currenttime': getCurrentTime(),
      }
    });
  }

  Future<void> getResponse({message}) async {
    await firestore
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("messages") // Create a sub-collection for messages
        .add({
      message: {
        'isSent': false,
        'isReceived': true,
        'currenttime': getCurrentTime(),
      }
    });
  }

  void chatBot() {
    if (msgController.text.isEmpty) {
      Get.snackbar("Undefined", "Please enter your Complain");
    } else if (greetings.contains(msgController.text.toLowerCase())) {
      sendMessage(message: msgController.text);
      getResponse(
          message: "Welcome to our Solar Power Company! How can I help you?");

      msgController.clear();
    }
  }
}
