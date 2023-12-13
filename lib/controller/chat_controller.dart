import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:solar_app/data.dart';

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

  final databaseRef = FirebaseDatabase.instance.ref("chats");
  @override
  void onInit() {
    super.onInit();

    firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(box.read("currentloginedName"))
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
    // await firestore
    //     .collection("users")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection(box.read("currentloginedName")) // Create a sub-collection for messages
    //     .add({
    //   'message': message,
    //   'isSent': true,
    //   'currenttime': getCurrentTime(),
    // });
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(box
            .read("currentloginedName")) // Create a sub-collection for messages
        .add({
      'message': message,
      'isSent': true,
      'currenttime': getCurrentTime(),
    });
  }

  Future<void> getResponse({message}) async {
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(box
            .read("currentloginedName")) // Create a sub-collection for messages
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
          msgController.text.toLowerCase() == "no") {
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
      } else if (isQuestionActive && msgController.text == "yes") {
        sendMessage(message: msgController.text);
        msgController.clear();
        getResponse(
            message:
                "I Think You Need To Contact our company so after the survey they will tell you if you are eligible for solar or not.");
        isGreetingCompleted = false;
      } else if (isQuestionActive && isGreetingCompleted) {
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
