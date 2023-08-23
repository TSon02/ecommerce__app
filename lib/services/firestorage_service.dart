import 'dart:io';

import 'package:ecommerce_app/controllers/add_product_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

final controller = Get.find<AddProductController>();
const uuid = Uuid();

class FireStorageService {
  Future<String> uploadImage(
      {required String file, required String childName}) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(childName)
        .child(FirebaseAuth.instance.currentUser!.uid);

    await ref.putFile(File(file)).whenComplete(() => null);

    final url = await ref.getDownloadURL();
    return url;
  }

  Future<dynamic> uploadProductImage({required String nameProduct}) async {
    controller.pImagesLink.clear();
    for (var item in controller.pImagesList) {
      if (item != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child('vendors')
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child(nameProduct)
            .child(uuid.v4());

        await ref.putFile(item).whenComplete(() => null);

        final url = await ref.getDownloadURL();

        controller.pImagesLink.add(url);
      }
    }
  }
}
