class Product {
  int? id;
  String? categoryId;
  String? categoryName;
  String? dealerId;
  String? dealerName;
  String? name;
  String? description;
  String? price;
  String? newPrice;
  var bonus;
  var bonusValue;
  String? expiredDate;
  String? tax;
  String? image;

  Product(
      {this.id,
      this.categoryId,
      this.categoryName,
      this.dealerId,
      this.dealerName,
      this.name,
      this.description,
      this.price,
      this.newPrice,
      this.bonus,
      this.bonusValue,
      this.expiredDate,
      this.tax,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    dealerId = json['dealer_id'];
    dealerName = json['dealer_name'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    newPrice = json['new_price'];
    bonus = json['bonus'];
    bonusValue = json['bonus_value'];
    expiredDate = json['expired_date'];
    tax = json['tax'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['dealer_id'] = this.dealerId;
    data['dealer_name'] = this.dealerName;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['new_price'] = this.newPrice;
    data['bonus'] = this.bonus;
    data['bonus_value'] = this.bonusValue;
    data['expired_date'] = this.expiredDate;
    data['tax'] = this.tax;
    data['image'] = this.image;
    return data;
  }
}
