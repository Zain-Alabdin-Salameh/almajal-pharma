import 'package:almajal_pharma/global/controllers/cart_controller.dart';
import 'package:almajal_pharma/global/controllers/product.dart';
import 'package:almajal_pharma/global/utils/config.dart';
import 'package:almajal_pharma/modules/home/Pages/disributers_page.dart';
import 'package:almajal_pharma/modules/home/Pages/orders_page.dart';
import 'package:almajal_pharma/modules/settings/settings_screen.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/widgets/app_bar.dart';
import 'Pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController controller = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      HomePage(controller: controller),
      DistributersPage(controller: controller),
      OrdersPage(),
      SettingScreen()
    ];
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: pages[index],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (value) {
              setState(() {
                index = value;
              });
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.store), label: "distributers"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.checklist_outlined), label: "orders"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "profile"),
            ]),
      ),
    );
  }
}
