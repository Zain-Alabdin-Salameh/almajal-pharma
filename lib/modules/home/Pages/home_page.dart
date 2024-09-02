import 'package:almajal_pharma/global/utils/config.dart';
import 'package:almajal_pharma/modules/home/Pages/products_by_cat.dart';
import 'package:almajal_pharma/modules/product_details/product_details.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/controllers/product.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.controller});

  final ProductController controller;
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if (!controller.isLoading) {
          controller.isLoading = !controller.isLoading;
          controller.update();
          controller.getHomeProductsNext();
          // Perform event when user reach at the end of list (e.g. do Api call)
        }
      }
    });
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // width: 346.93,
                  height: 57.99,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showSearch(
                              context: context,
                              delegate: CustomSearchDelegate(),
                            );
                          },
                          child: Container(
                            // width: 346.93,
                            height: 57.99,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF7F7F7),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.43),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Search here',
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 12.43,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.showCatFilter = !controller.showCatFilter;
                          controller.update();
                        },
                        child: Container(
                          width: 59.03,
                          height: 57.99,
                          decoration: ShapeDecoration(
                            color: Color(0xFF303030),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.43),
                            ),
                          ),
                          child: Center(
                              child: Icon(
                            Icons.filter_alt_outlined,
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (controller.showCatFilter)
                FutureBuilder(
                  future: controller.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          height: 70,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => ProductsByCat(
                                        catId: snapshot.data![index].id!));
                                  },
                                  child: ClayContainer(
                                    borderRadius: 15,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          snapshot.data![index].name.toString(),
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ));
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              FutureBuilder(
                future: controller.getSliders(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                        height: 140,
                        child: Swiper(
                          itemCount: snapshot.data!.length,
                          autoplay: true,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Image(
                                image: NetworkImage(
                                    snapshot.data![index]["image"]),
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ));
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              controller.homeProducts != null
                  ? Column(
                      children: [
                        GridView.builder(
                          itemCount: controller.homeProducts!.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 0.6, crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => ProductDetailsScreen(
                                      product:
                                          controller.homeProducts![index]));
                                },
                                child: ClayContainer(
                                  borderRadius: 17,
                                  child: Column(
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: EdgeInsets.all(3),
                                            child: controller
                                                        .homeProducts![index]
                                                        .image !=
                                                    null
                                                ? Image.network(
                                                    "${AppConfig.baseUrl}/storage/${controller.homeProducts![index].image!}",
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          "assets/imgs/noImage.png");
                                                    },
                                                  )
                                                : Image.asset(
                                                    "assets/imgs/noImage.png"),
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Column(
                                            children: [
                                              Text(controller
                                                  .homeProducts![index].name!),
                                              Text(
                                                  "${controller.homeProducts![index].price!} JOD"),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        if (controller.isLoading) CircularProgressIndicator()
                      ],
                    )
                  : const Center(child: CircularProgressIndicator())
            ]),
          ),
        );
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  ProductController controller = Get.find();
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
        width: Get.size.width,
        child: FutureBuilder(
          future: controller.filterProducts(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.6, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ProductDetailsScreen(
                            product: snapshot.data![index]));
                      },
                      child: ClayContainer(
                        borderRadius: 17,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: snapshot.data![index].image != null
                                      ? Image.network(
                                          "${AppConfig.baseUrl}/storage/${snapshot.data![index].image!}",
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                "assets/imgs/noImage.png");
                                          },
                                        )
                                      : Image.asset("assets/imgs/noImage.png"),
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(snapshot.data![index].name!),
                                    Text("${snapshot.data![index].price!} JOD"),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return SizedBox(
        width: Get.size.width,
        child: FutureBuilder(
          future: controller.filterProducts(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.6, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => ProductDetailsScreen(
                            product: snapshot.data![index]));
                      },
                      child: ClayContainer(
                        borderRadius: 17,
                        child: Column(
                          children: [
                            Expanded(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: snapshot.data![index].image != null
                                      ? Image.network(
                                          "${AppConfig.baseUrl}/storage/${snapshot.data![index].image!}",
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                "assets/imgs/noImage.png");
                                          },
                                        )
                                      : Image.asset("assets/imgs/noImage.png"),
                                )),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(snapshot.data![index].name!),
                                    Text("${snapshot.data![index].price!} JOD"),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
