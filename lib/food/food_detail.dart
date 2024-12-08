import 'package:flutter/material.dart';
import 'package:healty_apps/constant/data_const.dart';
import 'package:healty_apps/constant/font_const.dart';
import 'package:healty_apps/constant/spacer_const.dart';

class FoodDetailPage extends StatelessWidget {
  const FoodDetailPage({super.key, required this.food});
  final FoodMenu food;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.25,
              width: size.width,
              child: Image.asset(
                food.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    food.name,
                    style: kfBlack16Medium,
                  ),
                  ksVertical10,
                  Text(
                    food.desc,
                    style: kfBlack14Regular,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
