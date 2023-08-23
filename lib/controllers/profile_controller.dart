import 'dart:developer';

import 'package:ecommerce_app/services/firestorage_service.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxString imgUrl = ''.obs;

  var nameController = TextEditingController();

  var passController = TextEditingController();

  Future<void> uploadProfileImage() async {
    try {
      final imageUrl = await FireStorageService()
          .uploadImage(file: imgUrl.value, childName: 'images');

      await FirestoreService().uploadUserImage(url: imageUrl);
    } catch (e) {
      log(e.toString());
    }
  }
}
