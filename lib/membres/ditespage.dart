// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:insta_image_viewer/insta_image_viewer.dart';

class Dites extends StatefulWidget {
  const Dites({super.key});

  @override
  State<Dites> createState() => _DitesState();
}

class _DitesState extends State<Dites> {
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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
        length: 7,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff27374D),
              title: const Text(
                "Dites",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              elevation: 0.0,
              bottom: TabBar(
                  indicatorColor: Color.fromARGB(240, 245, 236, 225),
                  indicatorWeight: 4,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: Container(
                          child: Text("Sat",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold))),
                    ),
                    Tab(
                      child: Container(
                          child: Text(
                        "Sun",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                    Tab(
                      child: Container(
                        child: Text("Mon",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text("Tue",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text("Wed",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text("Thu",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Tab(
                      child: Container(
                        child: Text("Fri",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    )
                  ]),
            ),
            backgroundColor: Colors.white,
            body: TabBarView(children: [
              Container(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    height: 230,
                    child: Stack(children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: 180.0,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0)
                                  ]),
                              //child: Text(''),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Color(0xff9DB2BF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200],
                                  border: Border.all(color: Color(0xff9DB2BF)),
                                  // borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/waters.jpg'))),
                            ),
                          )),
                      Positioned(
                          top: 60,
                          left: 200,
                          child: FutureBuilder(
                              future: databaseHelper
                                  .getDataMemberfoodRation(memberId),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                return Container(
                                  height: 150,
                                  width: 160,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cups of Waters:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 1, 1, 3),
                                              fontWeight: FontWeight.bold),
                                        ),

                                        /*Text('Sorrento Lemon Chicken,Healthy Sheet Pan Sausage & Veggies,',style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold),),*/
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snapshot.data?[0]['Cup_of_water']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                );
                              })),
                    ]),
                  ),
                  Expanded(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: FutureBuilder(
                              future: databaseHelper.getDataMemberDiteSat(
                                memberId,
                              ),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_1: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_1']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_1_Time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_1_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Fast: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Breakfast']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Time_BreakFast: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Breakfast_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_2: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_2']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Sanck_2_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Sanck_2_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Lunch: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Lunch']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Lunch_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Lunch_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_3: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_3']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_3_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_3_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Dinner: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Dinner']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Dinner_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Dinner_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 650,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_4: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_4']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_4_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_4_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          15),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Before_Exercise: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Before_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "After_Exercise: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['After_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Nutritionist_Name: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Nutritionist_Name']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }))),
                ]),
              ),
              Container(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    height: 230,
                    child: Stack(children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: 180.0,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0)
                                  ]),
                              //child: Text(''),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Color(0xff9DB2BF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200],
                                  border: Border.all(color: Color(0xff9DB2BF)),
                                  // borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/waters.jpg'))),
                            ),
                          )),
                      Positioned(
                          top: 60,
                          left: 200,
                          child: FutureBuilder(
                              future: databaseHelper
                                  .getDataMemberfoodRation(memberId),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                return Container(
                                  height: 150,
                                  width: 160,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cups of Waters:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 1, 1, 3),
                                              fontWeight: FontWeight.bold),
                                        ),

                                        /*Text('Sorrento Lemon Chicken,Healthy Sheet Pan Sausage & Veggies,',style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold),),*/
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snapshot.data?[0]['Cup_of_water']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                );
                              })),
                    ]),
                  ),
                  Expanded(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: FutureBuilder(
                              future: databaseHelper.getDataMemberDiteSun(
                                memberId,
                              ),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_1: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_1']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_1_Time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_1_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Fast: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Breakfast']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Time_BreakFast: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Breakfast_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_2: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_2']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Sanck_2_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Sanck_2_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Lunch: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Lunch']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Lunch_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Lunch_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_3: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_3']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_3_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_3_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Dinner: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Dinner']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Dinner_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Dinner_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 650,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_4: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_4']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_4_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_4_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          15),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Before_Exercise: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Before_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "After_Exercise: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['After_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Nutritionist_Name: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Nutritionist_Name']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }))),
                ]),
              ),
              Container(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    height: 230,
                    child: Stack(children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: 180.0,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0)
                                  ]),
                              //child: Text(''),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Color(0xff9DB2BF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200],
                                  border: Border.all(color: Color(0xff9DB2BF)),
                                  // borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/waters.jpg'))),
                            ),
                          )),
                      Positioned(
                          top: 60,
                          left: 200,
                          child: FutureBuilder(
                              future: databaseHelper
                                  .getDataMemberfoodRation(memberId),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                return Container(
                                  height: 150,
                                  width: 160,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cups of Waters:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 1, 1, 3),
                                              fontWeight: FontWeight.bold),
                                        ),

                                        /*Text('Sorrento Lemon Chicken,Healthy Sheet Pan Sausage & Veggies,',style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold),),*/
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snapshot.data?[0]['Cup_of_water']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                );
                              })),
                    ]),
                  ),
                  Expanded(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: FutureBuilder(
                              future: databaseHelper.getDataMemberDiteMon(
                                memberId,
                              ),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_1: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_1']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_1_Time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_1_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Fast: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Breakfast']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Time_BreakFast: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Breakfast_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_2: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_2']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Sanck_2_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Sanck_2_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Lunch: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Lunch']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Lunch_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Lunch_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_3: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_3']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_3_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_3_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Dinner: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Dinner']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Dinner_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Dinner_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 650,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_4: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_4']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_4_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_4_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          15),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Before_Exercise: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Before_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "After_Exercise: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['After_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Nutritionist_Name: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Nutritionist_Name']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }))),
                ]),
              ),
              Container(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    height: 230,
                    child: Stack(children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: 180.0,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0)
                                  ]),
                              //child: Text(''),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Color(0xff9DB2BF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200],
                                  border: Border.all(color: Color(0xff9DB2BF)),
                                  // borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/waters.jpg'))),
                            ),
                          )),
                      Positioned(
                          top: 60,
                          left: 200,
                          child: FutureBuilder(
                              future: databaseHelper
                                  .getDataMemberfoodRation(memberId),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                return Container(
                                  height: 150,
                                  width: 160,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cups of Waters:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 1, 1, 3),
                                              fontWeight: FontWeight.bold),
                                        ),

                                        /*Text('Sorrento Lemon Chicken,Healthy Sheet Pan Sausage & Veggies,',style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold),),*/
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snapshot.data?[0]['Cup_of_water']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                );
                              })),
                    ]),
                  ),
                  Expanded(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: FutureBuilder(
                              future: databaseHelper.getDataMemberDiteTue(
                                memberId,
                              ),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_1: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_1']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_1_Time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_1_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Fast: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Breakfast']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Time_BreakFast: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Breakfast_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_2: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_2']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Sanck_2_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Sanck_2_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Lunch: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Lunch']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Lunch_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Lunch_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_3: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_3']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_3_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_3_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Dinner: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Dinner']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Dinner_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Dinner_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 650,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_4: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_4']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_4_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_4_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          15),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Before_Exercise: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Before_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "After_Exercise: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['After_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Nutritionist_Name: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Nutritionist_Name']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }))),
                ]),
              ),
              Container(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    height: 230,
                    child: Stack(children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: 180.0,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0)
                                  ]),
                              //child: Text(''),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Color(0xff9DB2BF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200],
                                  border: Border.all(color: Color(0xff9DB2BF)),
                                  // borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/waters.jpg'))),
                            ),
                          )),
                      Positioned(
                          top: 60,
                          left: 200,
                          child: FutureBuilder(
                              future: databaseHelper
                                  .getDataMemberfoodRation(memberId),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                return Container(
                                  height: 150,
                                  width: 160,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cups of Waters:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 1, 1, 3),
                                              fontWeight: FontWeight.bold),
                                        ),

                                        /*Text('Sorrento Lemon Chicken,Healthy Sheet Pan Sausage & Veggies,',style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold),),*/
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snapshot.data?[0]['Cup_of_water']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                );
                              })),
                    ]),
                  ),
                  Expanded(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: FutureBuilder(
                              future: databaseHelper.getDataMemberDiteWed(
                                memberId,
                              ),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_1: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_1']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_1_Time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_1_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Fast: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Breakfast']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Time_BreakFast: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Breakfast_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_2: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_2']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Sanck_2_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Sanck_2_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Lunch: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Lunch']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Lunch_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Lunch_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_3: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_3']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_3_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_3_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Dinner: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Dinner']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Dinner_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Dinner_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 650,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_4: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_4']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_4_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_4_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          15),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Before_Exercise: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Before_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "After_Exercise: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['After_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Nutritionist_Name: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Nutritionist_Name']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }))),
                ]),
              ),
              Container(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    height: 230,
                    child: Stack(children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: 180.0,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0)
                                  ]),
                              //child: Text(''),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Color(0xff9DB2BF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200],
                                  border: Border.all(color: Color(0xff9DB2BF)),
                                  // borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/waters.jpg'))),
                            ),
                          )),
                      Positioned(
                          top: 60,
                          left: 200,
                          child: FutureBuilder(
                              future: databaseHelper
                                  .getDataMemberfoodRation(memberId),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                return Container(
                                  height: 150,
                                  width: 160,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cups of Waters:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 1, 1, 3),
                                              fontWeight: FontWeight.bold),
                                        ),

                                        /*Text('Sorrento Lemon Chicken,Healthy Sheet Pan Sausage & Veggies,',style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold),),*/
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snapshot.data?[0]['Cup_of_water']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                );
                              })),
                    ]),
                  ),
                  Expanded(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: FutureBuilder(
                              future: databaseHelper.getDataMemberDiteThu(
                                memberId,
                              ),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_1: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_1']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_1_Time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_1_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Fast: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Breakfast']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Time_BreakFast: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Breakfast_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_2: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_2']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Sanck_2_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Sanck_2_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Lunch: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Lunch']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Lunch_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Lunch_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_3: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_3']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_3_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_3_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Dinner: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Dinner']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Dinner_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Dinner_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 650,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_4: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_4']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_4_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_4_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          15),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Before_Exercise: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Before_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "After_Exercise: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['After_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Nutritionist_Name: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Nutritionist_Name']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }))),
                ]),
              ),
              Container(
                child: Column(children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Container(
                    height: 230,
                    child: Stack(children: [
                      Positioned(
                          top: 35,
                          left: 20,
                          child: Material(
                            child: Container(
                              height: 180.0,
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(0.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        offset: const Offset(-10.0, 10.0),
                                        blurRadius: 20.0,
                                        spreadRadius: 4.0)
                                  ]),
                              //child: Text(''),
                            ),
                          )),
                      Positioned(
                          top: 0,
                          left: 30,
                          child: Card(
                            elevation: 10.0,
                            shadowColor: Color(0xff9DB2BF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[200],
                                  border: Border.all(color: Color(0xff9DB2BF)),
                                  // borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage('images/waters.jpg'))),
                            ),
                          )),
                      Positioned(
                          top: 60,
                          left: 200,
                          child: FutureBuilder(
                              future: databaseHelper
                                  .getDataMemberfoodRation(memberId),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                return Container(
                                  height: 150,
                                  width: 160,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Cups of Waters:',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  Color.fromARGB(255, 1, 1, 3),
                                              fontWeight: FontWeight.bold),
                                        ),

                                        /*Text('Sorrento Lemon Chicken,Healthy Sheet Pan Sausage & Veggies,',style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight: FontWeight.bold),),*/
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          snapshot.data?[0]['Cup_of_water']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ]),
                                );
                              })),
                    ]),
                  ),
                  Expanded(
                      child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: FutureBuilder(
                              future: databaseHelper.getDataMemberDiteFri(
                                memberId,
                              ),
                              builder: (context, snapshot) {
                                print(snapshot.hasData);
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
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
                                      return Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_1: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_1']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_1_Time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_1_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Fast: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Breakfast']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Time_BreakFast: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Breakfast_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_2: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_2']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Sanck_2_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Sanck_2_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Break Lunch: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Lunch']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Lunch_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Lunch_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 550,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_3: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_3']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_3_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_3_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Dinner: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Dinner']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Dinner_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Dinner_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          18),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10, top: 25),
                                              height: 650,
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColor.botoum1,
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(80.0),
                                                      // bottomRight: Radius.circular(80.0),
                                                      topRight:
                                                          Radius.circular(80.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Color.fromARGB(
                                                                  255,
                                                                  116,
                                                                  112,
                                                                  112)
                                                              .withOpacity(0.3),
                                                          offset: const Offset(
                                                              -10.0, 10.0),
                                                          blurRadius: 20.0,
                                                          spreadRadius: 4.0)
                                                    ]),
                                                padding: const EdgeInsets.only(
                                                  left: 32,
                                                  top: 50.0,
                                                  bottom: 50,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Container(
                                                          width: 200,
                                                          height: 150,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      const Offset(
                                                                          -10.0,
                                                                          10.0),
                                                                  blurRadius:
                                                                      20.0,
                                                                  spreadRadius:
                                                                      4.0)
                                                            ],
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child: Image(
                                                                image: AssetImage(
                                                                    'images/snack.jpeg'),
                                                                fit: BoxFit
                                                                    .cover),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 40),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Snack_4: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Snack_4']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            17),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  "Snack_4_time: ",
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          20)),
                                                              Expanded(
                                                                child: Text(
                                                                  snapshot.data?[
                                                                              0]
                                                                              [
                                                                              'Snack_4_time']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: AppColor
                                                                          .botoum4,
                                                                      fontSize:
                                                                          15),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .clip,
                                                                  maxLines: 15,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "Before_Exercise: ",
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            20),
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
                                                                    snapshot.data?[0]['Before_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 25),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "After_Exercise: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['After_Exercise']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 40,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                      "Nutritionist_Name: ",
                                                                      style: TextStyle(
                                                                          color: AppColor
                                                                              .botoum4,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    snapshot.data?[0]['Nutritionist_Name']
                                                                            .toString() ??
                                                                        '',
                                                                    style: TextStyle(
                                                                        color: AppColor
                                                                            .botoum4,
                                                                        fontSize:
                                                                            15),
                                                                    overflow:
                                                                        TextOverflow
                                                                            .clip,
                                                                    maxLines:
                                                                        15,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              }))),
                ]),
              ),
            ])));
  }
}
