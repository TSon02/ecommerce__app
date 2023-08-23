import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ExitDialog extends StatelessWidget {
  const ExitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Confirm',
        style: TextStyle(
          fontFamily: bold,
        ),
      ),
      content: const Text('Are you sure you want to exit?'),
      actions: [
        // TextButton(
        //   onPressed: () {
        //     Get.back();
        //   },
        //   child: const Text('Cancel'),
        // ),
        // TextButton(
        //   onPressed: () {},
        //   child: const Text('OK'),
        // ),

        OurButton(
            onPress: () {
              Get.back();
            },
            title: 'Cancle',
            color: redColor,
            textColor: whiteColor),
        OurButton(
            onPress: () {
              SystemNavigator.pop();
            },
            title: 'OK',
            color: redColor,
            textColor: whiteColor),
      ],
    );
  }
}
