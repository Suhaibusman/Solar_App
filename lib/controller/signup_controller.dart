import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:solar_app/data.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/utils/widgets/nav_bar.dart';
import 'package:solar_app/view/auth/login/login_view.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  List signUpLogos = [IconsConstants.googleIcon, IconsConstants.facebookIcon];

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxBool loading = false.obs;
  RxBool isPassVisible = true.obs;

  signUpWithEmailAndPassword() async {
    loading.value = true;
    String emailAddress = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String userName = nameController.text.toString().trim();

    if (emailAddress == "" || password == "" || userName == "") {
      Get.snackbar("Sign up Error", "Please Fill All The Values");
      loading.value = false;
    } else {
      try {
        loading.value = true;
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        await firestore.collection("users").doc(credential.user!.uid).set({
          "uid": credential.user!.uid,
          "username": userName,
          "emailAddress": emailAddress,
          "Password": password,
          "phoneNumber": "",
          "profileImage": "",
          "address": ""
        });
        if (credential.user != null) {
          loading.value = false;
          Get.snackbar("Sign Up Successfully",
              "The User With This Email: $emailAddress is Registered Successfully");
          Get.to(() => LoginView());
          emailController.clear();
          passwordController.clear();
          nameController.clear();
        }
      } on FirebaseAuthException catch (e) {
        loading.value = false;
        Get.snackbar("Error", e.toString());
      } catch (e) {
        loading.value = false;
        Get.snackbar("Error", e.toString());
      }
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      loading.value = true;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Access the user details
      final user = userCredential.user;

      if (user != null) {
        loading.value = false;

        // Store additional user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': user.displayName,
          'emailAddress': user.email,

          "uid": user.uid,

          "phoneNumber": "",
          "profileImage": "",
          "address": ""
          // Add any other fields you want to store
        });

        DocumentSnapshot userSnapshot =
            await firestore.collection("users").doc(user.uid).get();
        if (userSnapshot.exists) {
          // User is a regular user
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          box.write("currentloginedName", userData["username"]);
          box.write("currentLoginedPhoneNumber", userData["phoneNumber"]);
          box.write("address", userData["address"]);

          currentLoginedName = box.read("currentloginedName");

          Get.offAll(() => MyBottomNavbar());

          // Navigate to HomeScreen
          // Get.offAll(()=>HomeView(
          // userName: currentLoginedName ?? box.read("currentloginedName"),
          // ));
          box.write("isLogined", true);
        }
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
      rethrow;
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
      rethrow;
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    try {
      loading.value = true;

      // Step 1: Trigger the Facebook login
      final LoginResult result = await FacebookAuth.instance.login();

      // Step 2: Get the Facebook access token
      final AuthCredential credential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      // Step 3: Sign in with Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Step 4: Access the user details
      final user = userCredential.user;

      if (user != null) {
        loading.value = false;

        // Step 5: Store additional user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': user.displayName,
          'emailAddress': user.email,
          "uid": user.uid,
          "phoneNumber": "",
          "profileImage": "",
          "address": ""
          // Add any other fields you want to store
        });

        // Step 6: Retrieve additional user information from Firestore
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .get();
        if (userSnapshot.exists) {
          // User is a regular user
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          box.write("currentloginedName", userData["username"]);
          box.write("currentLoginedPhoneNumber", userData["phoneNumber"]);
          box.write("address", userData["address"]);

          currentLoginedName = box.read("currentloginedName");

          // Step 7: Navigate to the desired screen
          Get.offAll(() => MyBottomNavbar());
          box.write("isLogined", true);
        }
      }

      return userCredential;
    } catch (e, stackTrace) {
      loading.value = false;
      runZonedGuarded(() {
        Get.snackbar("Error", e.toString());
      }, (error, stackTrace) {
        print("Unhandled error: $error");
      });
      rethrow;
    }
  }

  Future<UserCredential> signInWithFacebookNative() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<UserCredential> signInWithFacebookWeb() async {
    // Create a new provider
    FacebookAuthProvider facebookProvider = FacebookAuthProvider();

    facebookProvider.addScope('email');
    facebookProvider.setCustomParameters({
      'display': 'popup',
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(facebookProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(facebookProvider);
  }

  loginWithFB() async {
    UserCredential userCredential;
    try {
      if (kIsWeb) {
        userCredential = await signInWithFacebookWeb();
      } else {
        userCredential = await signInWithFacebookNative();
      }
    } catch (e) {
      if (kDebugMode) {
        print("error in sign in with google $e");
      }
    }
  }

  updateUserProfilefromFB(User user) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    users.doc(user.uid).set({
      'username': user.displayName,
      'emailAddress': user.email,
      "uid": user.uid,
      "phoneNumber": "",
      "profileImage": "",
      "address": ""
    }).then((value) {
      print("User Added");
    }).catchError((error) => print("Failed to add user: $error"));
  }
}
