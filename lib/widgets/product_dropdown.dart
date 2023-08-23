import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ProductDropdown extends StatefulWidget {
  ProductDropdown(
      {super.key,
      required this.hint,
      required this.list,
      required this.dropValue});
  final String hint;
  final List list;
  String? dropValue;

  @override
  State<ProductDropdown> createState() => _ProductDropdownState();
}

class _ProductDropdownState extends State<ProductDropdown> {
  final controller = Get.find<AddProductController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 1, color: whiteColor),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            icon: const Icon(
              Icons.arrow_drop_down,
              color: darkFontGrey,
            ),
            value: widget.hint == "Category"
                ? controller.categoryValue.value == ''
                    ? null
                    : controller.categoryValue.value
                : controller.subCategoryValue.value == ''
                    ? null
                    : controller.subCategoryValue.value,
            hint: Text(
              widget.hint,
              style: const TextStyle(
                color: darkFontGrey,
              ),
            ),
            isExpanded: true,
            items: widget.hint == "Category"
                ? controller.categoryList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList()
                : controller.subCategoryList
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
            onChanged: (value) {
              if (widget.hint == 'Category') {
                controller.subCategoryValue.value = '';

                controller.categoryValue.value = value.toString();
                controller.populateSubCategoryList(cat: value.toString());
              } else {
                controller.subCategoryValue.value = value.toString();
              }
            },
          ),
        ),
      ),
    );
  }
}
