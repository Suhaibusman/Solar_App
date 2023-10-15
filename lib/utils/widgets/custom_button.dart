import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/constants/app_constant.dart';
import 'package:solar_app/utils/widgets/text_widget.dart';

class CustomButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? mywidth;
  final double height;
  final List<Color> gradientColors;
  final Color color;
  final VoidCallback? onPressed;
  final String child;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final bool loading;
  final String? image;
  final double borderWidth; // Added property for border width
  final Color borderColor; // Added property for border color

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    required this.gradientColors,
    required this.color,
    this.mywidth,
    this.height = 44.0,
    this.loading = false,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w600,
    this.textColor = Colors.white,
    this.image,
    this.borderWidth = 0.0,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(10);
    final BoxDecoration backgroundDecoration = gradientColors.length > 1
        ? BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: calculateGradientStops(gradientColors.length),
            ),
            border: Border.all(
              width: borderWidth,
              color: borderColor,
            ),
          )
        : BoxDecoration(
            borderRadius: borderRadius,
            color: color,
            border: Border.all(
              width: borderWidth,
              color: borderColor,
            ),
          );

    return SizedBox(
      width: Get.width * mywidth!,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
        ),
        child: Container(
          decoration: backgroundDecoration,
          child: Center(
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (image != null) // Check if image is provided
                        Image.asset(image!,
                            width: 20,
                            height: 20), // Use the provided image asset
                      if (image != null)
                        smallSpaceh, // Add spacing if image is provided
                      ctext(
                        text: child,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: textColor,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

List<double> calculateGradientStops(int length) {
  final List<double> stops = [];
  final double step = 1.0 / (length - 1);

  for (int i = 0; i < length; i++) {
    stops.add(i * step);
  }

  return stops;
}
