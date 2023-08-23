import 'package:ecommerce_app/consts/colors.dart';
import 'package:ecommerce_app/consts/styles.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/widgets/wishlist_item.dart';
import 'package:flutter/material.dart';

class WishlistsScreen extends StatelessWidget {
  const WishlistsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text(
          'My Wishlist',
          style: TextStyle(
            fontFamily: semibold,
            color: darkFontGrey,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirestoreService().getAllWishlists(),
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

          final data = snapshot.data!.docs;
          return Container(
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
                  child: WishlistItem(item: item),
                  onDismissed: (direction) async {
                    await FirestoreService()
                        .removeFromWishlist(docId: item["id"].toString());
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
