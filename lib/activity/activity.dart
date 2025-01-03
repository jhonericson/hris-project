import 'package:flutter/material.dart';
import 'package:hris_skripsi/constant/asset_const.dart';
import 'package:hris_skripsi/constant/data_const.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';
import 'package:hris_skripsi/food/foods.dart';
import 'package:share_plus/share_plus.dart';
import '../widgets/button.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key, required this.data});
  final HomeMenu data;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title,
          style: kfBlack16Medium,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width,
              height: size.width * 0.7,
              child: Image.asset(
                data.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: size.width,
              child: Image.asset(
                kImgActivityDashboard,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Deskripsi",
                    style: kfBlack18Medium,
                  ),
                  ksVertical20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.amber,
                          child: Text("${data.descId}")),
                      ksHorizontal10,
                      SizedBox(
                        width: size.width * 0.75,
                        child: Text(
                          data.desc,
                          style: kfBlack14Regular,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  ksVertical10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.amber,
                          child: Text("${data.profitId}")),
                      ksHorizontal10,
                      SizedBox(
                        width: size.width * 0.75,
                        child: Text(
                          data.profit,
                          style: kfBlack14Regular,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          bottom: 10,
        ),
        color: Colors.white,
        height: kToolbarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ButtonGradient(
              width: size.width * 0.35,
              borderRadius: BorderRadius.circular(10),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FoodsPage()));
              },
              child: Text(
                "Nutrisi Info",
                style: kfWhite14Regular,
              ),
            ),
            ButtonGradient(
              width: size.width * 0.35,
              borderRadius: BorderRadius.circular(10),
              onPressed: () {
                sharePressed(data.link);
                // showModalBottomSheet(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return ShareBottomSheet(
                //       content: 'Your content goes here',
                //       link: data.link,
                //     );
                //   },
                // );
              },
              child: Text(
                "Share",
                style: kfWhite14Regular,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sharePressed(String message) {
    Share.share(message);

    /// optional subject that will be used when sharing to email
    // Share.share(message, subject: 'Become An Elite Flutter Developer');

    /// share a file
    // Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
    /// share multiple files
    // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
  }
}

class ShareBottomSheet extends StatelessWidget {
  final String content;
  final String link;

  const ShareBottomSheet({
    super.key,
    required this.content,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.share),
          title: Text(
            'Share on Social Media',
            style: kfBlack16Medium,
          ),
        ),
        ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                kIconLogo1,
                fit: BoxFit.fill,
              )),
          title: Text(
            'WhatsApp',
            style: kfBlack14Regular,
          ),
          onTap: () {
            // Add your Facebook share logic here
          },
        ),
        ksVertical10,
        ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                kIconLogo2,
                fit: BoxFit.fill,
              )),
          title: Text(
            'Telegram',
            style: kfBlack14Regular,
          ),
          onTap: () {
            // Add your Facebook share logic here
          },
        ),
        ksVertical10,
        ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: Image.asset(
                kIconLogo3,
                fit: BoxFit.fill,
              )),
          title: Text(
            'Facebook',
            style: kfBlack14Regular,
          ),
          onTap: () {
            // Add your Facebook share logic here
            // _shareOnSocialMedia(
            //   platform: 'Facebook',
            //   context: context,
            //   link: link,
            // );
          },
        ),
        ksVertical30,
        // Add more social media options as needed
      ],
    );
  }

  void sharePressed(String message) {
    Share.share(message);

    /// optional subject that will be used when sharing to email
    // Share.share(message, subject: 'Become An Elite Flutter Developer');

    /// share a file
    // Share.shareFiles(['${directory.path}/image.jpg'], text: 'Great picture');
    /// share multiple files
    // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
  }
}
