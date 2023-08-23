import 'package:ecommerce_app/consts/consts.dart';
// import 'package:ecommerce_app/consts/firebase_consts.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart' as productmodel;

class Product extends StatelessWidget {
  const Product(
      {super.key, required this.height, required this.productDetails});

  final double height;
  final productmodel.Product productDetails;
  @override
  Widget build(BuildContext context) {
    // print(productDetails);
    // return GestureDetector(
    //   onTap: () async {
    //     print(productDetails);
    //     final productss = productmodel.Product.fromJson(productDetails);
    //     print(productss.id);
    //     await firestore
    //         .collection(productsCollection)
    //         .doc()
    //         .set(productss.toJson());
    //   },

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
            productDetails.pImgs![0],
            width: 200,
            height: height,
            fit: BoxFit.fill,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            productDetails.pName!,
            style: const TextStyle(
              fontFamily: semibold,
              color: darkFontGrey,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${productDetails.pPrice} \$',
            style: const TextStyle(
              fontFamily: bold,
              color: redColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
