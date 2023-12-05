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
  RxBool isOptionButtonVisible = true.obs;
  bool chatActive = true;
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
      messages.assignAll(snapshot.docs.map((doc) {
        return {
          'message': doc['message'] ?? '',
          'isSent': doc['isSent'] ?? false,
          'currenttime': doc['currenttime'] ?? '',
        };
      }).toList());
      print("Messages: $messages");
    });
  }

  String getCurrentTime() {
    final DateTime now = DateTime.now();
    final String formattedTime =
        DateFormat('h:mm:ss a').format(now); // Format for "10:14 PM"

    return formattedTime;
  }

  Future<void> sendMessage({message}) async {
    await firestore
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("messages") // Create a sub-collection for messages
        .add({
      'message': message,
      'isSent': true,
      'currenttime': getCurrentTime(),
    });
  }

  Future<void> getResponse({message}) async {
    await firestore
        .collection("chats")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("messages") // Create a sub-collection for messages
        .add({
      'message': message,
      'isSent': false,
      'currenttime': getCurrentTime(),
    });
  }

  void processUserResponse(String userResponse) {
    if (greetings.contains(userResponse)) {
      getResponse(
          message: "Welcome to our Solar Power Company! How can I help you?");
      getResponse(
          message:
              "I can help you to find out⚡How You Can Save With Solar Energy⚡");
      getResponse(
          message:
              "Let me ask you a few questions to see if you qualify for the free eligibility review.");
      if (userResponse.contains("sure")) {
        getResponse(message: "Great! Then, here is my first question:");
      } else if (userResponse == "no") {
        getResponse(message: "I think you are not interested.");
      } else {
        // Handle other responses here
        // You can ask for clarification, offer alternatives, or redirect the conversation
        getResponse(
            message:
                "I need more information to understand your interest. Can you please clarify?");
      }
    }
  }

  void handleUserInput() {
    if (msgController.text.isEmpty) {
      // Handle empty input
      Get.snackbar("Undefined", "Please enter your complaint");
    } else {
      sendMessage(message: msgController.text);

      // Process user input and start the chat loop
      startChatLoop(msgController.text.toLowerCase());

      // Clear the input field
      msgController.clear();
    }
  }

  void chatBot() {
    if (msgController.text.isEmpty) {
      Get.snackbar("Undefined", "Please enter your Complain");
    } else {
      if (greetings.contains(msgController.text.toLowerCase())) {
        sendMessage(message: msgController.text);

        Future.delayed(const Duration(seconds: 2), () {
          getResponse(
              message:
                  "Welcome to our Solar Power Company! How can I help you?");
        });

        Future.delayed(const Duration(seconds: 2), () {
          getResponse(
              message:
                  "I can help you to find out⚡How You Can Save With Solar Energy⚡");
        });

        Future.delayed(const Duration(seconds: 2), () {
          getResponse(
              message:
                  "Let me ask you a few questions to see if you qualify for the free eligibility review.");
        });

        if (msgController.text.toLowerCase().contains("sure")) {
          Future.delayed(const Duration(seconds: 2), () {
            getResponse(message: "Great! Then, here is my first question:");
          });
        } else if (msgController.text.toLowerCase() == "no") {
          Future.delayed(const Duration(seconds: 2), () {
            getResponse(message: "I Think You Are Not Interested");
          });
        } else {
          Future.delayed(const Duration(seconds: 2), () {
            getResponse(
                message:
                    "I need more information to understand your interest. Can you please clarify?");
          });
        }
      }
    }
  }

  optionButton({required String text, required Function() onPressed}) {
    TextButton(
      onPressed: () {
        onPressed();
      },
      child: Text(text),
    );
  }

  Future<List<DocumentSnapshot>> getChats() async {
    String userUID = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userChats =
        firestore.collection("chats").doc(userUID).collection("messages");
    QuerySnapshot userChatSnapshot = await userChats.get();

    if (userChatSnapshot.docs.isNotEmpty) {
      print(userChatSnapshot.docs);
      return userChatSnapshot.docs;
    }
    print("No chats found");
    return [];
  }

  void startChatLoop(String userResponse) {
    while (chatActive) {
      if (greetings.contains(userResponse)) {
        processUserResponse(userResponse);
      }
      // You can set a condition to break out of the loop if needed
      // Example: chatActive = false;
    }
  }

  // void processUserResponse(String userResponse) {
  //   if (userResponse.contains("sure")) {
  //     getResponse(message: "Great! Then, here is my first question:");
  //   } else if (userResponse == "no") {
  //     getResponse(message: "I think you are not interested.");
  //   } else {
  //     // Handle other responses here
  //     // You can ask for clarification, offer alternatives, or redirect the conversation
  //     getResponse(
  //         message:
  //             "I need more information to understand your interest. Can you please clarify?");
  //   }
  // }
}
