import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/controllers/auth.dart';
import '../../../global/models/Auth/register/register_request.dart';

class RegisterController extends GetxController {
  AuthController auth = Get.find<AuthController>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController pharmacy = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  @override
  void onInit() {
    if (auth.user != null) {
      name.text = auth.user!.name!;
      email.text = auth.user!.email!;
      pharmacy.text = auth.user!.pharmacyName!;
      phone.text = auth.user!.phoneNumber!;
      address.text = auth.user!.address!;
    }

    super.onInit();
  }

  void sendLoginReq() async {
    if (GetUtils.isEmail(email.text) && password.text.length >= 8) {
      Future.delayed(Duration.zero, () {
        Get.bottomSheet(WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const Column(
            children: [Text("Please Wait"), CircularProgressIndicator()],
          ),
        ));
      });
      SignUpRequest req = SignUpRequest(
          email: email.text,
          password: password.text,
          name: name.text,
          pharmacy: pharmacy.text,
          phone: phone.text,
          address: address.text);

      await auth.register(req);
      Get.back();
    }
  }

  void updateProfileReq() async {
    if (GetUtils.isEmail(email.text)) {
      Future.delayed(Duration.zero, () {
        Get.bottomSheet(WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: const Column(
            children: [Text("Please Wait"), CircularProgressIndicator()],
          ),
        ));
      });
      SignUpRequest req = SignUpRequest(
          email: email.text,
          password: "",
          name: name.text,
          pharmacy: pharmacy.text,
          phone: phone.text,
          address: address.text);

      await auth.updateProfile(req);
      Get.back();
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    name.dispose();
    phone.dispose();
    pharmacy.dispose();
    address.dispose();
    super.dispose();
    // auth.dispose();
  }
}
