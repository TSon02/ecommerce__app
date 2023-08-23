import 'package:ecommerce_app/consts/colors.dart';
import 'package:flutter/material.dart';

class NewTextField extends StatelessWidget {
  const NewTextField({
    super.key,
    required this.hint,
    required this.title,
    this.isDesc = false,
    required this.controller,
  });
  final String hint;
  final String title;
  final bool isDesc;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: isDesc ? 4 : 1,
      style: const TextStyle(color: whiteColor),
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: const TextStyle(color: whiteColor),
        label: Text(
          title,
          style: const TextStyle(color: whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: whiteColor, width: 1, style: BorderStyle.solid),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(12),
        //   borderSide: const BorderSide(
        //       color: whiteColor, width: 1, style: BorderStyle.solid),
        // ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: redColor),
        ),
      ),
    );
  }
}
