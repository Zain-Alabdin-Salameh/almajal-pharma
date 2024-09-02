import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/controllers/app.dart';
import '../../global/utils/colors.dart';
import '../../global/utils/padding.dart';
import '../../global/widgets/background.dart';
import '../../global/widgets/logo.dart';
import '../signup/signup_view.dart';
import 'controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  LoginScreen({super.key});
  @override
  // TODO: implement controller
  LoginController get controller => Get.put(LoginController());
  final AppController appcontroller = Get.find<AppController>();
  final LocalKey formKey = const ObjectKey("value");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          const Background(),
          GetBuilder(
            init: controller,
            builder: (controller) => SingleChildScrollView(
              child: Padding(
                padding: AppPading.defaultPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const Center(child: Logo()),
                    SizedBox(
                      height: 150,
                    ),
                    Text("Welcome Back!".tr,
                        style: Get.theme.textTheme.headlineMedium),
                    Padding(
                      padding: AppPading.defaultPadding,
                      child: Center(
                        child: Form(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                controller: controller.email,
                                keyboardType: TextInputType.text,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "username is not valid";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person,
                                        color: AppColors.icons, size: 25),
                                    // const Icon(
                                    //   Icons.person_outline,
                                    //   color: AppColors.primary,
                                    // ),
                                    label: Text(
                                      "email".tr,
                                      style: Get.theme.textTheme.bodyLarge,
                                    )),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              TextFormField(
                                controller: controller.password,
                                obscureText: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.length < 8) {
                                    return "Password Should be longer than 8 chars";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock,
                                        color: AppColors.icons, size: 25),
                                    label: Text(
                                      "password".tr,
                                      style: Get.theme.textTheme.bodyLarge,
                                    )),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              SizedBox(
                                width: 250,
                                height: 58,
                                child: TextButton(
                                  onPressed: () {
                                    controller.sendLoginReq();
                                  },
                                  child: Text(
                                    "Login".tr,
                                    style: Get.theme.textTheme.bodyMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  // Get.to(const ForgetPasswordScreen());
                                },
                                child: Text(
                                  "ForgetPassword".tr,
                                  style:
                                      const TextStyle(color: AppColors.primary),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
