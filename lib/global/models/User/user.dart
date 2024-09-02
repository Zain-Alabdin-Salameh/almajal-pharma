// class User {
//   final int id;

//   var roleId;
//   final String name;
//   final String phone;
//   final String email;
//   // final String birthday;
//   // final String status;
//   User({
//     required this.id,
//     required this.name,
//     required this.roleId,
//     required this.phone,
//     required this.email,
//     // required this.birthday,
//   });
//   factory User.fromJson(Map<String, dynamic> data) {
//     return User(
//       id: data["id"],
//       name: data["full_name"],
//       roleId: data["role_id"],
//       phone: data["phone"].toString(),
//       email: data["email"],
//       // birthday: data["birthday"].toString(),
//     );
//   }
//   factory User.empty() {
//     return User(id: -1, name: "", phone: "", email: "", roleId: -1);
//   }
// }
class User {
  int? id;
  String? roleId;
  String? roleName;
  String? name;
  String? pharmacyName;
  String? phoneNumber;
  String? address;
  String? email;

  User(
      {this.id,
      this.roleId,
      this.roleName,
      this.name,
      this.pharmacyName,
      this.phoneNumber,
      this.address,
      this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    name = json['full_name'];
    pharmacyName = json['pharmacy_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['full_name'] = this.name;
    data['pharmacy_name'] = this.pharmacyName;
    data['phone_number'] = this.phoneNumber;
    data['address'] = this.address;
    data['email'] = this.email;
    return data;
  }

  factory User.empty() {
    return User(id: -1, name: "", email: "");
  }
}
