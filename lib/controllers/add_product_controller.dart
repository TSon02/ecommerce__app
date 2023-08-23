import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/category.dart';

class AddProductController extends GetxController {
  var pNameController = TextEditingController();
  var pDescController = TextEditingController();
  var pPriceController = TextEditingController();
  var pQuantityController = TextEditingController();

  var categoryList = [].obs;
  var subCategoryList = [].obs;
  List<Category> category = [];
  List<String> pImagesLink = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subCategoryValue = ''.obs;
  var colorIndex = 0.obs;

  var isUploaded = false.obs;

  getCategories() async {
    final data =
        await rootBundle.loadString('lib/services/category_model.json');

    final cat = categoriesFromJson(data);

    category = cat.categories!;

    // print(data);
    // print(category);
  }

  void populateCategoryList() {
    // print('populatecategory');
    // print(category);
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
    // print(categoryList);
  }

  void populateSubCategoryList({required String cat}) {
    // print(cat);
    // print('subcategoryList');
    subCategoryList.clear();
    // print(subCategoryList);
    // print('category');
    // print(category);
    var data = category.where((element) => element.name == cat).toList();
    // print(data);
    for (var i = 0; i < data.first.subcategory!.length; i++) {
      subCategoryList.add(data.first.subcategory![i]);
    }
    // print('subcategoryList.....');

    // print(subCategoryList);
  }

  void clearProducts() {
    pNameController.text = '';
    pDescController.text = '';
    pPriceController.text = '';
    pQuantityController.text = '';
    categoryValue.value = '';
    subCategoryValue.value = '';
    pImagesList.value = [null, null, null];
    colorIndex.value = 0;
  }
}
