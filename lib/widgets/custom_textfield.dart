import 'package:ecommerce_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customTextField(
    {String? title,
    String? hint,
    TextEditingController? controller,
    bool? isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title!,
        style: const TextStyle(
          color: redColor,
          fontFamily: semibold,
          fontSize: 16,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        obscureText: isPass!,
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: redColor,
            ),
          ),
        ),
      ),
    ],
  );
}
