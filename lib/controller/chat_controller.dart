import 'package:get/get.dart';

class ChatController extends GetxController {
  final messages = [].obs;

  void addMessage(String msg) {
    messages.add((msg));
  }
}
