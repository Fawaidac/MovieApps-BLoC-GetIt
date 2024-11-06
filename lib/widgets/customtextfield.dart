import 'package:flutter/material.dart';

import '../themes/colors.dart';
import '../themes/fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isObs;
  final bool isSuffixIcon;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.isSuffixIcon = false,
    this.isObs = false,
    this.suffixIcon,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObs,
      style: AppFonts.poppins(fontSize: 14, color: whiteColor),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: whiteColor),
        suffixIcon: isSuffixIcon ? suffixIcon : null,
        hintText: hintText,
        hintStyle: AppFonts.poppins(fontSize: 14, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      ),
      validator: validator,
    );
  }
}
