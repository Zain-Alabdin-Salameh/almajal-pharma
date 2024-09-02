import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/utils/colors.dart';
import '../login/login_view.dart';
import '../signup/signup_view.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Positioned.fill(
          //   child: SizedBox(
          //     // width: Get.size.width,
          //     child: Image.asset(
          //       "assets/imgs/back.png",
          //       fit: BoxFit.fitWidth,
          //       width: Get.size.width,
          //     ),
          //   ),
          // ),
          Positioned.fill(
            // width: Get.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Welcome to",
                  style: TextStyle(fontSize: 24),
                ),
                const Text(
                  "AL Majal Pharma",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(LoginScreen());
                  },
                  child: ClayContainer(
                    width: 300,
                    height: 60,
                    borderRadius: 10,
                    surfaceColor: AppColors.primary,
                    child: const Center(
                        child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(SignUpScreen());
                  },
                  child: ClayContainer(
                    width: 300,
                    height: 60,
                    depth: 3,
                    borderRadius: 10,
                    surfaceColor: AppColors.primary,
                    child: const Center(
                        child: Text(
                      "Create new account",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
