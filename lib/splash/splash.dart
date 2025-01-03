import 'package:flutter/material.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/asset_const.dart';
import '../home/navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    generateRoute();
    super.initState();
  }

  Future<void> generateRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('betterme');
    if (token != null && token.isNotEmpty) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BottomNavigation()));
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kImgsplashBackground),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            "HRIS SKRIPSI",
            style: kfBlack40Bold,
          ),
        ),
      ),
    );
  }
}
