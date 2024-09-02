import 'package:almajal_pharma/global/controllers/cart_controller.dart';
import 'package:almajal_pharma/global/controllers/product.dart';
import 'package:almajal_pharma/global/models/product.dart';
import 'package:almajal_pharma/global/utils/colors.dart';
import 'package:almajal_pharma/global/utils/config.dart';
import 'package:almajal_pharma/global/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/widgets/item_no_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  ProductDetailsScreen({super.key, required this.product});
  final Product product;
  String? discountType = "price";
  int quantity = 0;
  bool isLoading = false;
  ProductController controller = Get.find();
  CartController cart = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: GetBuilder(
          init: controller,
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.size.width,
                      width: Get.size.width,
                      child: Image.network(
                        "${AppConfig.baseUrl}/storage/${product.image}",
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("assets/imgs/noImage.png");
                        },
                      ),
                    ),
                    Text(
                      "${product.name}",
                      style: Get.theme.textTheme.headlineSmall,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text("${product.price} JOD",
                              style:
                                  Get.theme.textTheme.headlineMedium!.copyWith(
                                color: AppColors.primary,
                              )),
                        ),
                        ItemNumberButton(
                          quantitiy: quantity,
                          onAdd: () {
                            quantity++;
                            controller.update();
                          },
                          onMinus: () {
                            if (quantity > 0) {
                              quantity--;
                              controller.update();
                            }
                          },
                        )
                      ],
                    ),
                    if (product.bonus != null)
                      Column(
                        children: [
                          Text(
                            "By ${product.bonus} and get ${product.bonusValue} or Get discounted Price ${product.newPrice} JOD",
                            style: Get.theme.textTheme.labelLarge,
                          ),
                          Row(
                            children: [
                              Text(
                                "I Want to Get : ",
                                style: Get.theme.textTheme.labelLarge,
                              ),
                              DropdownButton(
                                  value: discountType,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("bonus"),
                                      value: "bonus",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("discount"),
                                      value: "price",
                                    ),
                                  ],
                                  onChanged: (val) {
                                    discountType = val;
                                    controller.update();
                                  }),
                            ],
                          ),
                        ],
                      ),
                    Text(
                      "${product.description}",
                      style: Get.theme.textTheme.labelLarge,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 62.57,
                            height: 62.57,
                            padding: const EdgeInsets.all(18.77),
                            decoration: ShapeDecoration(
                              color: Color(0xFFF0F0F0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.34),
                              ),
                            ),
                            child: Center(
                              child: Icon(Icons.bookmark_outline),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: () async {
                              isLoading = true;
                              controller.update();
                              await cart.addToCart(
                                  product: product.id!,
                                  quantity: quantity,
                                  discountType: discountType!);
                              isLoading = false;
                              controller.update();
                            },
                            child: Container(
                              width: 260.72,
                              height: 62,
                              decoration: ShapeDecoration(
                                color: Color(0xFF232323),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.34),
                                ),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x3F303030),
                                    blurRadius: 20.86,
                                    offset: Offset(0, 10.43),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Center(
                                child: isLoading
                                    ? CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        "Add to cart",
                                        style: Get
                                            .theme.textTheme.headlineSmall!
                                            .copyWith(color: Colors.white),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
