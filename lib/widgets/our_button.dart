import 'package:ecommerce_app/consts/consts.dart';
import 'package:flutter/material.dart';

class OurButton extends StatelessWidget {
  const OurButton(
      {super.key,
      required this.onPress,
      required this.title,
      required this.color,
      required this.textColor,
      this.isLoading});

  final void Function() onPress;
  final String title;
  final Color color;
  final Color textColor;
  final bool? isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: isLoading == true
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(),
            )
          : Text(
              title,
              style: TextStyle(
                color: textColor,
                fontFamily: bold,
              ),
            ),
    );
  }
}
