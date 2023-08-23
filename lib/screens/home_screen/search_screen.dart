import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/screens/categories_screen/item_details.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/models/product.dart' as productmodel;
import 'package:ecommerce_app/widgets/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    // log(title);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Results',
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: FutureBuilder(
        future: FirestoreService().searchResults(keyword: title),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return Container(
              alignment: Alignment.center,
              color: whiteColor,
              child: const Text(
                'Results is Empty',
                style: TextStyle(
                  fontFamily: semibold,
                  color: darkFontGrey,
                  fontSize: 18,
                ),
              ),
            );
          }

          final data = snapshot.data!.docs;

          final List<productmodel.Product> products = [];

          for (var product in data) {
            products.add(
              productmodel.Product.fromJson(
                product.data(),
              ),
            );
          }

          final filtered = products
              .where(
                (element) => element.pName.toString().toLowerCase().contains(
                      title.toLowerCase(),
                    ),
              )
              .toList();

          if (filtered.isEmpty) {
            return Container(
              alignment: Alignment.center,
              color: whiteColor,
              child: const Text(
                'Results is Empty',
                style: TextStyle(
                  fontFamily: semibold,
                  color: darkFontGrey,
                  fontSize: 18,
                ),
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filtered.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 260),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  controller.checkIfFavorite(product: filtered[index]);

                  Get.to(
                    () => ItemDetailsScreen(
                        title: filtered[index].pName!,
                        productDetails: filtered[index]),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(offset: Offset(1, 1), blurRadius: 5),
                      BoxShadow(
                        offset: Offset(-1, -1),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Product(
                    productDetails: filtered[index],
                    height: 180,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
