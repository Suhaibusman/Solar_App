import 'package:get/get.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:solar_app/view/nav_bar/change_password/change_password_view.dart';
import 'package:solar_app/view/nav_bar/chat_view/chat_view.dart';
import 'package:solar_app/view/nav_bar/complaint_details/reg_complaint_view.dart';
import 'package:solar_app/view/nav_bar/maintainance/maintainance_view.dart';
import 'package:solar_app/view/nav_bar/products/product_view.dart';
import 'package:solar_app/view/nav_bar/support/support_view.dart';

class HomeController extends GetxController {
  List gridTextList = [
    "Product",
    "Chatbot",
    "Complaint",
    "Maintainance",
    "Contact Us",
    "Change Password"
  ];

  List grinImagesList = [
    IconsConstants.productIcon,
    IconsConstants.botIcon,
    IconsConstants.complaintIcon,
    IconsConstants.calenderIcon,
    IconsConstants.contactusIcon,
    IconsConstants.passwordIcon,
  ];

  List pagesView = [
    ProductView(),
    ChatScreen(),
    RegisterComplaintView(),
    MaintainanceView(),
    SupportView(),
    ChangePasswordView()
  ];
}
