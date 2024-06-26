// ignore_for_file: prefer_const_declarations

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpDateAccountCoache extends StatefulWidget {
  const UpDateAccountCoache({super.key});

  @override
  State<UpDateAccountCoache> createState() => _UpDateAccountState();
}

class _UpDateAccountState extends State<UpDateAccountCoache> {
  final TextEditingController _passwordController = new TextEditingController();
  GlobalKey<FormState> formstatepassword = GlobalKey();
  ImagePicker picker = ImagePicker();
  File? imagecoachee;
  Future pickImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        imagecoachee = File(PickedFile.path);
      }
    });
  }

  // String? email;
  String? password;
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key1 = 'Account_Type';
    final value1 = prefs.get(key1) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    final key3 = 'Email';
    final value3 = prefs.get(key3) ?? 0;
    final key4 = 'Passsword';
    final value4 = prefs.get(key4) ?? 0;
    final key5 = 'Coach_Name';
    final value5 = prefs.get(key5) ?? 0;
    final key6 = 'Member_Name';
    final value6 = prefs.get(key6) ?? 0;

    return {
      'id': value,
      'Account_Type': value1,
      'token': value2,
      'Email': value3,
      'Passsword': value4,
      'Coach_Name': value5,
      'Member_Name': value6,
    };
  }

  String coachName = '';
  String coachEmail = '';
  String imageurl = '';
  String coachId = '';
  @override
  void initState() {
    super.initState();
    _readCoachName();
  }

  _readCoachName() async {
    final result = await read();
    setState(() {
      coachName = result['Coach_Name'];
      coachEmail = result['Email'];
      coachId = result['id'];
      imageurl = databaseHelper.serverimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF27374D),
      body: profileView(),
    );
  }

  Widget profileView() {
    return FutureBuilder(
        future: databaseHelper.getDataCoache(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          }

          return ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, i) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(Icons.arrow_back_ios,
                                    size: 24, color: Color(0xFFDDE6ED)),
                                decoration: const BoxDecoration(
                                    color: Color(0xff526D82),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed("myaccountcoache");
                              },
                            ),
                            const Text(
                              'Account Update',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFDDE6ED)),
                            ),
                            Container(
                              height: 24,
                              width: 24,
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                            child: (imagecoachee == null)
                                ? Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        child: ClipOval(
                                          child: (snapshot
                                                      .data!['Coach_Image'] ==
                                                  null)
                                              ? Image.asset(
                                                  "images/person2.png")
                                              : Image.network(
                                                  "$imageurl${snapshot.data!['Coach_Image']}",
                                                  height: 150,
                                                  width: 150,
                                                  fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 1,
                                          right: 1,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            child: IconButton(
                                              onPressed: pickImage,
                                              icon: Icon(
                                                Icons.add_a_photo,
                                              ),
                                              color: Colors.white,
                                            ),
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 124, 114, 111),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                          )),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 70,
                                        child: ClipOval(
                                          child: Image.file(
                                              File(imagecoachee!.path),
                                              height: 150,
                                              width: 150,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 1,
                                          right: 1,
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            child: IconButton(
                                              onPressed: pickImage,
                                              icon: Icon(
                                                Icons.add_a_photo,
                                              ),
                                              color: Colors.white,
                                            ),
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 124, 114, 111),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                          )),
                                    ],
                                  ),
                          ),
                          Text(
                            coachName,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFDDE6ED)),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [Colors.white, Colors.white])),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                              child: Form(
                                key: formstatepassword,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onSaved: (val) {
                                          password = val;
                                        },
                                        controller: _passwordController,

                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 18),
                                        decoration: InputDecoration(
                                            suffixIcon: const Icon(
                                                Icons.key_off_rounded),
                                            suffixIconColor: Colors.black,
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                  color: Color(0xff27374D),
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: const BorderSide(
                                                    color: Colors.black)),
                                            fillColor: Colors.white,
                                            filled: true,
                                            label: Text(
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
                                            return " Cannot Empty";
                                          }
                                          ;
                                          if (value.length < 8) {
                                            return "Cannot smaller than 8";
                                          }
                                          if (value.length > 12) {
                                            return "Cannot greater than 12";
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: InkWell(
                                child: Align(
                                    child: Container(
                                  height: 70,
                                  width: 150,
                                  // ignore: sort_child_properties_last
                                  child: const Align(
                                    child: Text(
                                      'Update',
                                      style: TextStyle(
                                          color: Color(0xFFDDE6ED),
                                          fontSize: 20),
                                    ),
                                  ),
                                  decoration: const BoxDecoration(
                                      color: Color(0xFF27374D),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          topRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                )),
                                onTap: () {
                                  if (imagecoachee == null) {
                                    databaseHelper.eidtdataCoachPassword(
                                        coachId, _passwordController.text);
                                    setState(() {});
                                  } else {
                                    databaseHelper.eidtdataCoachimage(
                                        coachId, imagecoachee!);
                                    setState(() {});
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                );
              });
        });
  }

  void _ShowDialogg() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // ignore: prefer_const_constructors
            title: Text('Failed'),
            content: const Text('There is no Picture'),
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
}
