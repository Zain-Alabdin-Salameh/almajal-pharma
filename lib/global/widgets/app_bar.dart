import 'package:almajal_pharma/modules/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyAppBar extends AppBar {
  MyAppBar({super.key});

  @override
  List<Widget>? get actions => [
        IconButton(
            onPressed: () {
              Get.to(() => CartScreen());
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ))
      ];
  @override
  // TODO: implement elevation
  double? get elevation => 0;

  @override
  // TODO: implement title
  Widget? get title => Text(
        "Majal App",
        style: TextStyle(color: Colors.black),
      );

  @override
  // TODO: implement iconTheme
  IconThemeData? get iconTheme => IconThemeData(color: Colors.black);
}
