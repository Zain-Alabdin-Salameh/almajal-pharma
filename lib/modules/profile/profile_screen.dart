import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../global/utils/colors.dart';
import '../../global/utils/padding.dart';
import '../../global/widgets/background.dart';
import '../../global/widgets/logo.dart';
import '../signup/controllers/register_controller.dart';

class ProfileScreen extends GetView {
  ProfileScreen({super.key});
  @override
  final RegisterController controller = Get.put(RegisterController());

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
                controller.auth.getUser();
                if (controller.initialized && controller.auth.user != null) {
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    controller: controller.name,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: AppColors.icons,
                                          size: 25,
                                        ),
                                        label: Text(
                                          "username".tr,
                                          style: Get.theme.textTheme.bodyMedium,
                                        )),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "username is not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: controller.email,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.email,
                                          color: AppColors.icons,
                                          size: 25,
                                        ),
                                        label: Text(
                                          "email".tr,
                                          style: Get.theme.textTheme.bodyMedium,
                                        )),
                                    validator: (value) {
                                      if (!GetUtils.isEmail(value!)) {
                                        return "email is not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: controller.phone,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: AppColors.icons,
                                          size: 25,
                                        ),
                                        label: Text(
                                          "phone".tr,
                                          style: Get.theme.textTheme.bodyMedium,
                                        )),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "phone is not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: controller.address,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.location_city,
                                          color: AppColors.icons,
                                          size: 25,
                                        ),
                                        label: Text(
                                          "address".tr,
                                          style: Get.theme.textTheme.bodyMedium,
                                        )),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "address is not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: controller.pharmacy,
                                    decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          Icons.person,
                                          color: AppColors.icons,
                                          size: 25,
                                        ),
                                        label: Text(
                                          "parmacy".tr,
                                          style: Get.theme.textTheme.bodyMedium,
                                        )),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "pharmacy is not valid";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // ClayContainer(
                                  //   borderRadius: 33,
                                  //   child: TextFormField(
                                  //     controller: controller.password,
                                  //     // obscureText: true,
                                  //     decoration: InputDecoration(
                                  //         prefixIcon: const Icon(Icons.lock,
                                  //             color: AppColors.primary,
                                  //             size: 30),
                                  //         label: Text(
                                  //           "password".tr,
                                  //           style:
                                  //               Get.theme.textTheme.bodyText1,
                                  //         )),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 33,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    height: 58,
                                    child: TextButton(
                                      onPressed: () {
                                        controller.updateProfileReq();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "save".tr,
                                          style: Get.theme.textTheme.bodyText2,
                                        ),
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
                  );
                }

                return const Center(child: CircularProgressIndicator());
              })),
    );
  }
}
