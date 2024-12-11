import 'package:flutter/material.dart';
import 'package:healty_apps/activity/activity.dart';
import 'package:healty_apps/constant/asset_const.dart';
import 'package:healty_apps/constant/font_const.dart';
import 'package:healty_apps/constant/spacer_const.dart';
import 'package:healty_apps/food/food_detail.dart';
import 'package:healty_apps/widgets/shadow.dart';
import '../constant/data_const.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(kImgHomeBackground),
                    fit: BoxFit.fill,
                    opacity: 0.5),
              ),
              child: Center(
                child: Text(
                  "Come on, change\nyour activities to\nbetter sports ddd",
                  style: kfBlack30Medium,
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ksVertical10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Rekomendasi Makanan Sehat",
                style: kfBlack16Bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.2,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  shrinkWrap: true,
                  itemCount: foodMenus.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return ksHorizontal5;
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final food = foodMenus[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FoodDetailPage(food: food)));
                      },
                      child: PerfectShadow(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7.5),
                                child: SizedBox(
                                  height: size.width * 0.2,
                                  width: size.width * 0.2,
                                  child: Image.asset(
                                    food.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              ksVertical10,
                              Text(
                                food.name,
                                style: kfBlack16Medium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            ksVertical10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Rekomendasi Olahragas",
                style: kfBlack16Bold,
              ),
            ),
            ListView.separated(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shrinkWrap: true,
              itemCount: homeMenus.length,
              separatorBuilder: (BuildContext context, int index) {
                return ksVertical15;
              },
              itemBuilder: (BuildContext context, int index) {
                final menu = homeMenus[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ActivityPage(
                          data: menu,
                        ),
                      ),
                    );
                  },
                  child: PerfectShadow(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(7.5),
                            child: SizedBox(
                              height: size.width * 0.3,
                              width: size.width * 0.2,
                              child: Image.asset(
                                menu.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          ksHorizontal20,
                          Text(
                            menu.title,
                            style: kfBlack24Medium,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
