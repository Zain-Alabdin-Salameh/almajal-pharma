import 'package:almajal_pharma/global/controllers/auth.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../global/utils/colors.dart';
import '../../global/utils/padding.dart';
import '../../global/widgets/background.dart';
import '../../global/widgets/logo.dart';
import '../signup/controllers/register_controller.dart';

class CangePasswordScreen extends GetView {
  CangePasswordScreen({super.key});
  @override
  final AuthController controller = Get.find();
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: GetBuilder(
              init: controller,
              builder: (controller) {
                // controller.getUser();
                if (controller.initialized && controller.user != null) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: AppPading.defaultPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(child: Logo()),
                          Padding(
                            padding: AppPading.defaultPadding,
                            child: Center(
                              child: Form(
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextFormField(
                                      controller: oldPass,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.password_outlined,
                                            color: AppColors.icons,
                                            size: 25,
                                          ),
                                          label: Text(
                                            "Old Password".tr,
                                            style:
                                                Get.theme.textTheme.bodyMedium,
                                          )),
                                      validator: (value) {
                                        if (value!.length < 8) {
                                          return "password must be longer than 8 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: newPass,
                                      decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.password_outlined,
                                            color: AppColors.icons,
                                            size: 25,
                                          ),
                                          label: Text(
                                            "New Password".tr,
                                            style:
                                                Get.theme.textTheme.bodyMedium,
                                          )),
                                      validator: (value) {
                                        if (value!.length < 8) {
                                          return "password must be longer than 8 characters";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      height: 33,
                                    ),
                                    SizedBox(
                                      width: 250,
                                      height: 58,
                                      child: TextButton(
                                        onPressed: () {
                                          controller.changePassword(
                                              oldPass.text, newPass.text);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            "save".tr,
                                            style:
                                                Get.theme.textTheme.bodyText2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }

                return const Center(child: CircularProgressIndicator());
              })),
    );
  }
}
