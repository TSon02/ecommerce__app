import 'dart:developer';
import 'dart:io';

import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/add_product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Future<dynamic> imagePicker({
  required ImageSource source,
}) async {
  final ImagePicker picker = ImagePicker();

  final imageFile = await picker.pickImage(source: source, imageQuality: 50);

  if (imageFile != null) {
    return File(imageFile.path);
  } else {
    return;
  }
}

final controller = Get.find<AddProductController>();

Future<dynamic> pickImage(index, BuildContext context) async {
  // print(index);
  try {
    final img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img == null) {
      return;
    } else {
      // print(controller.pImagesList);
      controller.pImagesList[index] = File(img.path);
      // print('a');
    }
  } catch (e) {
    log(e.toString());
    VxToast.show(context,
        msg: e.toString(), bgColor: redColor, textColor: whiteColor);
  }
}
