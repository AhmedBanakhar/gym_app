// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/login.dart';

class ShowFixedPlans extends StatefulWidget {
  const ShowFixedPlans({super.key});

  @override
  State<ShowFixedPlans> createState() => _ShowFixedPlansState();
}

class _ShowFixedPlansState extends State<ShowFixedPlans> {
  List<String> Plan_Type = ['Intermediate', 'Advance', 'Beginner'];
  String? selected_Plan_Type = null;
  int _selectedindex = 0;
  String imageurl = '';
  var plan_type;

  void initState() {
    super.initState();
    _readCoachName();
    plan_type = databaseHelper.getfixdpaln('');
    print(plan_type);
  }

  _readCoachName() async {
    setState(() {
      imageurl = databaseHelper.serverimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xfff27374D), title: Text("Show Plans")),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: FutureBuilder<List<dynamic>>(
            future: plan_type,
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

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                        left: 12, right: 12, top: 20, bottom: 20),
                    child: DropdownButtonFormField<String>(
                      onSaved: (newValue) {
                        setState(() {
                          plan_type = databaseHelper.getfixdpaln(newValue!);
                        });
                        Navigator.pop(context);
                      },
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          label: Container(
                            child: const Text(
                              maxLines: 1,
                              "Plan_Type",
                              style: TextStyle(
                                color: Color.fromARGB(255, 55, 53, 53),
                              ),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          )),
                      value: selected_Plan_Type,
                      items: Plan_Type.map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            maxLines: 1,
                            item,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ))).toList(),
                      onChanged: (item) {
                        setState(() {
                          selected_Plan_Type = item;
                          plan_type =
                              databaseHelper.getfixdpaln(selected_Plan_Type!);
                        });
                        // Navigator.pop(context);
                        //_showbottom();
                      },

                      hint: const Text(
                        maxLines: 1,
                        "Choose Plan_Type",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      // iconEnabledColor: Color(0xfff79122),
                      iconSize: 15.0,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
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
                                                          left: 10, right: 10),
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
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10, right: 10),
                                                      child: Text(
                                                        "Plan Type :",
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
                                                      snapshot.data?[i]
                                                                  ['Plan_type']
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
                                                      padding: const EdgeInsets
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
                                                                            i][
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
                                                                    .all(Radius
                                                                        .circular(
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
                                                      padding: const EdgeInsets
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
                                                                            i][
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
                                                                    .all(Radius
                                                                        .circular(
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
                                                margin: EdgeInsets.only(top: 5),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
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
                                                                            i][
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
                                                                    .all(Radius
                                                                        .circular(
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
                                                      padding: const EdgeInsets
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
                                                                            i][
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
                                                                    .all(Radius
                                                                        .circular(
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
                                                margin: EdgeInsets.only(top: 5),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
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
                                                                            i][
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
                                                                    .all(Radius
                                                                        .circular(
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Description",
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: AppColor
                                                              .fontprimaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5, right: 5),
                                                      padding:
                                                          EdgeInsets.all(8),
                                                      decoration: BoxDecoration(
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
                                                          overflow: TextOverflow
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
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      shape:
                                                          RoundedRectangleBorder(
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
                              height: 100,
                              decoration: BoxDecoration(
                                  color: AppColor.botoum3,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25))),
                              child: Row(
                                children: [
                                  if ((snapshot.data![i]['Exercise_Image'] !=
                                      null))
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
                                    )
                                  else
                                    Container(
                                      height: 70,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'images/person2.png'),
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
                                          child: Text(
                                            snapshot.data?[i]['Exercise_Name']
                                                    .toString() ??
                                                '',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot.data?[i]
                                                            ['Number_of_tours']
                                                        .toString() ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: AppColor.fontwhite),
                                              ),
                                              Text(
                                                'set x',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: AppColor.fontwhite),
                                              ),
                                              Text(
                                                snapshot.data?[i]
                                                            ['Number_of_times']
                                                        .toString() ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: AppColor.fontwhite),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            snapshot.data?[i]['Plan_type']
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColor.fontwhite),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
