import 'dart:io';

import 'package:almajal_pharma/global/controllers/auth.dart';
import 'package:almajal_pharma/global/models/cart_item.dart';
import 'package:almajal_pharma/global/models/distributer.dart';
import 'package:almajal_pharma/global/models/order.dart';
import 'package:almajal_pharma/global/models/product.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../endpoints/api.dart';
import '../exceptions/app_exceptions.dart';

class CartController extends GetxController {
  AuthController auth = Get.find();
  List<CartItem> cart = [];
  bool isEdited = false;
  bool isLoading = false;
  var total, subtotal;
  Future<bool> addToCart(
      {int product = 0, int quantity = 0, String discountType = ""}) async {
    try {
      var data = await httpCall.post(ApiendPoints.addToCart,
          data: {
            "product_id": product,
            "quantity": quantity,
            "discount_type": discountType
          },
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        Get.snackbar("Success", "Added to Cart");
        return true;
      }
      return false;
    } on DioError catch (e) {
      print(e);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return true;
      }
      return false;
    }
  }

  Future<bool> removeFromCart({
    int product = 0,
  }) async {
    try {
      var data = await httpCall.post("${ApiendPoints.removeToCart}$product",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        getCart();
        Get.snackbar("Success", "Removed from Cart");
        return true;
      }
      return false;
    } on DioError catch (e) {
      print(e);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return true;
      }
      return false;
    }
  }

  Future<bool> order() async {
    try {
      isLoading = true;
      update();
      var data = await httpCall.post(ApiendPoints.order,
          data: {"discount_type": "bonus"},
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      isLoading = false;
      update();
      Get.back();
      if (data.statusCode == 200) {
        Get.snackbar("Success", "Order Submitted Successfully");
        return true;
      }
      return false;
    } on DioError catch (e) {
      isLoading = false;
      update();
      print(e);
      if (e.response != null) print(e.response!.data);
      Get.back();
      if (e.type == DioErrorType.other) {
        return true;
      }
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      isLoading = true;
      update();
      var data = await httpCall.post(ApiendPoints.clearCart,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      isLoading = false;
      update();
      Get.back();
      if (data.statusCode == 200) {
        getCart();
        Get.snackbar("Success", "Cart Cleared Successfully");
        return true;
      }
      return false;
    } on DioError catch (e) {
      isLoading = false;
      update();
      print(e);
      if (e.response != null) print(e.response!.data);
      Get.back();
      if (e.type == DioErrorType.other) {
        return true;
      }
      return false;
    }
  }

  Future<void> updateCart() async {
    try {
      isLoading = true;
      update();
      cart.forEach((element) async {
        var data = await httpCall.post(
            "${ApiendPoints.updateCart}${element.id}",
            data: {
              "quantity": element.quantity,
              "discount_type": element.discountType
            },
            options: Options(headers: {
              HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
              HttpHeaders.acceptHeader: '*/*'
            }));
        print(data.data);
        getCart();
        if (data.statusCode == 200) {
          Get.snackbar("Success", "Cart Updated");
        }
      });
      isLoading = false;
      update();
    } on DioError catch (e) {
      print(e);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {}
      Get.snackbar("Error", "Error updating Cart");
    }
  }

  Future<List<CartItem>> getCart() async {
    try {
      var data = await httpCall.get("${ApiendPoints.veiwCart}",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);
        List<CartItem> products = [];
        products = (data.data["data"][0] as List)
            .map((e) => CartItem.fromJson(e))
            .toList();
        cart = products;
        total = data.data["data"][1]["Total"];
        subtotal = data.data["data"][1]["subTotal"];
        update();
        return products;
      }
      return [];
    } on DioError catch (e) {
      cart = [];
      total = null;
      subtotal = null;
      print(e);
      update();
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return [];
      }
      return [];
    }
  }

  Future<List<Order>> getOrders() async {
    try {
      var data = await httpCall.get("${ApiendPoints.getorders}",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);
        List<Order> products = [];
        products =
            (data.data["data"] as List).map((e) => Order.fromJson(e)).toList();
        // cart = products;
        update();
        return products;
      }
      return [];
    } on DioError catch (e) {
      print(e);
      if (e.response != null) print(e.response!.data);
      if (e.type == DioErrorType.other) {
        return [];
      }
      return [];
    }
  }
}
