import 'package:get/get.dart';

class ChatController extends GetxController {
  final messages = [].obs;

  void addMessage(String msg) {
    messages.add((msg));
    if (msg.toLowerCase().contains('yes') || msg.toLowerCase().contains('sure')) {
      _simulateCompanyResponse(msg);
    }
  }
 

  void _simulateCompanyResponse(msg) {
    
    messages.add(msg(text: 'Great! Here is my first question', isUser: false));
    messages.add(msg(text: '1) Is your home shaded (yes/no)', isUser: false));
   
  }
}


