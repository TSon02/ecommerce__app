import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  const DetailCard({super.key, required this.count, required this.title});
  final String count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
      child: Container(
        height: 70,
        width: MediaQuery.sizeOf(context).width / 3.5,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString(),
              style: const TextStyle(
                fontFamily: bold,
                color: darkFontGrey,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: const TextStyle(
                color: darkFontGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
