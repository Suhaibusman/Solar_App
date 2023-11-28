import 'package:get_storage/get_storage.dart';

 final box = GetStorage();
class MyAppInitializer {
  static Future<void> initialize() async {
    await GetStorage.init();
    
    // Additional initialization logic can be added here
  }}
// ignore: prefer_typing_uninitialized_variables
var currentLoginUid;
String? currentLoginedName;