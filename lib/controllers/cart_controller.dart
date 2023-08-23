import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalPrice = 0.obs;

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final postalCodeController = TextEditingController();
  final phoneController = TextEditingController();

  var paymentIndex = 0.obs;
  var placingOrder = false.obs;

  late List<QueryDocumentSnapshot<Map<String, dynamic>>> productSnapshot;
  List products = [];

  void calTotalPrice(
      {required List<QueryDocumentSnapshot<Map<String, dynamic>>> items}) {
    for (var i = 0; i < items.length; i++) {
      totalPrice += items[i].data()['total_price'];
    }
  }
}
