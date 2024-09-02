import 'package:almajal_pharma/modules/home/Pages/products_by_dist.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/controllers/product.dart';
import '../../../global/utils/config.dart';

class DistributersPage extends StatelessWidget {
  DistributersPage({super.key, required this.controller});

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  SizedBox(
                    width: 10,
                  ),
                  Container(
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
                      Icons.search,
                      color: Colors.white,
                    )),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //     height: 140,
          //     child: Swiper(
          //       itemCount: 3,
          //       autoplay: true,
          //       itemBuilder: (context, index) {
          //         return Card();
          //       },
          //     )),
          FutureBuilder(
            future: controller.getDistibuters(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.9, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ProductsByDist(
                              distId: snapshot.data![index].id ?? 0));
                        },
                        child: ClayContainer(
                          borderRadius: 17,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.all(3),
                                    child: snapshot.data![index].image != null
                                        ? Image.network(
                                            "${snapshot.data![index].image!}",
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                  "assets/imgs/noImage.png");
                                            },
                                          )
                                        : Image.asset(
                                            "assets/imgs/noImage.png"),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(snapshot.data![index].name!),
                                      // Text("${snapshot.data![index].price!} JOD"),
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
          )
        ]),
      ),
    );
  }
}
