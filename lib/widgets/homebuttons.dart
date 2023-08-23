import 'package:ecommerce_app/consts/consts.dart';
import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  const HomeButtons(
      {super.key,
      required this.width,
      required this.height,
      required this.title,
      required this.icon,
      required this.onPress});

  final double width;
  final double height;
  final String title;
  final String icon;
  final void Function() onPress;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 26),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(
                fontFamily: semibold,
                color: darkFontGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
