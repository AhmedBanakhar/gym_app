import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DietarySupplement extends StatefulWidget {
  const DietarySupplement({super.key});

  @override
  State<DietarySupplement> createState() => _DietarySupplementState();
}

class _DietarySupplementState extends State<DietarySupplement> {
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
    _readCoachName();
  }

  _readCoachName() async {
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
          backgroundColor: const Color(0xFF27374D),
          title: Text("Dietary Supplement")),
      body: FutureBuilder(
          future: databaseHelper.getDataMemberDietarySupplement(),
          builder: (context, snapshot) {
            print(snapshot.hasData);
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

            return Column(
              children: [
                Expanded(
                    child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 10, top: 20),
                                    //height: 200,
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, bottom: 10),
                                    child: Container(
                                      height: 400,
                                      width: 400,
                                      decoration: BoxDecoration(
                                          color: AppColor.botoum2,
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0),
                                              //topLeft: Radius.circular(80.0),
                                              topRight: Radius.circular(80.0)),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromARGB(
                                                        255, 116, 112, 112)
                                                    .withOpacity(0.3),
                                                offset:
                                                    const Offset(-10.0, 10.0),
                                                blurRadius: 20.0,
                                                spreadRadius: 4.0)
                                          ]),
                                      padding: const EdgeInsets.only(
                                        left: 32,
                                        top: 20.0,
                                        bottom: 20,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      //Text("Type:", style: TextStyle(color: Colors.white, fontSize: 17)),
                                                      Text(
                                                        'Supplement_Name : ',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow:
                                                            TextOverflow.clip,
                                                        maxLines: 10,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          snapshot.data?[0][
                                                                      'Supplement_Name']
                                                                  .toString() ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                          ),
                                                          overflow:
                                                              TextOverflow.clip,
                                                          maxLines: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      //Text("Type:", style: TextStyle(color: Colors.white, fontSize: 17)),
                                                      Text(
                                                        'Day : ',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow:
                                                            TextOverflow.clip,
                                                        maxLines: 10,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          snapshot.data?[0]
                                                                      ['Day']
                                                                  .toString() ??
                                                              '',
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                          ),
                                                          overflow:
                                                              TextOverflow.clip,
                                                          maxLines: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      //Text("Type:", style: TextStyle(color: Colors.white, fontSize: 17)),
                                                      Text(
                                                        'Instruction : ',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .fontwhite,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        snapshot.data?[0][
                                                                    'Instruction']
                                                                .toString() ??
                                                            '',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                        overflow:
                                                            TextOverflow.clip,
                                                        maxLines: 50,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Column(
                                                    // crossAxisAlignment:
                                                    //     CrossAxisAlignment
                                                    //         .start,
                                                    children: [
                                                      //Text("Type:", style: TextStyle(color: Colors.white, fontSize: 17)),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Nutritionist_Name : ',
                                                            style: TextStyle(
                                                                color: AppColor
                                                                    .fontwhite,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            snapshot.data?[0][
                                                                        'Nutritionist_Name']
                                                                    .toString() ??
                                                                '',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            maxLines: 20,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })))
              ],
            );
          }),
    );
  }
}
