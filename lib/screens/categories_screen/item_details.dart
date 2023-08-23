import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/lists.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/widgets/featured_product.dart';
import 'package:ecommerce_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_app/models/product.dart' as productmodel;
// import 'dart:math' as math;

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen(
      {super.key, required this.title, required this.productDetails});
  final String title;
  final productmodel.Product productDetails;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    // print(controller.isFavour.value);
    return WillPopScope(
      onWillPop: () async {
        controller.quantity.value = 0;
        controller.totalPrice.value = 0;
        controller.colorIndex.value = 0;
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          title: Text(
            title,
            style: const TextStyle(
              color: darkFontGrey,
              fontFamily: bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: () async {
                  if (controller.isFavour.value) {
                    await FirestoreService()
                        .removeFromWishlist(docId: productDetails.id!);
                    controller.isFavour(false);
                  } else {
                    await FirestoreService()
                        .addToWishlist(docId: productDetails.id!);
                    controller.isFavour(true);
                  }
                },
                icon: Icon(
                  Icons.favorite,
                  color: controller.isFavour.value ? redColor : darkFontGrey,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        height: 300,
                        viewportFraction: 1.0,
                        itemCount: productDetails.pImgs!.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            productDetails.pImgs![index],
                            width: double.infinity,
                            fit: BoxFit.fill,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          color: darkFontGrey,
                          fontFamily: semibold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      VxRating(
                        isSelectable: false,
                        onRatingUpdate: (value) {},
                        normalColor: textfieldGrey,
                        size: 25,
                        selectionColor: golden,
                        count: 5,
                        value: double.parse(productDetails.pRating!),
                        maxRating: 5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '\$${productDetails.pPrice}',
                        style: const TextStyle(
                          color: redColor,
                          fontFamily: bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: textfieldGrey,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Seller',
                                    style: TextStyle(
                                      fontFamily: semibold,
                                      color: whiteColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    productDetails.pSeller!,
                                    style: const TextStyle(
                                      fontFamily: semibold,
                                      color: darkFontGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const CircleAvatar(
                              backgroundColor: whiteColor,
                              child: Icon(
                                Icons.message_rounded,
                                color: darkFontGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Obx(
                            () => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Color: ',
                                          style:
                                              TextStyle(color: textfieldGrey),
                                        ),
                                      ),
                                      Row(
                                        children: List.generate(
                                          productDetails.pColors!.length,
                                          (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  controller.changeColorIndex(
                                                      index: index);
                                                },
                                                child: Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    color: Color(
                                                      // (math.Random().nextDouble() *
                                                      //         0xFFFFFF)
                                                      //     .toInt(),
                                                      int.parse(productDetails
                                                          .pColors![index]),
                                                    ).withOpacity(1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: index ==
                                                    controller.colorIndex.value,
                                                child: const Icon(
                                                  Icons.done,
                                                  color: redColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Quantity: ',
                                          style:
                                              TextStyle(color: textfieldGrey),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller.decreaseQuantity();
                                              controller.calculateTotalPrice(
                                                price: int.tryParse(
                                                  productDetails.pPrice!,
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(
                                            controller.quantity.value
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: darkFontGrey,
                                              fontFamily: bold,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              controller.increaseQuantity(
                                                available: int.parse(
                                                  productDetails.pQuantity!,
                                                ),
                                              );
                                              controller.calculateTotalPrice(
                                                price: int.tryParse(
                                                  productDetails.pPrice!,
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '(${productDetails.pQuantity} available)',
                                            style: const TextStyle(
                                              color: textfieldGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  height: 40,
                                  color: Colors.yellow[50],
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Total: ',
                                          style:
                                              TextStyle(color: textfieldGrey),
                                        ),
                                      ),
                                      Text(
                                        '\$${controller.totalPrice.value}',
                                        style: const TextStyle(
                                          color: redColor,
                                          fontSize: 16,
                                          fontFamily: bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Description',
                        style: TextStyle(
                          color: darkFontGrey,
                          fontFamily: semibold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        productDetails.pDesc!,
                        style: const TextStyle(
                          color: darkFontGrey,
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          5,
                          (index) => ListTile(
                            title: Text(
                              itemDetailButtonList[index],
                              style: const TextStyle(
                                  fontFamily: semibold, color: darkFontGrey),
                            ),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Products you may also like',
                        style: TextStyle(
                          fontFamily: bold,
                          fontSize: 16,
                          color: darkFontGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Row(
                      //     children: List.generate(
                      //       6,
                      //       (index) => FeaturedProduct(product: productDetails),
                      //     ),
                      //   ),
                      // ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: StreamBuilder(
                          stream: FirestoreService().getFeaturedProducts(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            final data = snapshot.data!.docs;

                            final List<productmodel.Product> products = [];

                            for (var dataItem in data) {
                              products.add(
                                productmodel.Product.fromJson(
                                  dataItem.data(),
                                ),
                              );
                            }

                            return Row(
                              children: List.generate(
                                products.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => ItemDetailsScreen(
                                          title: products[index].pName!,
                                          productDetails: products[index]),
                                    );
                                  },
                                  child:
                                      FeaturedProduct(product: products[index]),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: OurButton(
                onPress: () async {
                  if (controller.quantity > 0) {
                    await FirestoreService().addToCart(
                        title: productDetails.pName!,
                        img: productDetails.pImgs![0],
                        sellerName: productDetails.pSeller!,
                        color: productDetails
                            .pColors![controller.colorIndex.value],
                        quantity: controller.quantity.value,
                        tPrice: controller.totalPrice.value,
                        context: context,
                        vendorId: productDetails.vendorId!);

                    VxToast.show(context,
                        msg: 'Added to cart', bgColor: whiteColor);
                  } else {
                    VxToast.show(
                      context,
                      msg: 'Quantity more than 0',
                      bgColor: redColor,
                      textColor: whiteColor,
                    );
                  }
                },
                title: 'Add to cart',
                color: Colors.green,
                textColor: whiteColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
