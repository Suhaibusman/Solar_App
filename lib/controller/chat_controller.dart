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
  bool isQuestionActive = false;
  bool isGreetingCompleted = false;
  bool isEnterAddress = false;
  final greetings = ["hi", "hello", "hey"];
  late DialogFlowtter dialogFlowtter;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();

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

  void handleUserInput() async {
    if (msgController.text.isEmpty) {
      Get.snackbar("Undefined", "Please enter your complaint");
    } else if (greetings.contains(msgController.text.toLowerCase())) {
      isGreetingCompleted = true;

      await sendMessage(message: msgController.text);
      msgController.clear();
      await greetingMessage();
    } else if (!isGreetingCompleted) {
      await sendMessage(message: msgController.text);
      msgController.clear();
      await Future.delayed(
        const Duration(seconds: 1),
        () async {
          await getResponse(
              message: "I Can't Understand Please Type Hi or Hello or Hey");
        },
      );
    } else {
      if (isGreetingCompleted && msgController.text == "sure") {
        await sendMessage(message: msgController.text);
        msgController.clear();
        Future.delayed(const Duration(seconds: 1), () async {
          await getResponse(message: "Great! Then, here is my first question");
        });

        Future.delayed(const Duration(seconds: 2), () async {
          await getResponse(message: "Is Your Home Shaded? (Yes/No)");
        });
        isQuestionActive = true;
      } else if (isGreetingCompleted &&
          isQuestionActive &&
          msgController.text.toLowerCase() == "yes") {
        sendMessage(message: msgController.text);
        msgController.clear();
        Future.delayed(const Duration(seconds: 2), () async {
          await getResponse(
              message:
                  "Please type your address including city, state, and country.");
        });

        isEnterAddress = true;
      } else if (isEnterAddress &&
          msgController.text.isNotEmpty &&
          isGreetingCompleted) {
        await sendMessage(message: msgController.text);
        msgController.clear();
        Future.delayed(const Duration(seconds: 1), () async {
          getResponse(message: "Our Company Will Call You.");
        });

        isGreetingCompleted = false;
        isEnterAddress = false;
      } else if (isQuestionActive && msgController.text == "no") {
        sendMessage(message: msgController.text);
        msgController.clear();
        getResponse(
            message:
                "I Think You Need To Contact our company so after the survey they will tell you if you are eligible for solar or not.");
        isGreetingCompleted = false;
      } else if (isQuestionActive) {
        await sendMessage(message: msgController.text);
        msgController.clear();
        Future.delayed(
          const Duration(seconds: 2),
          () async {
            await getResponse(
                message: "I Can't Understand what are you saying");
          },
        );
        isGreetingCompleted = false;
      }
    }
  }

  greetingMessage() async {
    await Future.delayed(
      const Duration(seconds: 1),
      () async {
        await getResponse(
            message: "Welcome to our Solar Power Company! How can I help you?");
      },
    );

    await Future.delayed(const Duration(seconds: 1), () async {
      await getResponse(
          message:
              "I can help you find out ⚡How You Can Save With Solar Energy⚡");
    });

    await Future.delayed(const Duration(seconds: 1), () async {
      await getResponse(
          message:
              "Let me ask you a few questions to see if you qualify for the free eligibility review type sure.");
    });
  }

  void chatBot() async {
    if (greetings.contains(msgController.text.toLowerCase())) {
      await sendMessage(message: msgController.text);
      await greetingMessage();
    } else {
      if (msgController.text == "sure") {
        await sendMessage(message: msgController.text);
        await getResponse(message: "Great! Then, here is my first question");
        generateAutoReply("1");
      } else if (msgController.text == "yes") {
        await sendMessage(message: msgController.text);
        await getResponse(
            message:
                "Please type your address including city, state, and country");
      } else if (msgController.text == "no") {
        await sendMessage(message: msgController.text);
        await getResponse(message: "I think you are not interested.");
        isGreetingCompleted = false;
      } else {
        await sendMessage(message: msgController.text);
        generateAutoReply("2");
      }
    }
  }

  questions() {
    Future.delayed(const Duration(seconds: 2), () async {
      await getResponse(message: "Is Your Home Shaded? (Yes/No)");
    });

    if (msgController.text.toLowerCase() == "yes") {
      sendMessage(message: msgController.text);
      Future.delayed(const Duration(seconds: 2), () async {
        getResponse(
            message:
                "Please type your address including city, state, and country.");
      });

      isEnterAddress = true;
      while (isEnterAddress) {
        sendMessage(message: msgController.text);
        getResponse(message: "Our Company Will Call You.");
        isGreetingCompleted = false;
        isEnterAddress = false;
      }
    } else {
      if (msgController.text == "no") {
        sendMessage(message: msgController.text);
        getResponse(
            message:
                "I Think You Need To Contact our company so after survey they tell u are you eligible for solar or not.");
        isGreetingCompleted = false;
      }
    }
  }

  generateAutoReply(String input) async {
    switch (input) {
      case '1':
        return {questions()};
      case '2':
        return {
          Future.delayed(
            const Duration(seconds: 2),
            () async {
              await getResponse(
                  message:
                      "I need more information to understand your interest. Can you please clarify?");
            },
          )
        };
      case '3':
        return {
          await getResponse(
              message:
                  "Let me ask you a few questions to see if you qualify for the free eligibility review.")
        };
      case '4':
        return 'I am a chatbot that can help you with your questions.';
      default:
        return 'I am sorry, I didnt understand. Can you please clarify?';
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
      // print(userChatSnapshot.docs);
      return userChatSnapshot.docs;
    }
    // print("No chats found");
    return [];
  }
}
