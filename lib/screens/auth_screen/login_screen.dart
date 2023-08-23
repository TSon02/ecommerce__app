import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/consts/lists.dart';
import 'package:ecommerce_app/screens/auth_screen/signup_screen.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/widgets/applogo_widget.dart';
import 'package:ecommerce_app/widgets/bg_widget.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:ecommerce_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

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
              'Log in to $appname',
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
                      hint: emailHint,
                      title: email,
                      isPass: false,
                      controller: emailController,
                    ),
                    customTextField(
                      hint: passwordHint,
                      title: password,
                      isPass: true,
                      controller: passwordController,
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
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 50,
                      child: OurButton(
                        color: redColor,
                        onPress: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          if (passwordController.text.trim().isNotEmpty &&
                              emailController.text.trim().isNotEmpty) {
                            await FirebaseAuthServices()
                                .loginMethod(
                              email: emailController.text,
                              password: passwordController.text,
                              context: context,
                            )
                                .then(
                              (value) async {
                                if (value == null) {
                                  return;
                                } else {
                                  VxToast.show(context,
                                      msg: 'Logged in successfully',
                                      bgColor: lightGrey);
                                  // await Future.delayed(
                                  //   const Duration(seconds: 2),
                                  // );
                                  // Get.offAll(() => const Home());
                                }
                              },
                            );
                          } else {
                            VxToast.show(
                              context,
                              msg: 'Please enter all of the fields',
                              textColor: whiteColor,
                              bgColor: redColor,
                            );
                          }

                          setState(() {
                            _isLoading = false;
                          });
                        },
                        textColor: whiteColor,
                        title: 'Log in',
                        isLoading: _isLoading,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Create a new account',
                      style: TextStyle(
                        color: fontGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width - 50,
                      child: OurButton(
                        color: lightGolden,
                        onPress: () {
                          Get.to(() => const SignUpScreen());
                        },
                        textColor: redColor,
                        title: 'Sign up',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Log in with',
                      style: TextStyle(
                        color: fontGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: lightGrey,
                            radius: 25,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                    )
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
