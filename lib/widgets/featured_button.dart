import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/screens/categories_screen/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeaturedButton extends StatelessWidget {
  const FeaturedButton({super.key, required this.title, required this.icon});

  final String title;
  final String icon;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return GestureDetector(
      onTap: () async {
        await controller.getSubCategories(title: title);
        Get.to(() => CategoryDetails(title: title));
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          child: Row(
            children: [
              Image.asset(
                icon,
                width: 60,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: semibold,
                  color: darkFontGrey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
