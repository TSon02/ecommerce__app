import 'dart:developer';

import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/screens/home_screen/home.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/widgets/applogo_widget.dart';
import 'package:ecommerce_app/widgets/bg_widget.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:ecommerce_app/widgets/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isCheck = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return background(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.1,
            ),
            appLogo(),
            const SizedBox(height: 10),
            const Text(
              'Join the $appname',
              style:
                  TextStyle(color: whiteColor, fontFamily: bold, fontSize: 18),
            ),
            const SizedBox(height: 15),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                  color: whiteColor),
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 70,
                child: Column(
                  children: [
                    customTextField(
                      hint: nameHint,
                      title: name,
                      isPass: false,
                      controller: nameController,
                    ),
                    customTextField(
                        hint: emailHint,
                        isPass: false,
                        title: email,
                        controller: emailController),
                    customTextField(
                        isPass: true,
                        hint: passwordHint,
                        title: password,
                        controller: passwordController),
                    customTextField(
                      hint: passwordHint,
                      isPass: true,
                      title: retypePassword,
                      controller: passwordRetypeController,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password'),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isCheck,
                          onChanged: (value) {
                            setState(() {
                              _isCheck = value!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: redColor,
                                  ),
                                ),
                                TextSpan(
                                  text: ' & ',
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: redColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 50,
                      child: OurButton(
                        color: _isCheck ? redColor : lightGrey,
                        onPress: () async {
                          if (_isCheck != false &&
                              nameController.text.trim().isNotEmpty &&
                              emailController.text.trim().isNotEmpty &&
                              passwordController.text.trim().isNotEmpty &&
                              passwordRetypeController.text.trim().isNotEmpty) {
                            if (passwordController.text !=
                                passwordRetypeController.text) {
                              VxToast.show(
                                context,
                                msg: 'Password do not match',
                                bgColor: redColor,
                                textColor: whiteColor,
                              );
                            } else {
                              try {
                                await FirebaseAuthServices()
                                    .signupMethod(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  context: context,
                                )
                                    .then(
                                  (value) async {
                                    if (value == null) {
                                      return;
                                    } else {
                                      await FirestoreService()
                                          .storeUserData(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text)
                                          .then(
                                        (value) async {
                                          VxToast.show(context,
                                              msg: 'Logged in successfully',
                                              bgColor: lightGrey);
                                          await Future.delayed(
                                            const Duration(seconds: 2),
                                          );
                                          await Get.offAll(() => const Home());
                                        },
                                      );
                                    }
                                  },
                                );
                              } on FirebaseException catch (e) {
                                log(e.toString());
                                FirebaseAuthServices().signoutMethod(context);
                              }
                            }
                          } else {
                            VxToast.show(
                              context,
                              msg: 'Please enter all of the fields',
                              textColor: whiteColor,
                              bgColor: redColor,
                            );
                          }
                        },
                        textColor: whiteColor,
                        title: 'Sign up',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(
                                color: fontGrey,
                                fontFamily: bold,
                              ),
                            ),
                            TextSpan(
                              text: ' Log in',
                              style: TextStyle(
                                color: redColor,
                                fontFamily: bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
