import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var currentNavIndex = 0.obs;
  var username = '';

  var searchController = TextEditingController();

  @override
  void onInit() async {
    super.onInit();
    username = await FirestoreService().getUsername();
    // print(username);
  }
}
