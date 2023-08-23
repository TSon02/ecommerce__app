import 'dart:io';

import 'package:ecommerce_app/consts/consts.dart';
import 'package:ecommerce_app/controllers/profile_controller.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/services/firestore_service.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:ecommerce_app/widgets/bg_widget.dart';
import 'package:ecommerce_app/widgets/custom_textfield.dart';
import 'package:ecommerce_app/widgets/our_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    controller.nameController.text = widget.data['name'];
    controller.passController.text = widget.data['password'];

    return background(
      child: Obx(
        () => WillPopScope(
          onWillPop: () async {
            controller.imgUrl.value = '';
            return true;
          },
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                margin: const EdgeInsets.only(top: 50, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child:
                    // Obx(
                    //   () =>
                    Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        widget.data['imageUrl'].isEmpty
                            ? const CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(imgFc5),
                              )
                            : controller.imgUrl.value.isEmpty
                                ? CircleAvatar(
                                    radius: 45,
                                    // backgroundImage: FileImage(
                                    //   File(controller.imgUrl.value),
                                    // ),

                                    backgroundImage:
                                        NetworkImage(widget.data['imageUrl']),
                                  )
                                : CircleAvatar(
                                    radius: 45,
                                    backgroundImage: FileImage(
                                      File(controller.imgUrl.value),
                                    ),
                                  ),
                        Positioned(
                          bottom: -14,
                          right: -10,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: OurButton(
                                              onPress: () async {
                                                Get.back();
                                                final file = await imagePicker(
                                                    source: ImageSource.camera);

                                                controller.imgUrl.value =
                                                    file.path;
                                              },
                                              title: 'Camera',
                                              color: darkFontGrey,
                                              textColor: whiteColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: OurButton(
                                              onPress: () async {
                                                Get.back();

                                                final file = await imagePicker(
                                                    source:
                                                        ImageSource.gallery);

                                                controller.imgUrl.value =
                                                    file.path;
                                              },
                                              title: 'Library',
                                              color: darkFontGrey,
                                              textColor: whiteColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // OurButton(
                    //   onPress: () {},
                    //   title: 'Update',
                    //   color: redColor,
                    //   textColor: whiteColor,
                    // ),
                    const Divider(
                      color: redColor,
                      height: 24,
                      thickness: 1.5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customTextField(
                      hint: controller.nameController.text,
                      title: name,
                      isPass: false,
                      controller: controller.nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    customTextField(
                      hint: controller.passController.text,
                      title: password,
                      isPass: true,
                      controller: controller.passController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: OurButton(
                        onPress: () async {
                          // print(controller.imgUrl);

                          if (controller.imgUrl.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                            print('update profile image');
                          }

                          if (controller.nameController.text !=
                                  widget.data['name'] ||
                              controller.passController.text !=
                                  widget.data['password']) {
                            //

                            if (controller.nameController.text.isNotEmpty &&
                                controller.passController.text.trim().length >
                                    6) {
                              if (controller.passController.text !=
                                  widget.data['password']) {
                                FirebaseAuthServices().changeAuthPassword(
                                  password: widget.data['password'],
                                  email: widget.data['email'],
                                  newPassword:
                                      controller.passController.text.trim(),
                                );
                              }

                              FirestoreService()
                                  .updateUserProfile(
                                    name: controller.nameController.text,
                                    password: controller.passController.text,
                                  )
                                  .then(
                                    (value) => {
                                      VxToast.show(context,
                                          msg: 'Update profile successfully'),
                                    },
                                  );
                            } else {
                              // ignore: use_build_context_synchronously
                              VxToast.show(context,
                                  msg:
                                      'Name & Password cannot be empty & Characters of password more than 6 ');
                            }
                          } else {
                            // ignore: use_build_context_synchronously
                            VxToast.show(context,
                                msg: 'Profile is not changed');
                          }
                        },
                        title: 'Update',
                        color: redColor,
                        textColor: whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // ),
    );
  }
}
