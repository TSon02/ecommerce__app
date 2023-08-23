import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/cart_controller.dart';
import 'package:ecommerce_app/screens/cart_screen/payment_method.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:ecommerce_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          'Shipping Infor',
          style: TextStyle(
            fontFamily: semibold,
            color: darkFontGrey,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: OurButton(
          onPress: () {
            if (controller.addressController.text.length > 10) {
              Get.to(() => const PaymentMethods());
            } else {
              VxToast.show(
                context,
                msg: 'Please fill the form',
                bgColor: redColor,
                textColor: whiteColor,
              );
            }
          },
          title: 'Continue',
          color: redColor,
          textColor: whiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
              hint: 'Address',
              isPass: false,
              title: 'Address',
              controller: controller.addressController,
            ),
            customTextField(
              hint: 'City',
              isPass: false,
              title: 'City',
              controller: controller.cityController,
            ),
            customTextField(
              hint: 'State',
              isPass: false,
              title: 'State',
              controller: controller.stateController,
            ),
            customTextField(
              hint: 'Postal Code',
              isPass: false,
              title: 'Postal Code',
              controller: controller.postalCodeController,
            ),
            customTextField(
              hint: 'Phone',
              isPass: false,
              title: 'Phone',
              controller: controller.phoneController,
            ),
          ],
        ),
      ),
    );
  }
}
