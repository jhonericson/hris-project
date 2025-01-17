import 'package:flutter/material.dart';
// import 'package:hris_skripsi/activity/activity.dart';
import 'package:hris_skripsi/attendance/attendance_list_page.dart';
import 'package:hris_skripsi/attendance/attendance_request_page.dart';
import 'package:hris_skripsi/constant/asset_const.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';

import 'package:hris_skripsi/widgets/shadow.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../constant/data_const.dart';
import '../widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  void requestPermission() async {
    await [
      Permission.location,
      Permission.camera,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    Future<String?> getUsername() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('betterme');
    }

    String getEmailName(String email) {
      List<String> parts = email.split('@');
      String name = parts[0];
      List<String> nameParts = name.split('.');
      nameParts = nameParts
          .map((part) => part[0].toUpperCase() + part.substring(1))
          .toList();
      return nameParts.join(' ');
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.red,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       icon: const Icon(Icons.notifications_none),
      //       onPressed: () {},
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ksVertical30,
            ksVertical20,
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 31,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 29,
                      backgroundImage: NetworkImage(kimgProfile),
                    ),
                  ),
                  ksHorizontal20,
                  FutureBuilder<String?>(
                    future: getUsername(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          getEmailName("${snapshot.data}"),
                          style: kfBlack18Medium,
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  )
                ],
              ),
            ),
            // Container(
            //   height: size.height * 0.3,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage(kImgHomeBackground),
            //         fit: BoxFit.fill,
            //         opacity: 0.5),
            //   ),
            //   child: Center(
            //     child: Text(
            //       "Come on, change\nyour activities to\nbetter sports",
            //       style: kfBlack30Medium,
            //       softWrap: true,
            //       maxLines: 3,
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
            ksVertical20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ksVertical10,
                      Row(
                        children: [
                          Text(
                            "Total Kehadiran",
                            style: kfBlack16Medium,
                          ),
                        ],
                      ),
                      ksVertical10,
                      Text(
                        "20 Hari",
                        style: kfBlack16Regular,
                      ),
                      ksVertical10,
                      ButtonGradient(
                        height: 25,
                        borderRadius: BorderRadius.circular(10),
                        width: size.width * 0.3,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AttendanceRequestPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Hadir",
                          style: kfWhite14Medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ksVertical20,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ksVertical10,
                      Row(
                        children: [
                          Text(
                            "List Kehadiran & Approval",
                            style: kfBlack16Medium,
                          ),
                        ],
                      ),
                      ksVertical10,
                      ButtonGradient(
                        height: 25,
                        borderRadius: BorderRadius.circular(10),
                        width: size.width * 0.43,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AttendanceListPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Lihat Dokumen",
                          style: kfWhite14Medium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ksVertical20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ksVertical10,
                            Row(
                              children: [
                                Text(
                                  "Total Absen",
                                  style: kfBlack16Medium,
                                ),
                              ],
                            ),
                            ksVertical10,
                            Text(
                              "3 Hari",
                              style: kfBlack16Regular,
                            ),
                            ksVertical10,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ksVertical10,
                            Row(
                              children: [
                                Text(
                                  "Total Cuti",
                                  style: kfBlack16Medium,
                                ),
                              ],
                            ),
                            ksVertical10,
                            Text(
                              "5 Hari",
                              style: kfBlack16Regular,
                            ),
                            ksVertical10,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ksVertical10,
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Text(
            //     "Rekomendasi Olahragas",
            //     style: kfBlack16Bold,
            //   ),
            // ),
            // ListView.separated(
            //   physics: const ClampingScrollPhysics(),
            //   padding: const EdgeInsets.symmetric(vertical: 20),
            //   shrinkWrap: true,
            //   itemCount: homeMenus.length,
            //   separatorBuilder: (BuildContext context, int index) {
            //     return ksVertical15;
            //   },
            //   itemBuilder: (BuildContext context, int index) {
            //     final menu = homeMenus[index];
            //     return InkWell(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => ActivityPage(
            //               data: menu,
            //             ),
            //           ),
            //         );
            //       },
            //       child: PerfectShadow(
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(15),
            //           ),
            //           margin: const EdgeInsets.symmetric(
            //             horizontal: 20,
            //           ),
            //           padding: const EdgeInsets.all(15),
            //           child: Row(
            //             children: [
            //               ClipRRect(
            //                 borderRadius: BorderRadius.circular(7.5),
            //                 child: SizedBox(
            //                   height: size.width * 0.3,
            //                   width: size.width * 0.2,
            //                   child: Image.asset(
            //                     menu.image,
            //                     fit: BoxFit.cover,
            //                   ),
            //                 ),
            //               ),
            //               ksHorizontal20,
            //               Text(
            //                 menu.title,
            //                 style: kfBlack24Medium,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
