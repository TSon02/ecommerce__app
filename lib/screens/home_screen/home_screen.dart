import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/lists.dart';
import 'package:ecommerce_app/controllers/home_controller.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/models/product.dart' as productmodel;
import 'package:ecommerce_app/screens/categories_screen/item_details.dart';
import 'package:ecommerce_app/screens/home_screen/search_screen.dart';
import 'package:ecommerce_app/services/firestore_service.dart';

import 'package:ecommerce_app/widgets/featured_button.dart';
import 'package:ecommerce_app/widgets/featured_product.dart';
import 'package:ecommerce_app/widgets/homebuttons.dart';
import 'package:flutter/material.dart';

import 'package:ecommerce_app/widgets/product.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final productsController = Get.put(ProductController());
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              // color: lightGrey,

              child: Material(
                elevation: 5,
                child: TextFormField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: whiteColor,
                    hintText: 'Search anything...',
                    hintStyle: const TextStyle(
                      color: textfieldGrey,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        if (controller
                            .searchController.text.isNotEmptyAndNotNull) {
                          Get.to(
                            () => SearchScreen(
                              title: controller.searchController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                slidersList[index],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => HomeButtons(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          width: MediaQuery.sizeOf(context).width / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? 'Todays Deal' : 'Flash Deal',
                          onPress: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                secondSlidersList[index],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => HomeButtons(
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          width: MediaQuery.sizeOf(context).width / 3.5,
                          icon: index == 0
                              ? icCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          title: index == 0
                              ? 'Top Categories'
                              : index == 1
                                  ? 'Brands'
                                  : 'Top Sellers',
                          onPress: () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Featured Categories',
                        style: TextStyle(
                          color: darkFontGrey,
                          fontSize: 18,
                          fontFamily: semibold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              FeaturedButton(
                                icon: featuredImages1[index],
                                title: featuredTitles1[index],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              FeaturedButton(
                                icon: featuredImages2[index],
                                title: featuredTitles2[index],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: redColor,
                      ),
                      padding: const EdgeInsets.only(
                        top: 12,
                        left: 12,
                        right: 12,
                        bottom: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Featured Product',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
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
                                        productsController.checkIfFavorite(
                                            product: products[index]);

                                        Get.to(
                                          () => ItemDetailsScreen(
                                              title: products[index].pName!,
                                              productDetails: products[index]),
                                        );
                                      },
                                      child: FeaturedProduct(
                                          product: products[index]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(
                                secondSlidersList[index],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder(
                        stream: FirestoreService().getAllProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final data = snapshot.data!.docs;
                          return GridView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              // crossAxisSpacing: 8,
                              mainAxisExtent: 280,
                            ),
                            itemBuilder: (context, index) {
                              final productData = productmodel.Product.fromJson(
                                  data[index].data());

                              return GestureDetector(
                                onTap: () {
                                  productsController.checkIfFavorite(
                                    product: productData,
                                  );

                                  Get.to(() => ItemDetailsScreen(
                                      productDetails: productData,
                                      title: data[index].data()['p_category']));
                                },
                                child: Product(
                                  height: 200,
                                  productDetails: productData,
                                ),
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
