import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hris_skripsi/constant/asset_const.dart';
import 'package:hris_skripsi/constant/font_const.dart';
import 'package:hris_skripsi/constant/spacer_const.dart';
import 'package:hris_skripsi/login/controller/login_bloc.dart';
import 'package:hris_skripsi/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  bool obsecure = true;
  bool check = false;
  void changeObsecure(bool newValue) {
    setState(() {
      obsecure = newValue;
    });
  }

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  Future<void> _saveUser({
    required String email,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("betterme", email);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: size.height * 0.3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(kImgLoginBackground),
                    fit: BoxFit.fill,
                    opacity: 0.5,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailC,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      keyboardType: TextInputType.emailAddress,

                      // onChanged: (value) {
                      //   if (value.isNotEmpty) {
                      //   } else if (emailValidatorRegExp.hasMatch(value)) {}
                      //   return;
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email Kosong";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        labelText: "Username",
                        hintText: "Input Username",
                        labelStyle:
                            kfBlack14Regular.copyWith(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ksVertical20,
                    TextFormField(
                      obscureText: obsecure,
                      controller: passwordC,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },

                      keyboardType: TextInputType.emailAddress,

                      // onChanged: (value) {
                      //   if (value.isNotEmpty) {
                      //   } else if (emailValidatorRegExp.hasMatch(value)) {}
                      //   return;
                      // },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password Kosong";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Colors.black,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        labelText: "Password",
                        hintText: "Input Password",
                        labelStyle:
                            kfBlack14Regular.copyWith(color: Colors.grey),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffix: InkWell(
                          onTap: () {
                            changeObsecure(!obsecure);
                          },
                          child: Icon(
                            obsecure ? Icons.visibility : Icons.visibility_off,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: check,
                                onChanged: (newValue) {
                                  setState(() {
                                    check = newValue!;
                                  });
                                }),
                            Text(
                              "Remember Me",
                              style: kfBlack12Medium,
                            )
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password",
                            style:
                                kfBlack12Medium.copyWith(color: Colors.purple),
                          ),
                        )
                      ],
                    ),
                    ksVertical20,
                    BlocListener<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginLoading) {
                          EasyLoading.show(
                            status: "Please Wait...",
                            dismissOnTap: true,
                          );
                        } else if (state is LoginSuccess) {
                          EasyLoading.showSuccess("success");
                          EasyLoading.dismiss();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigation()));
                        } else if (state is LoginFailure) {
                          EasyLoading.dismiss();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.white,
                              content: Text(
                                "Login Error\nPeriksa Kembali Email dan Password",
                                style: kfBlack14Regular,
                              ),
                            ),
                          );
                        }
                      },
                      child: ButtonGradient(
                        height: kToolbarHeight,
                        borderRadius: BorderRadius.circular(10),
                        width: double.infinity,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState!.save();

                            if (emailC.text.isEmpty || passwordC.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.white,
                                  content: Text(
                                    "Login Error",
                                    style: kfBlack14Regular,
                                  ),
                                ),
                              );
                            } else {
                              context.read<LoginBloc>().add(
                                    LoginButtonPressed(
                                      username: emailC.text,
                                      password: passwordC.text,
                                    ),
                                  );
                              // if (emailC.text == "jhonericson90@gmail.com" &&
                              //     passwordC.text == "123456") {
                              //   _saveUser(email: emailC.text);
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const BottomNavigation(),
                              //     ),
                              //   );
                              // } else {
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       backgroundColor: Colors.white,
                              //       content: Text(
                              //         "Login Error\nPeriksa Kembali Email dan Password",
                              //         style: kfBlack14Regular,
                              //       ),
                              //     ),
                              //   );
                              // }
                              // _saveUser(email: emailC.text);

                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const BottomNavigation(),
                              //   ),
                              // );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  "Login Error",
                                  style: kfBlack14Regular,
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Login",
                          style: kfWhite14Medium,
                        ),
                      ),
                    ),
                    ksVertical30,
                    ksVertical10,
                    Text(
                      "--- OR ---",
                      style: kfBlack16Regular,
                    ),
                    ksVertical30,
                    ksVertical20,
                    Text(
                      "Connect With",
                      style: kfBlack14Medium,
                    ),
                    ksVertical30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.purple,
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "Phone",
                              style: kfBlack14Regular,
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.purple,
                                child: Icon(
                                  Icons.mail,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "Mail",
                              style: kfBlack14Regular,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.purple,
                                child: Icon(
                                  Icons.more_horiz,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Text(
                              "Other",
                              style: kfBlack14Regular,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserModel extends Equatable {
  final String email;
  final String password;

  const UserModel({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
