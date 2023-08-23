import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/lists.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/screens/home_screen/home.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text(
            'Choose Payment Method',
            style: TextStyle(
              fontFamily: semibold,
              color: darkFontGrey,
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: OurButton(
            onPress: () async {
              await FirestoreService().placeOrder(
                  paymentMethod: paymentMethods[controller.paymentIndex.value],
                  totalAmount: controller.totalPrice.value);

              await FirestoreService().clearCart();

              // ignore: use_build_context_synchronously
              VxToast.show(context, msg: 'Order placed successfully');

              Get.offAll(() => const Home());
            },
            title: 'Place my Order',
            color: redColor,
            textColor: whiteColor,
            isLoading: controller.placingOrder.value,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsList.length, (index) {
                return InkWell(
                  onTap: () {
                    controller.paymentIndex.value = index;
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 5,
                          style: BorderStyle.solid,
                        )),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodsList[index],
                          width: double.infinity,
                          fit: BoxFit.fill,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.clear
                              : BlendMode.darken,
                          color: controller.paymentIndex.value == index
                              ? null
                              : Colors.black.withOpacity(0.4),
                          height: 120,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  value: true,
                                  onChanged: (value) {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              )
                            : Container(),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Text(
                            paymentMethods[index],
                            style: const TextStyle(
                              color: whiteColor,
                              fontSize: 16,
                              fontFamily: semibold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
