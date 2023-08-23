import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/add_product_controller.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:ecommerce_app/widgets/product_dropdown.dart';
import 'package:ecommerce_app/widgets/product_images.dart';
import 'package:ecommerce_app/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:math' as math;

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddProductController>();
    return Obx(
      () => Scaffold(
        backgroundColor: const Color.fromARGB(255, 44, 21, 107),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: whiteColor,
            ),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(
              fontFamily: semibold,
              color: whiteColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (controller.pDescController.text.isNotEmptyAndNotNull &&
                    controller.pNameController.text.isNotEmptyAndNotNull &&
                    controller.pPriceController.text.isNotEmptyAndNotNull &&
                    controller.pQuantityController.text.isNotEmptyAndNotNull) {
                  controller.isUploaded.value = true;
                  await FirestoreService().uploadProduct(context: context);
                  // print('true');
                  // await FireStorageService().uploadProductImage(
                  //     nameProduct: controller.pNameController.text);

                  controller.isUploaded.value = false;
                  Get.back();
                  controller.clearProducts();
                } else {
                  VxToast.show(context,
                      msg: 'Làm ơn điền vào chỗ trống',
                      bgColor: redColor,
                      textColor: whiteColor);
                }
              },
              child: controller.isUploaded.value
                  ? const CircularProgressIndicator()
                  : const Text(
                      'Save',
                      style: TextStyle(color: whiteColor),
                    ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                NewTextField(
                  hint: 'eg. BWM',
                  title: 'Product name',
                  controller: controller.pNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                NewTextField(
                  hint: 'eg. Nice product',
                  title: 'Description',
                  isDesc: true,
                  controller: controller.pDescController,
                ),
                const SizedBox(
                  height: 20,
                ),
                NewTextField(
                  hint: 'eg. \$100',
                  title: 'Price',
                  controller: controller.pPriceController,
                ),
                const SizedBox(
                  height: 20,
                ),
                NewTextField(
                  hint: 'eg. 40',
                  title: 'Quantity',
                  controller: controller.pQuantityController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ProductDropdown(
                  hint: "Category",
                  dropValue: controller.categoryValue.value,
                  list: controller.categoryList,
                ),
                const SizedBox(
                  height: 20,
                ),
                ProductDropdown(
                    hint: 'Subcategory',
                    dropValue: controller.subCategoryValue.value,
                    list: controller.subCategoryList),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Choose product images',
                  style: TextStyle(
                    color: whiteColor,
                    fontFamily: semibold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => InkWell(
                      onTap: () async {
                        await pickImage(index, context);

                        print(controller.pImagesList);
                      },
                      child: ProductImages(
                        label: (index + 1).toString(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'First image will be your display image',
                  style: TextStyle(
                    color: whiteColor,
                    fontFamily: semibold,
                    fontSize: 16,
                  ),
                ),
                const Divider(
                  color: whiteColor,
                ),
                const Text(
                  'Choose product colors',
                  style: TextStyle(
                    color: whiteColor,
                    fontFamily: semibold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: List.generate(
                    9,
                    (index) => Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.colorIndex.value = index;
                          },
                          child: Container(
                            // margin:
                            //     const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                                color: Color(
                                  (math.Random().nextDouble() * 0xFFFFFF)
                                      .toInt(),
                                ).withOpacity(1.0),
                                shape: BoxShape.circle),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.colorIndex.value == index,
                            child: const Icon(
                              Icons.done,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
