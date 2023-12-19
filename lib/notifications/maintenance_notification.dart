
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:solar_app/data.dart';

// class MaintenanceNotificationManager {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> scheduleMaintenanceNotifications() async {
//     // Calculate tomorrow's date
//     DateTime tomorrow = DateTime.now().add(Duration(days: 1));
//     DateTime tomorrowStart = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

//     // Query maintenance entries for tomorrow
//     QuerySnapshot maintenanceSnapshot = await _firestore
//         .collection('maintenance').doc(box.read("currentloginedUid")).
//         .where('date', isGreaterThanOrEqualTo: tomorrowStart)
//         .where('date', isLessThan: tomorrowStart.add(Duration(days: 1)))
//         .get();

//     // Iterate over maintenance entries and schedule notifications
//     for (QueryDocumentSnapshot maintenanceDoc in maintenanceSnapshot.docs) {
//       Map<String, dynamic> maintenanceData = maintenanceDoc.data() as Map<String, dynamic>;
//       String deviceId = maintenanceData['deviceId'];

//       // Schedule notification
//       await _scheduleNotification(deviceId, 'Maintenance Reminder', 'You have maintenance scheduled for tomorrow.');
//     }
//   }

//   Future<void> _scheduleNotification(String deviceId, String title, String body) async {
//     // TODO: Implement notification scheduling using firebase_messaging

//     // Use _firebaseMessaging to schedule the notification
//     // Example:
//     // await _firebaseMessaging.scheduleLocalNotification(LocalNotification(
//     //   title: title,
//     //   body: body,
//     //   scheduledDate: DateTime.now().add(Duration(seconds: 5)),
//     // ));

//     print('Notification scheduled for device $deviceId');
//   }
// }

// // void main() async {
// //   MaintenanceNotificationManager notificationManager = MaintenanceNotificationManager();
// //   await notificationManager.scheduleMaintenanceNotifications();
// // }
