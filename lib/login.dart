//import 'dart:convert';

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mohamed/Controllers/databasehelper.dart';
//import 'package:http/http.dart';
import 'package:mohamed/auth/appcolor.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

// ignore: unnecessary_new
DatabaseHelper databaseHelper = new DatabaseHelper();

class _LoginState extends State<Login> {
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key1 = 'Account_Type';
    final value1 = prefs.get(key1) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    if (value1 == 'Coach' && value1 != 'out') {
      Navigator.restorablePushReplacementNamed(context, 'homepagecoache');
    } else if (value1 == 'Gym_Member' && value1 != 'out') {
      Navigator.restorablePushReplacementNamed(context, 'homemembre');
    } else if (value1 == 'Admin' ||
        value1 == 'Employee' ||
        value1 == 'Nutritionist') {
      showDialog(
          context: context, builder: (_) => showSelectDialogLoginAdmin());
    }

    print('Id :$value');
    print('Account_Type :$value1');
    print('Token :$value2');
  }

  @override
  initState() {
    super.initState();
    read();
  }

  GlobalKey<FormState> formstate = GlobalKey();
  String? email;
  String? password;
  bool _passwordVisible = true;
  late String msgStatus = '';

  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  _onPressed() {
    setState(() {
      if (_emailController.text.trim().toLowerCase().isNotEmpty &&
          _passwordController.text.trim().isNotEmpty) {
        databaseHelper
            .logindata(_emailController.text.trim().toLowerCase(),
                _passwordController.text.trim(), context)
            .whenComplete(() {
          if (databaseHelper.status) {
            showDialog(
                context: context, builder: (_) => showSelectDialogErrorLogin());

            msgStatus = 'Check email or password';
            debugPrint(
                '${_emailController.text.trim().toLowerCase()}  ${_passwordController.text.trim()}');
          } else {
            read();
            //Navigator.restorablePushReplacementNamed(context, 'homepagecoache');
          }

          //Navigator.of(context) .pushNamed("homemembre");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                      width: 500,
                      padding: const EdgeInsets.only(
                          top: 0, right: 30, left: 30, bottom: 0),
                      decoration: const BoxDecoration(
                          // color: Color.fromARGB(255, 210, 208, 208),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        children: [
                          Container(
                            height: 300,
                            width: 400,
                            child: Image.asset(
                              "images/logo3.png",
                              width: 250,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Enter your email and password",
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Form(
                              key: formstate,
                              child: Column(
                                children: [
                                  TextFormField(
                                    onSaved: (val) {
                                      email = val;
                                    },
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    decoration: InputDecoration(
                                        suffixIcon: Icon(Icons.email_outlined),
                                        suffixIconColor: AppColor.botoum1,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                                color: AppColor.botoum3)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        fillColor: Colors.white,
                                        filled: true,
                                        label: const Text(
                                          "Email",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 55, 53, 53),
                                              fontSize: 20),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return " Please Enter The Email";
                                      }

                                      if (value.length < 8) {
                                        return "Cannot smaller than 8";
                                      }

                                      if (!RegExp(r'\S+@gym.com')
                                          .hasMatch(value)) {
                                        return "Please Enter Correct Email ";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onSaved: (val) {
                                      password = val;
                                    },
                                    controller: _passwordController,
                                    obscureText: _passwordVisible,
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                    !_passwordVisible;
                                              });
                                            },
                                            icon: Icon(_passwordVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility)),
                                        suffixIconColor: AppColor.botoum1,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                              color: AppColor.botoum3,
                                            )),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: const BorderSide(
                                                color: AppColor.black)),
                                        fillColor: Colors.white,
                                        filled: true,
                                        label: const Text(
                                          "Password",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 55, 53, 53),
                                              fontSize: 20),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return " Please Enter The Password";
                                      }
                                      ;
                                      if (value.length < 8) {
                                        return "Cannot smaller than 8";
                                      }
                                      if (value.length > 30) {
                                        return "Cannot greater than 12";
                                      }
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: 200,
                                    child: MaterialButton(
                                      // onPressed: () {
                                      //   if (formstate.currentState!
                                      //       .validate()) {
                                      //     formstate.currentState!.save();
                                      //     Navigator.of(context)
                                      //         .pushNamed("homemembre");
                                      //   }
                                      //   ;
                                      //   // Navigator.of(context).pushNamed("homemembre");
                                      // }
                                      //,
                                      onPressed: () {
                                        if (formstate.currentState!
                                            .validate()) {
                                          formstate.currentState!.save();
                                          _onPressed();
                                        }
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: AppColor.botoum1,
                                      child: const Text(
                                        "Login",
                                        style: TextStyle(
                                            color: AppColor.fontwhite,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 190.0, left: 15),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_forward_rounded),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed("firstpage");
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColor.botoum3,
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "Gym Info",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Failed'),
            content: const Text('Check your email or password'),
            actions: <Widget>[
              // ignore: unnecessary_new
              new ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Close",
                ),
              )
            ],
          );
        });
  }

  showSelectDialogLoginAdmin() {
    return AlertDialog(
      backgroundColor: AppColor.fontwhite,
      titleTextStyle: TextStyle(fontSize: 17, color: Colors.black),
      content: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Close',
          style:
              TextStyle(fontSize: 14, color: Colors.blue, fontFamily: 'Inter'),
        ),
      ),
      title: const Text(
        'There is no Mobile App for you,  use the desktop version',
        style: TextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }

  showSelectDialogErrorLogin() {
    return AlertDialog(
      backgroundColor: AppColor.fontwhite,
      titleTextStyle: TextStyle(fontSize: 17, color: AppColor.fontwhite),
      content: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Close',
          style:
              TextStyle(fontSize: 14, color: Colors.blue, fontFamily: 'Inter'),
        ),
      ),
      title: const Text(
        'The Account or Password Not Correct',
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
