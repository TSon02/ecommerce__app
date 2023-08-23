import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/firebase_consts.dart';
import 'package:ecommerce_app/controllers/add_product_controller.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/models/user.dart' as modeluser;
import 'package:ecommerce_app/models/product.dart' as productmodel;

import 'package:ecommerce_app/services/firestorage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class FirestoreService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> storeUserData(
      {required String name,
      required String email,
      required String password}) async {
    final modeluser.User user = modeluser.User(
      cartCount: '0',
      uid: auth.currentUser!.uid,
      wishlistCount: '0',
      password: password,
      orderCount: '0',
      imageUrl: '',
      name: name,
      email: email,
    );

    await firestore.collection(usersCollection).doc(auth.currentUser!.uid).set(
          user.toJson(),
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUser({required String uid}) {
    return firestore
        .collection(usersCollection)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Future<void> uploadUserImage({required String url}) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(auth.currentUser!.uid)
          .update({'imageUrl': url});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> updateUserProfile(
      {required String name, required String password}) async {
    try {
      await firestore
          .collection(usersCollection)
          .doc(auth.currentUser!.uid)
          .update({
        'name': name,
        'password': password,
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProducts(String category) {
    return firestore
        .collection(productsCollection)
        .where('p_category', isEqualTo: category)
        .snapshots();
  }

  Future<void> addToCart(
      {required String title,
      required String img,
      required String sellerName,
      required String color,
      required int quantity,
      required int tPrice,
      required BuildContext context,
      required String vendorId}) async {
    final time = DateTime.now().millisecondsSinceEpoch;

    return await firestore.collection(cartCollection).doc(time.toString()).set({
      'title': title,
      'img': img,
      'seller_name': sellerName,
      'color': color,
      'quantity': quantity,
      'total_price': tPrice,
      'added_by': FirebaseAuth.instance.currentUser!.uid,
      'id': time,
      'vendor_id': vendorId,
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCart() {
    return firestore
        .collection(cartCollection)
        .where('added_by', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  Future<void> deleteCart({required String id}) async {
    try {
      await firestore.collection(cartCollection).doc(id).delete();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> getUsername() async {
    var name = await firestore
        .collection(usersCollection)
        .doc(auth.currentUser!.uid)
        .get();
    return name.data()!['name'];
  }

  Future<void> addToWishlist({required String docId}) async {
    await firestore.collection(productsCollection).doc(docId).update(
      {
        'p_wishlist': FieldValue.arrayUnion(
          [auth.currentUser!.uid],
        )
      },
    );
  }

  Future<void> removeFromWishlist({required String docId}) async {
    await firestore.collection(productsCollection).doc(docId).update(
      {
        'p_wishlist': FieldValue.arrayRemove(
          [auth.currentUser!.uid],
        )
      },
    );
  }

  Future<void> placeOrder(
      {required String paymentMethod, required totalAmount}) async {
    Get.find<CartController>().placingOrder(true);

    getProductDetails();
    try {
      await firestore.collection(ordersCollection).doc().set(
        {
          'order_by': auth.currentUser!.uid,
          'order_code': DateTime.now().millisecondsSinceEpoch,
          'order_by_name': Get.find<HomeController>().username,
          'order_date': FieldValue.serverTimestamp(),
          'order_by_email': auth.currentUser!.email,
          'order_by_address': Get.find<CartController>().addressController.text,
          'order_by_state': Get.find<CartController>().stateController.text,
          'order_by_city': Get.find<CartController>().cityController.text,
          'order_by_phone': Get.find<CartController>().phoneController.text,
          'order_by_postalcode':
              Get.find<CartController>().postalCodeController.text,
          'shipping_method': 'Home Delivery',
          'payment_method': paymentMethod,
          'order_placed': true,
          'order_confirmed': false,
          'order_delivered': false,
          'order_on_delivery': false,
          'total_amount': totalAmount,
          'orders': FieldValue.arrayUnion(Get.find<CartController>().products),
        },
      );
    } catch (e) {
      log(e.toString());
    }
    Get.find<CartController>().placingOrder(false);
  }

  void getProductDetails() {
    final controller = Get.find<CartController>();
    final productCartSnap = controller.productSnapshot;
    controller.products.clear();
    for (var i = 0; i < productCartSnap.length; i++) {
      controller.products.add(
        {
          'color': productCartSnap[i].data()['color'],
          'img': productCartSnap[i].data()['img'],
          'vendor_id': productCartSnap[i].data()['vendor_id'],
          'quantity': productCartSnap[i].data()['quantity'],
          'total_price': productCartSnap[i].data()['total_price'],
          'title': productCartSnap[i].data()['title'],
        },
      );
    }
  }

  Future<void> clearCart() async {
    final productCartSnap = Get.find<CartController>().productSnapshot;
    // print('cartSnap: ');
    // print(productCartSnap);
    try {
      for (var i = 0; i < productCartSnap.length; i++) {
        // print(productCartSnap[i].data());
        await firestore
            .collection(cartCollection)
            .doc(productCartSnap[i].data()['id'].toString())
            .delete();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOrders() {
    return firestore
        .collection(ordersCollection)
        .where('order_by', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllWishlists() {
    return firestore
        .collection(productsCollection)
        .where('p_wishlist', arrayContains: auth.currentUser!.uid)
        .snapshots();
  }

  Future<List<int?>> getCounts() async {
    final res = await Future.wait(
      [
        firestore
            .collection(cartCollection)
            .where('added_by', isEqualTo: auth.currentUser!.uid)
            .get()
            .then(
          (value) {
            return value.docs.length;
          },
        ),
        firestore
            .collection(productsCollection)
            .where('p_wishlist', arrayContains: auth.currentUser!.uid)
            .get()
            .then(
          (value) {
            return value.docs.length;
          },
        ),
        firestore
            .collection(ordersCollection)
            .where('order_by', isEqualTo: auth.currentUser!.uid)
            .get()
            .then(
          (value) {
            return value.docs.length;
          },
        ),
      ],
    );
    return res;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() {
    return firestore.collection(productsCollection).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFeaturedProducts() {
    return firestore
        .collection(productsCollection)
        .where('is_featured', isEqualTo: true)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> searchResults(
      {required String keyword}) async {
    return await firestore
        .collection(productsCollection)
        .where('p_name', isLessThanOrEqualTo: keyword)
        .get();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getSubCategoryProducts(
      {required String title}) {
    return firestore
        .collection(productsCollection)
        .where('p_subcategory', isEqualTo: title)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllSellerProducts() {
    return firestore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  Future<void> uploadProduct({required BuildContext context}) async {
    final controller = Get.find<AddProductController>();
    final homeController = Get.find<HomeController>();
    try {
      await FireStorageService()
          .uploadProductImage(nameProduct: controller.pNameController.text);

      final id = uuid.v1();
      final product = productmodel.Product(
        pCategory: controller.categoryValue.value,
        pImgs: controller.pImagesLink,
        pQuantity: controller.pQuantityController.text,
        pRating: '5.0',
        pName: controller.pNameController.text,
        vendorId: auth.currentUser!.uid,
        pDesc: controller.pDescController.text,
        pPrice: controller.pPriceController.text,
        pSeller: homeController.username,
        pColors: [Colors.blue.value.toString(), Colors.green.value.toString()],
        pSubcategory: controller.subCategoryValue.value,
        pWishlist: [''],
        id: id,
        pIsFeatured: false,
      );

      await firestore
          .collection(productsCollection)
          .doc(id)
          .set(product.toJson());

      VxToast.show(context, msg: 'Uploaded product successfully');
    } catch (e) {
      VxToast.show(context, msg: e.toString());
      log(e.toString());
    }
  }
}

const uuid = Uuid();
