import 'package:get/get.dart';
import 'package:solar_app/utils/constants/image_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductController extends GetxController {
  List productname = ["Monocrystalline", "Polycrystalline", "Thin-film"];

  List productImages = [
    ImageConstants.monocrystalineImage,
    ImageConstants.polycrystallineImage,
    ImageConstants.thinFilmImage
  ];

  List productDescription = [
    "Monocrystalline solar panels are most expensive due to their manufacturing process.",
    "Polycrystalline panels are generally cheaper than monocrystalline ones.",
    "The cost of thin-film solar cells depends on the specific type of panel."
  ];

  List productTitle = [
    "High efficiency and performance",
    "Lower costs",
    "Portable and flexible"
  ];

  void openCompanyWebsite() async {
    try {
      String companyWebsiteUrl = 'https://intermarkproduct.com/';
      await launch(companyWebsiteUrl);
    } catch (e) {
      print('Error launching Website: $e');
    }
  }
}
