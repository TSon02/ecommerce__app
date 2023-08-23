import 'package:ecommerce_app/models/category.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subCat = [];
  var isFavour = false.obs;

  getSubCategories({required String title}) async {
    subCat.clear();
    var data = await rootBundle.loadString('lib/services/category_model.json');
    final decoded = categoriesFromJson(data);

    var results =
        decoded.categories!.where((element) => element.name == title).toList();

    for (var e in results[0].subcategory!) {
      subCat.add(e);
    }
  }

  changeColorIndex({required int index}) {
    colorIndex.value = index;
  }

  increaseQuantity({required int available}) {
    if (quantity.value < available) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalPrice({required price}) {
    totalPrice.value = price * quantity.value;
  }

  void checkIfFavorite({required Product product}) {
    if (product.pWishlist!.contains(FirebaseAuth.instance.currentUser!.uid)) {
      isFavour(true);
    } else {
      isFavour(false);
    }
  }
}
