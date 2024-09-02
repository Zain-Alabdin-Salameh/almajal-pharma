// ignore_for_file: non_constant_identifier_names

class SignUpRequest {
  final String name;
  final String email;
  final String password;
  final String pharmacy;
  final String phone;
  final String? address;

  SignUpRequest(
      {required this.name,
      required this.email,
      required this.password,
      required this.pharmacy,
      required this.phone,
      this.address});
  Map<String, dynamic> toJson() {
    return {
      "full_name": name,
      "email": email,
      "password": password,
      "username": name,
      "pharmacy_name": pharmacy,
      "phone_number": phone,
      "address": address
    };
  }
}
