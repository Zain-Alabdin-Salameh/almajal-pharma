import 'package:almajal_pharma/global/models/product.dart';

class CartItem {
  int? id;
  Product? product;
  String? quantity;
  String? price;
  String? totalPrice;
  String? discountType;

  CartItem(
      {this.id,
      this.product,
      this.quantity,
      this.price,
      this.totalPrice,
      this.discountType});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    price = json['price'];
    totalPrice = json['total_price'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['discount_type'] = this.discountType;
    return data;
  }
}

class CartTotal {
  int? subTotal;
  double? total;

  CartTotal({this.subTotal, this.total});

  CartTotal.fromJson(Map<String, dynamic> json) {
    subTotal = json['subTotal'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subTotal'] = this.subTotal;
    data['Total'] = this.total;
    return data;
  }
}

class Cart {
  List<CartItem>? items;
  CartTotal? total;

  Cart({this.items, this.total});
}
