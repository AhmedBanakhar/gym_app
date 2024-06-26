// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccountCoache extends StatefulWidget {
  const MyAccountCoache({super.key});

  @override
  State<MyAccountCoache> createState() => _MyAccountCoacheState();
}

class _MyAccountCoacheState extends State<MyAccountCoache> {
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
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Container(
                        height: 50,
                        width: 50,
                        child: const Icon(Icons.arrow_back_ios,
                            size: 24, color: Color(0xFFDDE6ED)),
                        decoration: const BoxDecoration(
                            color: Color(0xff526D82),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                      onTap: () {
                        Navigator.of(context).pushNamed("homepagecoache");
                      },
                    ),
                    const Text(
                      'Account Details',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFDDE6ED)),
                    ),
                    SizedBox(
                      height: 24,
                      width: 24,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                    child: Stack(
                      children: [
                        if ((snapshot.data!['Coach_Image'] != null))
                          CircleAvatar(
                            radius: 70,
                            child: ClipOval(
                              child: Image.network(
                                  "$imageurl${snapshot.data!['Coach_Image']}",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        if (snapshot.data!['Coach_Image'] == null)
                          CircleAvatar(
                            radius: 70,
                            child: ClipOval(
                              child: Image.asset('images/person2.png',
                                  height: 150, width: 150, fit: BoxFit.cover),
                            ),
                          ),
                        Positioned(
                            bottom: 1,
                            right: 1,
                            child: Container(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("updateAccountcoache");
                                },
                                icon: Icon(
                                  Icons.add_a_photo,
                                ),
                                color: Colors.white,
                              ),
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 124, 114, 111),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
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
                child: ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Name :  ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Coach_Name'].toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Age : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Coach_Age'].toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Email :',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Coach_Email'].toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Sex : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Coach_Sex'].toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Phone:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Coach_Phone'].toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Identity Type : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Identity_Type']
                                            .toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Identity Number:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Identity_Number']
                                            .toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Favorite Fied:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Favorite_field']
                                            .toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Container(
                              height: 60,
                              // ignore: sort_child_properties_last
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Acoount:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF27374D)),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data?['Account_Type'].toString() ??
                                        '',
                                    style: TextStyle(
                                        color: const Color(0xFF27374D)),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: const Color(0xFF27374D)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                            child: Expanded(
                              child: Container(
                                height: 180,
                                // ignore: sort_child_properties_last
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Description:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFF27374D)),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data?['Coach_Description']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                              color: const Color(0xFF27374D)),
                                          overflow: TextOverflow.clip,
                                          maxLines: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  border: Border.all(
                                      width: 1.0,
                                      color: const Color(0xFF27374D)),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 70,
                                    width: 150,
                                    // ignore: sort_child_properties_last
                                    child: const Align(
                                      child: Text(
                                        'UpDate',
                                        style: TextStyle(
                                            color: const Color(0xFFDDE6ED),
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
                            ),
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed("updateAccountcoache");
                            },
                          ),
                        ],
                      );
                    }),
              ))
            ],
          );
        });
  }
}
