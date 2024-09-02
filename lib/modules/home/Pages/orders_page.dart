import 'package:almajal_pharma/global/controllers/cart_controller.dart';
import 'package:almajal_pharma/global/models/cart_item.dart';
import 'package:almajal_pharma/global/models/order.dart';
import 'package:almajal_pharma/global/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../global/utils/colors.dart';
import '../../../global/widgets/item_no_widget.dart';

class OrdersPage extends GetView<CartController> {
  OrdersPage({super.key});

  @override
  // TODO: implement controller
  CartController get controller => Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        FutureBuilder(
          future: controller.getOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GetBuilder(
                init: controller,
                builder: (controller) {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: snapshot.data!
                            .map((e) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: Get.size.width,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Reference Number : ${e.referenceNumbers}"),
                                            Text(
                                                "Created At : ${e.createdAt} "),
                                            Text("Total : ${e.price} JOD"),
                                            Text(
                                                "Discount Type : ${e.discountType} "),
                                            Center(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Get.to(() =>
                                                        OrderItems(items: e));
                                                  },
                                                  child: Text(
                                                    "Show Details",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            )
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
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ]),
    );
  }
}

class OrderItems extends StatelessWidget {
  OrderItems({super.key, required this.items});
  Order items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Order Details",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Reference Number : ${items.referenceNumbers}"),
          Text("Created At : ${items.createdAt} "),
          Text("Total : ${items.price} JOD"),
          Text("Discount Type : ${items.discountType} "),
          Text("Order Items : "),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: items.products!
                    .map((e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: Get.size.width,
                            child: Card(
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: Get.size.width / 3,
                                    width: Get.size.width / 3,
                                    child: Image.network(
                                      "${AppConfig.baseUrl}/storage/${e.product!.image}",
                                      errorBuilder:
                                          (context, error, stackTrace) {
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
                                        Text("${e.product!.price!} JOD"),
                                        Text("${e.discountType} JOD"),
                                        ItemNumberButton(
                                          quantitiy: int.parse(e.quantity!),
                                          onAdd: () {},
                                          onMinus: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
