import 'package:almajal_pharma/global/controllers/cart_controller.dart';
import 'package:almajal_pharma/global/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../global/utils/colors.dart';
import '../../global/widgets/item_no_widget.dart';

class CartScreen extends GetView<CartController> {
  CartScreen({super.key});

  @override
  // TODO: implement controller
  CartController get controller => Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(children: [
        TextButton(
            onPressed: () {
              controller.clear();
            },
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.redAccent),
            ),
            child: Text(
              "Clear Cart",
              style: TextStyle(color: Colors.white),
            )),
        FutureBuilder(
          future: controller.getCart(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GetBuilder(
                init: controller,
                builder: (controller) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: controller.cart
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: Get.size.width,
                                    child: Dismissible(
                                      onDismissed: (direction) {
                                        print("object");
                                        controller.removeFromCart(
                                            product: e.id!);
                                      },
                                      key: Key("${e.id}"),
                                      child: Card(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              height: Get.size.width / 3,
                                              width: Get.size.width / 3,
                                              child: Image.network(
                                                "${AppConfig.baseUrl}/storage/${e.product!.image}",
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                      "assets/imgs/noImage.png");
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("${e.product!.name!}"),
                                                  Text(
                                                      "${e.product!.price!} JOD"),
                                                  ItemNumberButton(
                                                    quantitiy:
                                                        int.parse(e.quantity!),
                                                    onAdd: () {
                                                      e.quantity = (int.parse(
                                                                  e.quantity!) +
                                                              1)
                                                          .toString();
                                                      controller.isEdited =
                                                          true;
                                                      controller.update();
                                                    },
                                                    onMinus: () {
                                                      if (int.parse(
                                                              e.quantity!) >
                                                          0) {
                                                        e.quantity = (int.parse(
                                                                    e.quantity!) -
                                                                1)
                                                            .toString();
                                                        controller.isEdited =
                                                            true;
                                                        controller.update();
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  );
                },
              );
            }
            return Expanded(
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        ),
        GetBuilder(
          init: controller,
          builder: (controller) {
            return Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "total : ${controller.total}, subTotal : ${controller.subtotal}")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    width: Get.width / 2,
                    child: controller.isEdited
                        ? TextButton(
                            onPressed: () async {
                              if (!controller.isLoading) {
                                controller.isLoading = true;
                                controller.update();
                                await controller.updateCart();
                                controller.isLoading = false;
                                controller.isEdited = false;
                                controller.update();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.secodary),
                            ),
                            child: (!controller.isLoading)
                                ? const Text(
                                    "Update Cart",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                          )
                        : TextButton(
                            onPressed: () {
                              controller.order();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.secodary),
                            ),
                            child: (!controller.isLoading)
                                ? const Text(
                                    "Submit Order",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  ),
                          ),
                  ),
                ),
              ],
            );
          },
        )
      ]),
    );
  }
}
