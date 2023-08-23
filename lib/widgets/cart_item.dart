import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key, required this.item});

  final Map<String, dynamic> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.maxFinite,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: lightGolden,
        ),
      ),
      child: ListTile(
        leading: Image.network(
          item['img'],
        ),
        title: Text(
          item['title'],
          style: const TextStyle(
            fontFamily: semibold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          '${item['total_price'].toString()}\$',
          style: const TextStyle(
            fontFamily: semibold,
            fontSize: 16,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item['quantity'].toString(),
              style: const TextStyle(
                fontFamily: semibold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 18,
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Color(
                  int.tryParse(item['color'])!,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
