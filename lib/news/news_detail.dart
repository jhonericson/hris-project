import 'package:flutter/material.dart';
import 'package:hris_skripsi/constant/data_const.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key, required this.news});
  final NewsMenu news;

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
                news.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: kfBlack16Medium,
                  ),
                  ksVertical10,
                  Text(
                    news.desc,
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
