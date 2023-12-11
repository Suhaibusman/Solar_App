import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TrackLocationController extends GetxController {
  // Function to open WhatsApp with a pre-filled message
// Function to open WhatsApp with a pre-filled message
  void launchWhatsApp(String phone, String message) async {
    try {
      Uri uri = Uri.parse(Uri.encodeFull(
          'https://wa.me/$phone/?text=${Uri.encodeComponent(message)}'));
      await launch(uri.toString());
    } catch (e) {
      print('Error launching WhatsApp: $e');
    }
  }

  void openWhatsAppCall(String phoneNumber) async {
    // String url = 'https://wa.me/$phoneNumber';

    try {
      Uri uri = Uri.parse(Uri.encodeFull('https://wa.me/$phoneNumber'));
      await launch(uri.toString());
    } catch (e) {
      print('Error launching WhatsApp: $e');
    }
  }

  void openMap() async {
    try {
      String mapsUrl = 'https://maps.app.goo.gl/rbTmuyow4PBep4fK7';
      await launch(mapsUrl);
    } catch (e) {
      print('Error launching Google Maps: $e');
    }
  }
}
