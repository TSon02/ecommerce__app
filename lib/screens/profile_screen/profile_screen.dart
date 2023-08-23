import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/lists.dart';
import 'package:ecommerce_app/controllers/profile_controller.dart';
import 'package:ecommerce_app/screens/orders_screen/orders_screen.dart';
import 'package:ecommerce_app/screens/profile_screen/edit_profile.dart';
import 'package:ecommerce_app/screens/seller_products/seller_products.dart';
import 'package:ecommerce_app/screens/wishlists_screen/wishlists_screen.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/widgets/bg_widget.dart';
import 'package:ecommerce_app/widgets/details_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    // final controller = Get.find<ProfileController>();
    return background(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreService().getUser(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            }
            final data = snapshot.data!.docs[0].data();

            return SafeArea(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () async {
                        Get.to(
                          () => EditProfileScreen(
                            data: data,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        data['imageUrl'].isEmpty
                            ? const CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(imgFc5),
                              )
                            : CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  data['imageUrl'],
                                ),
                              ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'],
                                style: const TextStyle(
                                  fontFamily: semibold,
                                  color: whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                data['email'],
                                style: const TextStyle(
                                  color: whiteColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await FirebaseAuthServices().signoutMethod(context);
                            // Get.offAll(() => const LoginScreen());
                          },
                          child: const Text(
                            'Log out',
                            style: TextStyle(
                              color: whiteColor,
                              fontFamily: semibold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                    future: FirestoreService().getCounts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // print(snapshot.data);
                      final futureData = snapshot.data;
                      return Container(
                        color: redColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DetailCard(
                              count: futureData![0].toString(),
                              title: 'in your cart',
                            ),
                            DetailCard(
                              count: futureData[1].toString(),
                              title: 'in your wishlist',
                            ),
                            DetailCard(
                              count: futureData[2].toString(),
                              title: 'your orders',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    color: redColor,
                    padding: const EdgeInsets.all(12),
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: darkFontGrey,
                            );
                          },
                          itemCount: profileButtonsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                if (index == 0) {
                                  Get.to(() => const WishlistsScreen());
                                }

                                if (index == 1) {
                                  Get.to(() => const OrdersScreen());
                                }

                                if (index == 3) {
                                  Get.to(() => const SellerProducts());
                                }
                              },
                              title: Text(
                                profileButtonsList[index],
                                style: const TextStyle(
                                  fontFamily: semibold,
                                  color: darkFontGrey,
                                ),
                              ),
                              leading: Image.asset(profileButtonsIcon[index],
                                  width: 26),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
