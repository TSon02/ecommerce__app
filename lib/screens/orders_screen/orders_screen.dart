import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:ecommerce_app/screens/orders_screen/orders_details.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          'My Orders',
          style: TextStyle(
            fontFamily: semibold,
            color: darkFontGrey,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreService().getAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No orders yet!!',
                style: TextStyle(
                  color: darkFontGrey,
                  fontSize: 18,
                  fontFamily: semibold,
                ),
              ),
            );
          }
          // print(snapshot.data!.docs[0].data());

          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index].data();
              return ListTile(
                leading: Text(
                  (index + 1).toString(),
                  style: const TextStyle(
                    fontFamily: bold,
                    color: darkFontGrey,
                  ),
                ),
                title: Text(
                  item['order_code'].toString(),
                  style: const TextStyle(
                    color: redColor,
                    fontFamily: semibold,
                  ),
                ),
                subtitle: Text(
                  '${item['total_amount'].toString()}\$',
                  style: const TextStyle(
                    color: redColor,
                    fontFamily: semibold,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    Get.to(() => OrdersDetails(
                          itemOrder: item,
                        ));
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: darkFontGrey,
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
