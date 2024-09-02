// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../modules/home/home_screen.dart';
import '../../modules/login/login_view.dart';
import '../../modules/start/start_screen.dart';
import '../models/Auth/login/login_request.dart';
import '../models/Auth/login/login_response.dart';
import '../models/Auth/register/register_request.dart';
import '../models/User/user.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  Box? tokenBox;
  User? user;
  String? token;
  AuthService service = AuthService();

  AuthController() {
    init();
  }

  Future<void> init() async {
    tokenBox = await Hive.openBox("token");
    token = tokenBox!.get('token');
    if (token != null) {
      await refreshToken();
      await getUser();
      // Get.offAll(HomeScreen());
    }
    update();
  }

  Future<void> refreshToken() async {
    // token = await service.refresh(token!);
    print(tokenBox!.get("email"));
    print(tokenBox!.get("password"));
    await login(LoginReq(
        email: tokenBox!.get("email"), password: tokenBox!.get("password")));
    update();
    return;
  }

  Future<void> login(LoginReq req) async {
    LoginResponse response = await service.login(req);
    if (response.message != null) {
      print(response.message);
      Get.back();
      Get.snackbar("Error", response.message!);
      update();
    } else {
      user = response.user;
      token = response.token;
      tokenBox!.put("token", token);
      tokenBox!.put("email", req.email);
      tokenBox!.put("password", req.password);
      print(token);
      update();
      Get.offAll(HomeScreen());
    }
  }

  Future<void> register(SignUpRequest req) async {
    LoginResponse response = await service.register(req);
    if (response.message != null) {
      if (response.status == 200) {
        Get.snackbar("Success",
            "Confirmation emaile sent to the admin please wait tp be confirmed to log in");
        Get.offAll(LoginScreen());
      }
      Get.snackbar("", response.message!);
    } else {
      user = response.user;
      token = response.token;
      tokenBox!.put("token", token);
      print(token);
      update();
      Get.to(HomeScreen());
    }
  }

  Future<void> updateProfile(SignUpRequest req) async {
    LoginResponse response = await service.updateProfile(req, token!);
    if (response.message != null) {
      if (response.status == 200) {
        Get.snackbar("Success", "");
        // Get.offAll(HomeScreen());
      }
      Get.snackbar("", response.message!);

      await getUser();
    } else {
      // user = response.user;
      // token = response.token;
      // tokenBox!.put("token", token);
      // print(token);
      update();
    }
    Get.offAll(HomeScreen());
    return;
  }

  Future<void> changePassword(String pass1, String pass2) async {
    LoginResponse response = await service.updatePassword(pass1, pass2, token!);
    if (response.message != null) {
      if (response.status == 200) {
        Get.snackbar("Success", "");
        // Get.offAll(HomeScreen());
      }
      Get.snackbar("", response.message!);
      await getUser();
      tokenBox!.put("password", pass2);
    } else {
      // user = response.user;
      // token = response.token;
      // tokenBox!.put("token", token);
      // print(token);
      update();
    }
    Get.offAll(HomeScreen());
    return;
  }

  Future<void> logOut() async {
    user = User.empty();
    token = null;
    tokenBox!.clear();
    print(token);
    update();
    Get.to(() => StartScreen());
    Get.snackbar("Success", "Logged out successfully");
    return;
  }

  Future<User> getUser() async {
    if (token == null) {
      // Get.offAll(LoginScreen());
      return User.empty();
    }
    User response = await service.getUser(token!);
    // print(response.toString());
    user = response;
    update();
    return response;
  }
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
  }
}
