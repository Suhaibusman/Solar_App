import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:solar_app/firebase_options.dart';
import 'package:solar_app/utils/themes/color_theme.dart';
import 'package:solar_app/utils/widgets/nav_bar.dart';
import 'package:solar_app/view/splash/splash_view.dart';
import 'package:get_storage/get_storage.dart';

void main() async{
  // await MyAppInitializer.initialize();
  await GetStorage.init();
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: primarycolor,
    statusBarColor: primarycolor,
  ));
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
   const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    home: (FirebaseAuth.instance.currentUser != null)
  ? 
  MyBottomNavbar()
  // HomeView(
  //     userName: box.read("  
  //urrentLoginedName") ?? "User",
  //   )
  : const SplashScreen(),

    );
  }
}
