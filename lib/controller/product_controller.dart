import 'package:get/get.dart';
import 'package:solar_app/utils/constants/image_constant.dart';

class ProductController extends GetxController {
  List productname = ["Monocrystalline", "Polycrystalline", "Thin-film"];

  List productImages = [
    ImageConstants.monocrystalineImage,
    ImageConstants.polycrystallineImage,
    ImageConstants.thinFilmImage
  ];

  List productDescription = [
    "Of all the solar panel types, monocrystalline panels are likely to be the most expensive option. This is largely due to the manufacturing process.",
    "Polycrystalline solar panels are typically cheaper than monocrystalline solar panels.",
    "What you pay for thin-film solar cells will largely depend on the type of thin-film panel."
  ];

  List productTitle = [
    "High efficiency and performance",
    "Lower costs",
    "Portable and flexible"
  ];
}
