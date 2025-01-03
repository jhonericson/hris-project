import 'package:flutter/material.dart';
import 'package:hris_skripsi/constant/data_const.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';
import 'package:hris_skripsi/widgets/shadow.dart';

class FoodsPage extends StatefulWidget {
  const FoodsPage({super.key});

  @override
  State<FoodsPage> createState() => _FoodsPageState();
}

class _FoodsPageState extends State<FoodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1 / 1.45,
        ),
        itemCount: foodMenus.length,
        itemBuilder: (BuildContext context, int index) {
          final food = foodMenus[index];
          return PerfectShadow(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                      height: 150,
                      child: Image.asset(
                        food.image,
                        fit: BoxFit.cover,
                      )),
                  ksVertical10,
                  Text(food.name),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          food.favorite = !food.favorite;
                        });
                      },
                      icon: Icon(
                        food.favorite ? Icons.favorite : Icons.favorite_border,
                        color: food.favorite ? Colors.red : Colors.grey,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
