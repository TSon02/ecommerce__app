import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/screens/auth_screen/login_screen.dart';
import 'package:ecommerce_app/screens/home_screen/home.dart';
import 'package:ecommerce_app/widgets/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  Future<void> changeScreen() async {
    return await Future.delayed(
      const Duration(seconds: 3),
      () {
        FirebaseAuth.instance.authStateChanges().listen(
          (User? user) {
            // print(user == null);
            // print(user?.displayName);
            // print(user?.email);
            // print(user?.emailVerified);
            // print(mounted);
            if (user == null) {
              Get.offAll(() => const LoginScreen());
            }

            if (user != null) {
              // print('splash screen');
              Get.offAll(() => const Home());
            }
            // print(mounted);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Image.asset(icSplashBg, width: 300),
            const SizedBox(height: 20),
            appLogo(),
            const SizedBox(height: 10),
            const Text(
              appname,
              style: TextStyle(
                fontFamily: bold,
                color: whiteColor,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              appversion,
              style: TextStyle(
                color: whiteColor,
              ),
            ),
            const Spacer(),
            const Text(
              credits,
              style: TextStyle(color: whiteColor),
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
