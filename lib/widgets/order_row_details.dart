import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:flutter/material.dart';

class OrderRowDetails extends StatelessWidget {
  const OrderRowDetails(
      {super.key,
      required this.titleL,
      required this.titleR,
      required this.descL,
      required this.descR});
  final String titleL;
  final String titleR;
  final String descL;
  final String descR;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleL,
                style: const TextStyle(fontFamily: semibold),
              ),
              Text(
                descL,
                style: const TextStyle(
                    fontFamily: semibold, fontSize: 13, color: redColor),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titleR,
                style: const TextStyle(fontFamily: semibold),
              ),
              Text(
                descR,
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
