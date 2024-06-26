// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/coachs/checkmember.dart';
import 'package:mohamed/coachs/editplan.dart';
import 'package:mohamed/coachs/showfixedplan.dart';

import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowPlanCoache extends StatefulWidget {
  var memberID;
  var member_Name;
  ShowPlanCoache({super.key, this.memberID, this.member_Name});

  @override
  State<ShowPlanCoache> createState() => _ShowPlanCoacheState();
}

class _ShowPlanCoacheState extends State<ShowPlanCoache> {
  int selected_planId = 0;
  String? notemember;
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

  int count = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xfff27374D), title: Text("Show Plan")),
        body: FutureBuilder(
            future: databaseHelper.getDataMembertrainingplanfromCoache(
              widget.memberID,
            ),
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
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: AlertDialog(
                        backgroundColor: AppColor.fontwhite,
                        titleTextStyle:
                            TextStyle(fontSize: 17, color: Colors.black),
                        content: TextButton(
                            onPressed: () async {
                              await Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ShowFixdPlan(
                                            MemberId: widget.memberID,
                                          )));
                              setState(() {});
                            },
                            child: Container(
                              height: 70,
                              width: 150,
                              // ignore: sort_child_properties_last
                              child: const Align(
                                child: Text(
                                  'Add New Plan',
                                  style: TextStyle(
                                      color: Color(0xFFDDE6ED), fontSize: 20),
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
                        title: const Text(
                          'This member does not have a plan.if you want to add a plan for this member ,click Add New Plan',
                          style: TextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      )

                      //  showDialog(
                      // context: context, builder: (_) => showSelectDialogAddNewPlan())

                      // MaterialButton(
                      //   onPressed: () async {
                      //     await Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (BuildContext context) => ShowFixdPlan(
                      //               MemberId: widget.memberID,
                      //             )));
                      //     setState(() {});
                      //   },
                      //   shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(15)),
                      //   color: AppColor.botoum1,
                      //   child: Padding(
                      //     padding:
                      //         const EdgeInsets.symmetric(horizontal: 50.0),
                      //     child: Text(
                      //       "    Add New Plan  ",
                      //       style: TextStyle(
                      //         color: AppColor.botoum4,
                      //         fontSize: 25,
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              selected_planId = snapshot.data![i]['id'];

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.botoum4,
                                      ),
                                      height: 650,
                                      child: Stack(
                                        children: [
                                          if (snapshot.data![i]
                                                  ['Exercise_Image'] !=
                                              null)
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15,
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 15),
                                              height: 300,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColor.botoum1,
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        "$imageurl${snapshot.data![i]['Exercise_Image']}",
                                                      ),
                                                      fit: BoxFit.fill)),
                                            )
                                          else
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 15,
                                                  left: 15,
                                                  right: 15,
                                                  bottom: 15),
                                              height: 300,
                                              width: 400,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: AppColor.botoum1,
                                                      width: 1.5),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'images/person2.png'),
                                                      fit: BoxFit.fill)),
                                            ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 330, left: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                  snapshot.data?[i]
                                                              ['Exercise_Name']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                              color: AppColor.fontwhite,
                                              margin: const EdgeInsets.only(
                                                  top: 370.0,
                                                  right: 0,
                                                  left: 0,
                                                  bottom: 0),
                                              child: ListView(children: [
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        child: Text(
                                                          "Target Muscle :",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: AppColor
                                                                  .fontprimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data?[i][
                                                                    'Muscle_name']
                                                                .toString() ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                        child: Text(
                                                          "Equipment :",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: AppColor
                                                                  .fontprimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Text(
                                                        snapshot.data?[i][
                                                                    'Machine_Name']
                                                                .toString() ??
                                                            '',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height: 0.2,
                                                  width: double.infinity,
                                                  color: AppColor.botoum2,
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                18, 2, 0, 25),
                                                        child: Container(
                                                          height: 100,
                                                          width: 170,
                                                          // color: Color(0xffDDE6ED),
                                                          // ignore: sort_child_properties_last
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              11.0),
                                                                  child: Text(
                                                                    'Training Rest',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                  snapshot.data?[
                                                                              i]
                                                                              [
                                                                              'Training_rest']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25))
                                                            ],
                                                          ),

                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          20)),
                                                              border: Border.all(
                                                                  width: 1.0,
                                                                  color: AppColor
                                                                      .botoum4),
                                                              color: AppColor
                                                                  .botoum2),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                11, 2, 0, 25),
                                                        child: Container(
                                                          height: 100,
                                                          width: 170,

                                                          // ignore: sort_child_properties_last
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              11.0),
                                                                  child: Text(
                                                                    'Number of Tours',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                  snapshot.data?[
                                                                              i]
                                                                              [
                                                                              'Number_of_tours']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25))
                                                            ],
                                                          ),

                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          20)),
                                                              border: Border.all(
                                                                  width: 1.0,
                                                                  color: AppColor
                                                                      .botoum4),
                                                              color: AppColor
                                                                  .botoum2),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                18, 2, 0, 25),
                                                        child: Container(
                                                          height: 100,
                                                          width: 170,
                                                          // color: Color(0xffDDE6ED),
                                                          // ignore: sort_child_properties_last
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              11.0),
                                                                  child: Text(
                                                                    'Time Period',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                  snapshot.data?[
                                                                              i]
                                                                              [
                                                                              'Time_period']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25))
                                                            ],
                                                          ),

                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          20)),
                                                              border: Border.all(
                                                                  width: 1.0,
                                                                  color: AppColor
                                                                      .botoum4),
                                                              color: AppColor
                                                                  .botoum2),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                11, 2, 0, 25),
                                                        child: Container(
                                                          height: 100,
                                                          width: 170,

                                                          // ignore: sort_child_properties_last
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              11.0),
                                                                  child: Text(
                                                                    'Number of Times',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                  snapshot.data?[
                                                                              i]
                                                                              [
                                                                              'Number_of_times']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25))
                                                            ],
                                                          ),

                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          20)),
                                                              border: Border.all(
                                                                  width: 1.0,
                                                                  color: AppColor
                                                                      .botoum4),
                                                              color: AppColor
                                                                  .botoum2),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                110, 2, 0, 25),
                                                        child: Container(
                                                          height: 100,
                                                          width: 170,

                                                          // ignore: sort_child_properties_last
                                                          child: Column(
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              11.0),
                                                                  child: Text(
                                                                    'Weight',
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                  snapshot.data?[
                                                                              i]
                                                                              [
                                                                              'Weight']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25))
                                                            ],
                                                          ),

                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          20)),
                                                              border: Border.all(
                                                                  width: 1.0,
                                                                  color: AppColor
                                                                      .botoum4),
                                                              color: AppColor
                                                                  .botoum2),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: 10, left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Description",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: AppColor
                                                                .fontprimaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 5, right: 5),
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          20)),
                                                          border: Border.all(
                                                              width: 1.0,
                                                              color: const Color(
                                                                  0xFF27374D)),
                                                          //color: const Color(0xFF27374D)
                                                        ),
                                                        child: Expanded(
                                                          child: Text(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 15,
                                                            snapshot.data?[i][
                                                                        'Exercise_Description']
                                                                    .toString() ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 10, left: 10),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Notes",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: AppColor
                                                                      .fontprimaryColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(8),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                border: Border.all(
                                                                    width: 1.0,
                                                                    color: const Color(
                                                                        0xFF27374D)),
                                                                //color: const Color(0xFF27374D)
                                                              ),
                                                              child: Expanded(
                                                                child: Text(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 15,
                                                                  snapshot.data?[
                                                                              i]
                                                                              [
                                                                              'Member_Note']
                                                                          .toString() ??
                                                                      '',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      MaterialButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        color: AppColor.botoum1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      50.0),
                                                          child: Text(
                                                            "    Done   ",
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .botoum4,
                                                              fontSize: 25,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ])),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                                margin: EdgeInsets.all(15),
                                padding: EdgeInsets.all(10),
                                height:
                                    MediaQuery.of(context).size.height * 0.16,
                                decoration: BoxDecoration(
                                    color: AppColor.botoum3,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(25),
                                        topLeft: Radius.circular(25),
                                        bottomLeft: Radius.circular(25))),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                "$imageurl${snapshot.data![i]['Exercise_Image']}",
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 200,
                                            child: Expanded(
                                              child: Text(
                                                snapshot.data?[i]
                                                            ['Exercise_Name']
                                                        .toString() ??
                                                    '',
                                                style: TextStyle(fontSize: 20),
                                                overflow: TextOverflow.clip,
                                                maxLines: 17,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  snapshot.data?[i][
                                                              'Number_of_tours']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          AppColor.fontwhite),
                                                ),
                                                Text(
                                                  'set x',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          AppColor.fontwhite),
                                                ),
                                                Text(
                                                  snapshot.data?[i][
                                                              'Number_of_times']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          AppColor.fontwhite),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => CheckMember(
                                      member_id: widget.memberID,
                                      member_name: widget.member_Name,
                                    )));
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: AppColor.botoum1,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text(
                              " Examinations  ",
                              style: TextStyle(
                                color: AppColor.botoum4,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => EditPlan(
                                      Id_member: widget.memberID,
                                    )));
                            setState(() {});
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: AppColor.botoum1,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text(
                              "    Edit  ",
                              style: TextStyle(
                                color: AppColor.botoum4,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }));
  }

  showSelectDialogAddNewPlan() {
    return AlertDialog(
      backgroundColor: AppColor.fontwhite,
      titleTextStyle: TextStyle(fontSize: 17, color: Colors.black),
      content: TextButton(
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ShowFixdPlan(
                    MemberId: widget.memberID,
                  )));
          setState(() {});
        },
        child: Container(
          color: AppColor.botoum4,
          child: const Text(
            'Add New Plan',
            style: TextStyle(
                fontSize: 14, color: Colors.blue, fontFamily: 'Inter'),
          ),
        ),
      ),
      title: const Text(
        'This member does not have a plan.if you want to add a plan for this member ,click Add New Plan',
        style: TextStyle(),
        textAlign: TextAlign.center,
      ),
    );
  }
}
