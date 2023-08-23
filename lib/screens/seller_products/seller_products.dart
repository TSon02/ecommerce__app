import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:ecommerce_app/controllers/add_product_controller.dart';
import 'package:ecommerce_app/screens/seller_products/new_product.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SellerProducts extends StatelessWidget {
  const SellerProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddProductController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          'Seller Products',
          style: TextStyle(
            fontFamily: semibold,
            color: darkFontGrey,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.getCategories();
              controller.populateCategoryList();
              Get.to(() => const AddNewProduct());
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirestoreService().getAllSellerProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text('No Products Selling'),
            );
          }

          final data = snapshot.data!.docs;

          return Container(
            margin: const EdgeInsets.all(4),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: lightGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 1),
            ),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 2,
                );
              },
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    data[index]['p_imgs'][0],
                  ),
                  title: Text(
                    data[index]['p_name'],
                    style: const TextStyle(
                      fontFamily: semibold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    '${data[index]['p_price'].toString()}\$',
                    style: const TextStyle(
                      fontFamily: semibold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        data[index]['p_quantity'].toString(),
                        style: const TextStyle(
                          fontFamily: semibold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      // Container(
                      //   width: 30,
                      //   height: 30,
                      //   decoration: BoxDecoration(
                      //     color: Color(
                      //       int.tryParse(data[index]['color'])!,
                      //     ),
                      //     shape: BoxShape.circle,
                      //   ),
                      // ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
