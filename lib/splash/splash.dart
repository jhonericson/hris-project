import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/login/login.dart';
import '../constant/asset_const.dart';
import '../home/navigation.dart';
import '../login/controller/login_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavigation()));
          });
        } else if (state is LoginFailure) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          });
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
