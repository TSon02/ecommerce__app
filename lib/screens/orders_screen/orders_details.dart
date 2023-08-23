import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:ecommerce_app/widgets/order_row_details.dart';
import 'package:ecommerce_app/widgets/order_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  const OrdersDetails({super.key, required this.itemOrder});
  final Map<String, dynamic> itemOrder;

  @override
  Widget build(BuildContext context) {
    // print(itemOrder);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders Details',
          style: TextStyle(
            fontFamily: semibold,
            color: darkFontGrey,
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OrderStatus(
                        color: redColor,
                        iconData: Icons.shopping_cart_checkout,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OrderStatus(
                        color: Colors.blue,
                        iconData: Icons.thumb_up_alt_outlined,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OrderStatus(
                        color: Colors.yellow,
                        iconData: Icons.fire_truck_outlined,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      OrderStatus(
                        color: Colors.brown,
                        iconData: Icons.done_all_outlined,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stepper(
                    physics: const NeverScrollableScrollPhysics(),
                    margin: EdgeInsets.zero,
                    controlsBuilder: (context, controller) {
                      return const SizedBox();
                    },
                    stepIconBuilder: (stepIndex, stepState) {
                      return stepIndex == 0
                          ? const Icon(
                              Icons.done,
                              color: whiteColor,
                            )
                          : null;
                    },
                    // currentStep: _index,
                    // onStepCancel: () {
                    //   if (_index > 0) {
                    //     setState(() {
                    //       _index -= 1;
                    //     });
                    //   }
                    // },
                    // onStepContinue: () {
                    //   if (_index <= 0) {
                    //     setState(() {
                    //       _index += 1;
                    //     });
                    //   }
                    // },
                    // onStepTapped: (int index) {
                    //   setState(() {
                    //     _index = index;
                    //   });
                    // },
                    steps: const <Step>[
                      Step(
                        isActive: true,
                        content: SizedBox.shrink(),
                        title: Text('Order Placed'),
                      ),
                      Step(
                        isActive: true,
                        title: Text('Confirmed'),
                        content: SizedBox.shrink(),
                      ),
                      Step(
                        // isActive: false,
                        title: Text('On Delivery'),
                        content: SizedBox.shrink(),
                      ),
                      Step(
                        // isActive: false,
                        title: Text('Delivered'),
                        content: SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(3, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  OrderRowDetails(
                    titleL: 'Order Code',
                    descL: itemOrder['order_code'].toString(),
                    titleR: 'Shipping Method',
                    descR: itemOrder['shipping_method'],
                  ),
                  OrderRowDetails(
                    titleL: 'Order Date',
                    descL: intl.DateFormat()
                        .add_yMd()
                        .format(itemOrder['order_date'].toDate()),
                    titleR: 'Payment Method',
                    descR: itemOrder['payment_method'],
                  ),
                  const OrderRowDetails(
                    titleL: 'Payment Status',
                    descL: 'Unpaid X',
                    titleR: 'Delivery Status',
                    descR: 'Order Placed',
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Shipping Address',
                              style: TextStyle(
                                fontFamily: semibold,
                              ),
                            ),
                            Text('Name: ${itemOrder['order_by_name']}'),
                            Text('Email: ${itemOrder['order_by_email']}'),
                            Text('Address: ${itemOrder['order_by_address']}'),
                            Text('City: ${itemOrder['order_by_city']}'),
                            Text('State: ${itemOrder['order_by_state']}'),
                            Text('Phone: ${itemOrder['order_by_phone']}'),
                            Text(
                                'Postal Code: ${itemOrder['order_by_postalcode']}'),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontFamily: semibold,
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              '${itemOrder['total_amount']}\$',
                              style: const TextStyle(
                                color: redColor,
                                fontFamily: bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Ordered Product',
              style: TextStyle(
                fontSize: 18,
                color: darkFontGrey,
                fontFamily: bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(3, 3),
                  )
                ],
              ),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OrderRowDetails(
                        titleL: itemOrder['orders'][index]['title'],
                        titleR:
                            '${itemOrder['orders'][index]['total_price']}\$',
                        descL: '${itemOrder['orders'][index]['quantity']}x',
                        descR: 'Refundable',
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 40,
                        height: 20,
                        color: Color(
                            int.parse(itemOrder['orders'][index]['color'])),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 2,
                  );
                },
                itemCount: itemOrder['orders'].length,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(3, 3),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SUB TOTAL',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: semibold,
                      color: darkFontGrey,
                    ),
                  ),
                  Text(
                    '${itemOrder['total_amount']}\$',
                    style: const TextStyle(
                      color: redColor,
                      fontFamily: bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
