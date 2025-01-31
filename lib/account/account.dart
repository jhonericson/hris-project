import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';
import 'package:hris_skripsi/login/login.dart';
import 'package:hris_skripsi/widgets/shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/asset_const.dart';
import '../login/controller/login_bloc.dart';
import '../widgets/button.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Akun",
          style: kfBlack16Medium,
        ),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  return Text(
                    "Hai, ${state.loginModel.result?.name ?? ""}",
                    style: kfBlack18Medium,
                  );
                } else {
                  return Text(
                    "Hai, ........",
                    style: kfBlack18Medium,
                  );
                }
              },
            ),
            const AccountButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class AccountButtonWidget extends StatelessWidget {
  const AccountButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> deleteUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("betterme");
    }

    return Column(
      children: [
        const AccountButton(
          label: "Tentang Aplikasi",
        ),
        const AccountButton(
          label: "Hubungi Kami",
        ),
        const AccountButton(
          label: "Syarat dan ketentuan",
        ),
        const AccountButton(
          label: "Kebijakan Perivasi",
        ),
        const AccountButton(
          label: "Panduan Pengguna",
        ),
        AccountButton(
          label: "Generate Gaji",
          onTap: () {
            showOkAlertDialog(
              context: context,
              title: "Generate Gaji",
              message: "Slip gaji belum tersedia",
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: ButtonGradient(
            height: kToolbarHeight,
            borderRadius: BorderRadius.circular(10),
            width: double.infinity,
            onPressed: () {
              showOkCancelAlertDialog(
                      context: context,
                      title: "Konfirmasi",
                      message: "Anda Yakin Ingin Keluar ?")
                  .then((value) {
                if (value.name == "ok") {
                  context.read<LoginBloc>().add(const Logout());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }
                return false;
              });
            },
            child: Text(
              "Logout",
              style: kfWhite14Medium,
            ),
          ),
        ),
      ],
    );
  }
}

class AccountButton extends StatelessWidget {
  const AccountButton({
    super.key,
    required this.label,
    this.onTap,
  });
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: kfBlack14Medium,
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black45,
                  size: 20,
                )
              ],
            ),
          ),
          ksVertical10,
          const Divider(),
          ksVertical10,
        ],
      ),
    );
  }
}

class AccountDataCard extends StatelessWidget {
  const AccountDataCard({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    return PerfectShadow(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(kimgProfile),
            ),
            ksHorizontal20,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getEmailName(email),
                  style: kfBlack16Medium,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.mail, size: 10),
                    ksHorizontal5,
                    Text(
                      email,
                      style: kfBlack12Regular,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.phone, size: 10),
                    ksHorizontal5,
                    Text(
                      "082288997788",
                      style: kfBlack12Regular,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
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
