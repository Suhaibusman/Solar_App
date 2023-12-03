import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solar_app/controller/messages.dart';

class ChatController extends GetxController {
  TextEditingController msgController = TextEditingController();
  final messages = [].obs;
  String formattedTime = "";

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String getCurrentTime() {
    final DateTime now = DateTime.now();
    final String formattedTime =
        DateFormat('h:mm a').format(now); // Format for "10:14 PM"

    return formattedTime;
  }

  void addMessages(String msg) {
    messages.add((msg));
    if (msg.toLowerCase().contains('yes') ||
        msg.toLowerCase().contains('sure')) {
      _simulateCompanyResponse(msg);
    }
  }

  void _simulateCompanyResponse(msg) {
    messages.add(msg(text: 'Great! Here is my first question', isUser: false));
    messages.add(msg(text: '1) Is your home shaded (yes/no)', isUser: false));
  }

  Future<void> getMessages({message}) async {
    await firestore
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'message': message,
      'isSent': true,
      'isRecived': false,
      'currenttime': getCurrentTime(),
    });
  }

  void chatBot() {
    if (msgController.text.isEmpty) {
      Get.snackbar("Undefined", "Please enter your Complain");
    } else if (msgController.text == "hi" ||
        msgController.text == "hello" ||
        msgController.text == "Hello" ||
        msgController.text == "Hi" ||
        msgController.text == "hey" ||
        msgController.text == "Hey" ||
        msgController.text == "Hi" ||
        msgController.text == "hi" ||
        msgController.text == "Hello" ||
        msgController.text == "Hello" ||
        msgController.text == "Hi" ||
        msgController.text == "hey" ||
        msgController.text == "Hey" ||
        msgController.text == "Hi" ||
        msgController.text == "hi" ||
        msgController.text == "Hello" ||
        msgController.text == "Hello" ||
        msgController.text == "Hi" ||
        msgController.text == "hey" ||
        msgController.text == "Hey" ||
        msgController.text == "Hi" ||
        msgController.text == "hi" ||
        msgController.text == "Hello" ||
        msgController.text == "Hello" ||
        msgController.text == "Hi" ||
        msgController.text == "hey" ||
        msgController.text == "Hey" ||
        msgController.text == "Hi" ||
        msgController.text == "hi" ||
        msgController.text == "Hello" ||
        msgController.text == "Hello" ||
        msgController.text == "Hi" ||
        msgController.text == "hey" ||
        msgController.text == "Hey" ||
        msgController.text == "Hi") {
      getMessages(message: msgController.text);

      msgController.clear();
    }
  }
}
