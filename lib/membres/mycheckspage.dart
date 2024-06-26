//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:mohamed/Controllers/databasehelper.dart';
import 'package:mohamed/auth/appcolor.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MyChecks extends StatefulWidget {
  const MyChecks({super.key});

  @override
  State<MyChecks> createState() => _MyChecksState();
}

class _MyChecksState extends State<MyChecks> {
  DatabaseHelper databaseHelper = DatabaseHelper();
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

  String memberName = '';
  String memberEmail = '';
  String memberpassword = '';
  String memberId = '';
  String imageurl = '';
  @override
  void initState() {
    super.initState();
    _readMemberName();
  }

  _readMemberName() async {
    final result = await read();
    setState(() {
      memberName = result['Member_Name'];
      memberEmail = result['Email'];
      memberpassword = result['Passsword'];
      memberId = result['id'];
      imageurl = databaseHelper.serverimage;
      print('hgggggggggg:$memberId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff27374D), title: const Text("MyChecks")),
      body: FutureBuilder(
          future: databaseHelper.getDataMemberExaminations(memberId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Text('there is no data'),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) {
                  return Card(
                      color: AppColor.botoum2,
                      borderOnForeground: false,
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.all(20),
                      elevation: 20.0,
                      shadowColor: Colors.grey.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          if ((snapshot.data?[i]['Examination_image'] != null))
                            Row(
                              children: [
                                InstaImageViewer(
                                    child: ClipRRect(
                                  // clipBehavior: ,

                                  // borderRadius: BorderRadius.circular(20),

                                  child: Image(
                                    image: NetworkImage(
                                      "$imageurl${snapshot.data?[i]['Examination_image']}",
                                    ),
                                    width: 150,
                                    height: 130,
                                  ),
                                )),
                                // ignore: unnecessary_const
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  snapshot.data?[i]['created_at'].toString() ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.botoum4),
                                ),
                              ],
                            )
                          else
                            Row(
                              children: [
                                InstaImageViewer(
                                    child: ClipRRect(
                                  // clipBehavior: ,

                                  // borderRadius: BorderRadius.circular(20),

                                  child: Image(
                                    image: AssetImage(
                                      "images/Diet.jpg",
                                    ),
                                    width: 150,
                                    height: 130,
                                  ),
                                )),
                                // ignore: unnecessary_const
                                const SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  snapshot.data?[i]['created_at'].toString() ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.botoum4),
                                ),
                              ],
                            )
                        ],
                      ));
                });
          }),
    );
  }
}
