import 'dart:developer';

import 'package:ecommerce_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserCredential?> loginMethod(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(
        context,
        msg: e.toString(),
        bgColor: redColor,
        textColor: whiteColor,
      );
    }
    return userCredential;
  }

  Future<UserCredential?> signupMethod(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserCredential? userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(
        context,
        msg: e.toString(),
        bgColor: redColor,
        textColor: whiteColor,
      );
    }

    return userCredential;
  }

  Future<void> signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  Future<void> changeAuthPassword(
      {required String email,
      required String newPassword,
      required String password}) async {
    try {
      final cred =
          EmailAuthProvider.credential(email: email, password: password);
      await auth.currentUser!
          .reauthenticateWithCredential(cred)
          .then((value) async {
        return await auth.currentUser!.updatePassword(newPassword);
      });
    } on FirebaseAuthException catch (e) {
      log(e.toString());
    }
  }
}
