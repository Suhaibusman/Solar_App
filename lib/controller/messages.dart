import 'package:intl/intl.dart';

class SendMessage {
  final String message;
String getCurrentTime() {
  final DateTime now = DateTime.now();
  final String formattedTime = DateFormat('h:mm a').format(now); // Format for "10:14 PM"

  return formattedTime;
}
  


  SendMessage( {required this.message, });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'isSent': true,
      'isRecived'   : false,
      'currenttime': getCurrentTime(),
      
    };
  }
}
