import 'package:almajal_pharma/global/models/cart_item.dart';
import 'package:almajal_pharma/global/models/product.dart';

class Order {
  String? referenceNumbers;
  String? userId;
  List<CartItem>? products;
  String? userFullName;
  String? discountType;
  String? price;
  String? createdAt;

  Order(
      {this.referenceNumbers,
      this.userId,
      this.products,
      this.userFullName,
      this.discountType,
      this.price,
      this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    referenceNumbers = json['reference_numbers'];
    userId = json['user_id'];
    if (json['products'] != null) {
      products = <CartItem>[];
      json['products'].forEach((v) {
        products!.add(new CartItem.fromJson(v));
      });
    }
    print(products![0]);
    userFullName = json['user_full_name'];
    discountType = json['discount_type'];
    price = json['price'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference_numbers'] = this.referenceNumbers;
    data['user_id'] = this.userId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['user_full_name'] = this.userFullName;
    data['discount_type'] = this.discountType;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    return data;
  }
}
