import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProductController>();

    return Obx(
      () => Container(
        alignment: Alignment.center,
        width: 100,
        height: 100,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: controller.pImagesList[int.tryParse(label)! - 1] != null
            ? Image.file(
                controller.pImagesList[int.tryParse(label)! - 1],
                fit: BoxFit.fill,
                width: 100,
                height: 100,
              )
            : Text(
                label,
                style: const TextStyle(
                  color: fontGrey,
                  fontSize: 16,
                  fontFamily: bold,
                ),
              ),
      ),
    );
  }
}
