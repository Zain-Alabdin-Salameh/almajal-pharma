import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemNumberButton extends StatelessWidget {
  ItemNumberButton(
      {this.quantitiy = 0, required this.onAdd, required this.onMinus});
  int quantitiy;
  VoidCallback onAdd;
  VoidCallback onMinus;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // width: 111.86,
          height: 31.29,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  onMinus();
                },
                child: Opacity(
                  opacity: 0.40,
                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.26),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "-",
                      style: Get.theme.textTheme.headlineSmall,
                    )),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: Center(
                  child: Text(
                    '$quantitiy',
                    style: TextStyle(
                      color: Color(0xFF232323),
                      fontSize: 18.77,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.94,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  onAdd();
                },
                child: Opacity(
                  opacity: 0.40,
                  child: Container(
                    width: 33,
                    height: 33,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.26),
                      ),
                    ),
                    child: Center(
                        child: Text("+",
                            style: Get.theme.textTheme.headlineSmall)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
