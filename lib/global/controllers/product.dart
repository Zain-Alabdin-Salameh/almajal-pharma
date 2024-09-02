import 'dart:io';

import 'package:almajal_pharma/global/controllers/auth.dart';
import 'package:almajal_pharma/global/models/distributer.dart';
import 'package:almajal_pharma/global/models/product.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../endpoints/api.dart';
import '../exceptions/app_exceptions.dart';

class ProductController extends GetxController {
  AuthController auth = Get.find();
  List<Product>? homeProducts;
  bool showCatFilter = false;
  int page = 1;
  bool isLoading = false;
  ProductController() {
    getHomeProducts();
  }
  Future<void> getHomeProducts() async {
    homeProducts = await getProducts();
    update();
  }

  Future<void> getHomeProductsNext() async {
    page = page + 1;
    List<Product> products = await getProducts();
    homeProducts!.addAll(products);
    isLoading = false;
    update();
  }

  Future<List<Product>> getProducts() async {
    try {
      var data = await httpCall.get("${ApiendPoints.products}?page=$page",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);
        List<Product> products = [];
        products = (data.data["data"]["data"] as List)
            .map((e) => Product.fromJson(e))
            .toList();

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

  Future<List<Product>> getProductsByDist(int id) async {
    try {
      var data = await httpCall.get("${ApiendPoints.prodictsByDist}$id",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);
        List<Product> products = [];
        products = (data.data["data"]["data"] as List)
            .map((e) => Product.fromJson(e))
            .toList();
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

  Future<List<Product>> getProductsByCat(int id) async {
    try {
      var data = await httpCall.get("${ApiendPoints.prodictsByCat}$id",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);
        List<Product> products = [];
        products = (data.data["data"]["data"] as List)
            .map((e) => Product.fromJson(e))
            .toList();
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

  Future<List<Product>> filterProducts(String id) async {
    try {
      var data = await httpCall.get("${ApiendPoints.filter}?name=$id",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);
        List<Product> products = [];
        products = (data.data["data"] as List)
            .map((e) => Product.fromJson(e))
            .toList();
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

  Future<List<Distribter>> getDistibuters() async {
    try {
      var data = await httpCall.get(ApiendPoints.distributers,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);
        List<Distribter> products = [];
        products = (data.data["data"] as List)
            .map((e) => Distribter.fromJson(e))
            .toList();
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

  Future<List<Category>> getCategories() async {
    try {
      var data = await httpCall.get(ApiendPoints.categories,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);
        List<Category> products = [];
        products = (data.data["data"] as List)
            .map((e) => Category.fromJson(e))
            .toList();
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

  Future<List> getSliders() async {
    try {
      var data = await httpCall.get("${ApiendPoints.sliders}",
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer ${auth.token}",
            HttpHeaders.acceptHeader: '*/*'
          }));
      print(data.statusCode);
      if (data.statusCode == 200) {
        print(data.data);

        return data.data["data"];
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
