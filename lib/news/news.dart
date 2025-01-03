import 'package:flutter/material.dart';
import 'package:hris_skripsi/news/news_detail.dart';
import '../../../../constant/data_const.dart';
import '../../../../constant/font_const.dart';
import '../../../../widgets/shadow.dart';
import '../constant/spacer_const.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Cuti",
            style: kfBlack16Medium,
          ),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 10),
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return ksVertical15;
          },
          itemCount: newsMenus.length,
          itemBuilder: (BuildContext context, int index) {
            final news = newsMenus[index];
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailPage(
                      news: news,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: SizedBox(
                          height: size.width * 0.2,
                          width: size.width * 0.3,
                          child: Image.asset(
                            news.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      ksHorizontal20,
                      SizedBox(
                        width: size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: kfBlack14Medium,
                            ),
                            SizedBox(
                              height: size.height * 0.065,
                              child: Text(
                                news.desc,
                                style: kfBlack12Regular,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
