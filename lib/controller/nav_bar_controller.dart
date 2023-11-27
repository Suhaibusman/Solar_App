import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solar_app/view/nav_bar/complaint_details/coplaints_view.dart';
import 'package:solar_app/view/nav_bar/home/home_view.dart';
import 'package:solar_app/view/nav_bar/products/product_view.dart';
import 'package:solar_app/view/nav_bar/profile/profile_view.dart';
import 'package:solar_app/view/nav_bar/track_location/track_location_view.dart';

class BottomNavBarController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  onInit() {
    _currentScreen = HomeView();
    currentIndex(0);
    super.onInit();
  }

  void onclose() {
    super.onClose();
  }

  Widget _currentScreen = HomeView();

  Widget get currentScreen => _currentScreen;

  void changeScreen(int index) {
    currentIndex(index);
    switch (index) {
      case 0:
        _currentScreen = HomeView();
        break;
      case 1:
        _currentScreen = TrackLocationView();
        break;
      case 2:
        _currentScreen = ProductView();
        break;
      case 3:
        _currentScreen = ComplaintsView();
        break;
      case 4:
        _currentScreen = ProfileView();
        break;
      default:
        break;
    }

    update();
  }
}
