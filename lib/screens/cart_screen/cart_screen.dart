import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/screens/cart_screen/shipping_screen.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/widgets/cart_item.dart';
import 'package:ecommerce_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          "Your Cart",
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirestoreService().getCart(),
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
                  'Cart is Empty',
                  style: TextStyle(
                    fontFamily: semibold,
                    color: darkFontGrey,
                    fontSize: 18,
                  ),
                ),
              );
            }
            final data = snapshot.data!.docs;
            controller.productSnapshot = data;
            controller.totalPrice.value = 0;
            controller.calTotalPrice(items: data);

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Obx(
                () => Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: lightGrey,
                          shape: BoxShape.circle,
                        ),
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final item = data[index].data();

                            return Dismissible(
                              key: ValueKey(item),
                              child: CartItem(item: item),
                              onDismissed: (direction) async {
                                await FirestoreService()
                                    .deleteCart(id: item["id"].toString());
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(1, 1),
                            ),
                            BoxShadow(
                              offset: Offset(-1, -1),
                            ),
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total price :',
                            style: TextStyle(
                              fontFamily: semibold,
                              color: darkFontGrey,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${controller.totalPrice.value.toString()}\$',
                            style: const TextStyle(
                              fontSize: 16,
                              color: redColor,
                              fontFamily: semibold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OurButton(
                        onPress: () {
                          Get.to(() => const ShippingScreen());
                        },
                        title: 'Proceed to shipping',
                        color: redColor,
                        textColor: whiteColor,
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
