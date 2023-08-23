import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:flutter/material.dart';

class WishlistItem extends StatelessWidget {
  const WishlistItem({super.key, required this.item});

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.maxFinite,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: lightGolden,
        ),
      ),
      child: ListTile(
        leading: Image.network(
          item['p_imgs'][0],
        ),
        title: Text(
          item['p_name'],
          style: const TextStyle(
            fontFamily: semibold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${item['p_price'].toString()}\$',
          style: const TextStyle(
            fontFamily: semibold,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(
          Icons.favorite,
          color: redColor,
        ),
      ),
    );
  }
}
