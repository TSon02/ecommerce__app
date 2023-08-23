import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/models/product.dart' as productmodel;
import 'package:ecommerce_app/screens/categories_screen/item_details.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/widgets/bg_widget.dart';
import 'package:ecommerce_app/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key, required this.title});

  final String title;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final controller = Get.put(ProductController());
  late Stream<QuerySnapshot<Map<String, dynamic>>> productMethod;

  switchCategory(e) {
    if (controller.subCat.contains(e)) {
      // print('true subcategory');
      setState(() {
        productMethod = FirestoreService().getSubCategoryProducts(title: e);
      });
    } else {
      // print('false subcategory');

      productMethod = FirestoreService().getProducts(e);
    }
  }

  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return background(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: bold,
              color: whiteColor,
            ),
          ),
        ),
        body:
            // StreamBuilder(
            // stream: productMethod,
            // builder: (context, snapshot) {
            //   if (snapshot.connectionState == ConnectionState.waiting) {
            //     return const Center(
            //       child: CircularProgressIndicator(),
            //     );
            //   }

            //   if (snapshot.data!.docs.isEmpty) {
            //     return const Center(
            //       child: Text(
            //         'No products found!',
            //         style: TextStyle(
            //           color: darkFontGrey,
            //           fontSize: 18,
            //           fontFamily: semibold,
            //         ),
            //       ),
            //     );
            //   }

            //   final data = snapshot.data!.docs;
            //   final List<productmodel.Product> products = [];

            //   for (var product in data) {
            //     products.add(productmodel.Product.fromJson(product.data()));
            //   }
            //   // print(productmodel.Product.fromJson(data));
            //   // print('products');
            //   // print(products);
            // return
            Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(
                      controller.subCat.length,
                      (index) => InkWell(
                            onTap: () {
                              switchCategory(controller.subCat[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 100,
                              height: 60,
                              alignment: Alignment.center,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                controller.subCat[index],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: darkFontGrey,
                                  fontFamily: semibold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              StreamBuilder(
                stream: productMethod,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Expanded(
                      child: Center(
                        // heightFactor: 10,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Expanded(
                      child: Center(
                        child: Text(
                          'No products found!',
                          style: TextStyle(
                            color: darkFontGrey,
                            fontSize: 18,
                            fontFamily: semibold,
                          ),
                        ),
                      ),
                    );
                  }

                  final data = snapshot.data!.docs;
                  final List<productmodel.Product> products = [];

                  for (var product in data) {
                    products.add(productmodel.Product.fromJson(product.data()));
                  }
                  // print(productmodel.Product.fromJson(data));
                  // print('products');
                  // print(products);
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent: 250,
                          mainAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              controller.checkIfFavorite(
                                  product: products[index]);
                              Get.to(
                                () => ItemDetailsScreen(
                                  productDetails: products[index],
                                  title: data[index].data()['p_name'],
                                ),
                              );
                            },
                            child: Product(
                              height: 150,
                              productDetails: products[index],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
