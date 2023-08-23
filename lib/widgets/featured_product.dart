import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart' as productmodel;

class FeaturedProduct extends StatelessWidget {
  const FeaturedProduct({super.key, required this.product});
  final productmodel.Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          Image.network(
            product.pImgs![0],
            width: 150,
            height: 150,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.pName!,
            style: const TextStyle(
              fontFamily: semibold,
              color: darkFontGrey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "\$${product.pPrice}",
            style: const TextStyle(
              fontFamily: bold,
              color: redColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
