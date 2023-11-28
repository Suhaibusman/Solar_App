// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:solar_app/utils/themes/color_theme.dart';

class CustomUnderLineTextField extends StatelessWidget {
  final TextEditingController? controller;
 final bool? isobscure;
  bool? isreadOnly = true;
  bool? issuffixIcon = false;
  bool? isPreffixIcon = false;
  final IconData? suffixIcon;
  final int? maxLines;
  var onSuffixTap;
  var onTap;
  final String hint;
  final TextInputType type;
  CustomUnderLineTextField({
     this.isobscure,
    required this.controller,
    required this.hint,
    this.issuffixIcon,
    this.isPreffixIcon,
    required this.type,
    this.isreadOnly,
    this.maxLines,
    this.suffixIcon,
    this.onSuffixTap,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: primaryTextColor,
        focusColor: primarycolor,
      ),
      child: TextField(
        obscureText: isobscure ?? false,
        controller: controller,
        onTap: onTap,
        readOnly: isreadOnly ?? false,
        enabled: true,
        textAlign: TextAlign.left,
        maxLines: maxLines,
        keyboardType: type,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          prefixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          hoverColor: Colors.green,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: lightPrimaryTextColor),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primarycolor),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryTextColor),
          ),
          hintText: hint,
          suffixIcon: (issuffixIcon ?? false)
              ? IconButton(onPressed: onSuffixTap, icon: Icon(suffixIcon))
              : const SizedBox.shrink(),
          isDense: false,
          prefixIcon: (isPreffixIcon ?? false)
              ? IconButton(
                  onPressed: onSuffixTap,
                  icon: Icon(
                    suffixIcon,
                    size: 15,
                  ))
              : const SizedBox.shrink(),
        ),
        onChanged: (value) {
        },
      ),
    );
  }
}

class CustomBorderTextField extends StatefulWidget {
  final bool? isobscure;
  final String hint;
  final List<TextInputFormatter>? inputFormatters;
  final IconData? suffix;
  final bool? isreadOnly;
  final ValueSetter<String>? onchanged;
  final prefix;
  final TextEditingController? controller;
  final String? Function(String?)? valid;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final VoidCallback? suffixonTap;
  final VoidCallback? textFieldTap;
  final int? maxLines;

  const CustomBorderTextField({
    
    Key? key,
    required this.hint,
    this.isobscure,
    this.inputFormatters,
    this.suffix,
    this.focusNode,
    this.suffixonTap,
    this.onTap,
    this.textFieldTap,
    this.prefix,
    this.isreadOnly = false,
    this.controller,
    this.valid,
    this.onchanged,
    this.maxLines, 
  }) : super(key: key);

  @override
  State<CustomBorderTextField> createState() => _FieldTextState();
}

class _FieldTextState extends State<CustomBorderTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      height: Get.height * 0.08,
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.2, 0.8, 0.8, 0.2],
          colors: [
            primarycolor,
            lightPrimaryTextColor,
            lightPrimaryTextColor,
            primarycolor
          ],
        ),
      ),
      child: TextFormField(
        obscureText: widget.isobscure ?? false,
        maxLines: widget.maxLines ?? 1,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onchanged,
        focusNode: widget.focusNode,
        readOnly: widget.isreadOnly ?? false,
        onTap: widget.textFieldTap,
        controller: widget.controller,
        validator: widget.valid,
        style: TextStyle(fontSize: 13, color: white),
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIconConstraints:
              const BoxConstraints(minWidth: 0, minHeight: 0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: lightPrimaryTextColor),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: btnPrimaryColor.withOpacity(.5))),
          filled: true,
          fillColor: primarycolor,
          isDense: false,
          hintText: widget.hint,
          hintStyle: TextStyle(color: lightPrimaryTextColor, fontSize: 12),
          prefixIcon: widget.prefix,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: widget.onTap,
              icon: InkWell(
                onTap: widget.suffixonTap,
                child: Icon(widget.suffix, color: Colors.grey,)),
            ),
          ),
        ),
      ),
    );
  }
}
