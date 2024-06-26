// ignore_for_file: body_might_complete_normally_nullable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Firstpage extends StatefulWidget {
  const Firstpage({super.key});

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {
  read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;

    return {
      'id': value,
    };
  }

  String coacheId = '';
  String imageurl = '';
  @override
  void initState() {
    super.initState();
    _readCoachName();
  }

  _readCoachName() async {
    // final result = await read();
    setState(() {
      //coacheId = result['id'];
      imageurl = databaseHelper.serverimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Golds Gym")),
        body: ListView(
          children: [
            FutureBuilder(
                future: databaseHelper.getDataGymInf(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error'),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: AppColor.backgraoundcontainer,
                        borderRadius: BorderRadius.circular(25)),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          padding: EdgeInsets.only(bottom: 0),
                          margin: EdgeInsets.only(
                            top: 10,
                          ),
                          height: 135,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "  Gym Info ",
                                      style: TextStyle(
                                          color: AppColor.fontprimaryColor,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    snapshot.data!['Gym_Description']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.fontsecColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 130),
                          height: 300,
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                if (snapshot.data!['Gym_Image'] != null)
                                  Container(
                                    margin: EdgeInsets.all(30),
                                    // padding: EdgeInsets.only(top: 50),
                                    height: 100,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            "$imageurl${snapshot.data!['Gym_Image']}",
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 150.0, top: 22),
                                    ),
                                  )
                                else
                                  Container(
                                    margin: EdgeInsets.all(30),
                                    // padding: EdgeInsets.only(top: 50),
                                    height: 100,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage('images/person2.png'),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 150.0, top: 22),
                                    ),
                                  ),
                                if (snapshot.data!['Gym_Image1'] != null)
                                  Container(
                                    margin: EdgeInsets.all(30),
                                    padding: EdgeInsets.symmetric(vertical: 40),
                                    height: 150,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            "$imageurl${snapshot.data!['Gym_Image1']}",
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 150.0, top: 22),
                                    ),
                                  )
                                else
                                  Container(
                                    margin: EdgeInsets.all(30),
                                    padding: EdgeInsets.symmetric(vertical: 40),
                                    height: 150,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage('images/person2.png'),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 150.0, top: 22),
                                    ),
                                  ),
                                if (snapshot.data!['Gym_Image2'] != null)
                                  Container(
                                    margin: EdgeInsets.all(30),
                                    padding: EdgeInsets.symmetric(vertical: 40),
                                    height: 150,
                                    width: 350,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "$imageurl${snapshot.data!['Gym_Image2']}",
                                            ),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color.fromARGB(
                                            255, 135, 129, 129)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 150.0, top: 22),
                                    ),
                                  )
                                else
                                  Container(
                                    margin: EdgeInsets.all(30),
                                    padding: EdgeInsets.symmetric(vertical: 40),
                                    height: 150,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              AssetImage('images/person2.png'),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 150.0, top: 22),
                                    ),
                                  ),
                                SizedBox(
                                  height: 30,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  );
                }),

            //الالات
            FutureBuilder(
                future: databaseHelper.getcexercisemachines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error'),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: AppColor.backgraoundcontainer,
                        borderRadius: BorderRadius.circular(25)),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          padding: EdgeInsets.only(bottom: 0),
                          margin: EdgeInsets.only(
                            top: 30,
                          ),
                          height: 120,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "  Exercise machines ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.fontprimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Text(
                                        "Exercise machines in the gym include variety of equipment designed to improve fitnees and buld muscle",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.fontsecColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 130),
                          height: 300,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin: EdgeInsets.all(30),
                                  height: 100,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    image: snapshot.data![i]['Machine_image'] !=
                                            null
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              "$imageurl${snapshot.data![i]['Machine_image']}",
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: AssetImage(
                                                'images/person2.png'), // default image
                                            fit: BoxFit.cover,
                                          ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }),
            // المدرب

            FutureBuilder(
                future: databaseHelper.getcoache(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error'),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: AppColor.backgraoundcontainer,
                        borderRadius: BorderRadius.circular(25)),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          padding: EdgeInsets.only(bottom: 0),
                          margin: EdgeInsets.only(
                            top: 40,
                          ),
                          height: 220,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "  Coaches ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.fontprimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        "The bodybuilding gym includes a team of highly qualified professional trainers, ensuring that you receive optimal guidance to achieve your sports goals.  Whether you're a beginner or an advanced athlete, our coaches are ready to support you every step of the way to fitness and strength.",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.fontsecColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 200, left: 20),
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Card(
                                    color: AppColor.backgraoundcard,
                                    shape: BeveledRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        if (snapshot.data?[i]['Coach_Image'] !=
                                            null)
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, left: 20, right: 200),
                                            child: CircleAvatar(
                                              maxRadius: 70,
                                              backgroundImage: NetworkImage(
                                                "$imageurl${snapshot.data?[i]['Coach_Image']}",
                                              ),
                                            ),
                                          )
                                        else
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, left: 20, right: 200),
                                            child: CircleAvatar(
                                              maxRadius: 70,
                                              backgroundImage: AssetImage(
                                                  "images/person2.png"),
                                            ),
                                          ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 155, left: 20, right: 20),
                                          child: Expanded(
                                            child: Text(
                                              "        Coache",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 190, left: 20, right: 20),
                                          child: Expanded(
                                            child: Text(
                                              snapshot.data?[i]['Coach_Name'],
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: AppColor.fontwhite),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }),
            // اخصائي التغذيه
            FutureBuilder(
                future: databaseHelper.getNutritionist(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error'),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: AppColor.backgraoundcontainer,
                        borderRadius: BorderRadius.circular(25)),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          padding: EdgeInsets.only(bottom: 0),
                          margin: EdgeInsets.only(
                            top: 40,
                          ),
                          height: 250,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "  Nutritionists ",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.fontprimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Text(
                                        "We have a nutritionist who provides specialized consultations to prepare balanced nutritional plans that suit the needs of each individual and uses the latest research to help you achieve your health goals, whether it is to lose weight, build muscle, or improve athletic performance.",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.fontsecColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 200, left: 20),
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data?.length ?? 0,
                              itemBuilder: (context, i) {
                                return Container(
                                  margin: EdgeInsets.all(10),
                                  child: Card(
                                    color: AppColor.backgraoundcard,
                                    shape: BeveledRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(
                                      children: [
                                        if (snapshot.data?[i]
                                                ['Nutritionist_Image'] !=
                                            null)
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, left: 20, right: 200),
                                            child: CircleAvatar(
                                              maxRadius: 70,
                                              backgroundImage: NetworkImage(
                                                "$imageurl${snapshot.data?[i]['Nutritionist_Image']}",
                                              ),
                                            ),
                                          )
                                        else
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, left: 20, right: 200),
                                            child: CircleAvatar(
                                              maxRadius: 70,
                                              backgroundImage: AssetImage(
                                                  "images/person2.png"),
                                            ),
                                          ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 155, left: 20, right: 20),
                                          child: Expanded(
                                            child: Text(
                                              "    Nutritionists",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: AppColor.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 190, left: 20, right: 20),
                                          child: Expanded(
                                            child: Text(
                                              snapshot.data?[i]
                                                  ['Nutritionist_Name'],
                                              style: TextStyle(
                                                  fontSize: 25,
                                                  color: AppColor.fontwhite),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  );
                }),
            FutureBuilder(
                future: databaseHelper.getDataGymInf(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error'),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: AppColor.backgraoundcontainer,
                        borderRadius: BorderRadius.circular(25)),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(),
                          padding: EdgeInsets.only(bottom: 0),
                          margin: EdgeInsets.only(
                            top: 20,
                          ),
                          height: 120,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.location_on),
                                    Text(
                                      " Location",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.fontprimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        snapshot.data!['Gym_Location'],
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.fontsecColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: MaterialButton(
                    //minWidth: 100,
                    onPressed: () {
                      Navigator.of(context).pushNamed("packages");
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: AppColor.botoum3,
                    child: Text(
                      "    Packages   ",
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                FutureBuilder(
                    future: databaseHelper.getbankaccount(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('error'),
                        );
                      }
                      return MaterialButton(
                        // minWidth: 100,
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext bc) {
                                return Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.all(5),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: AppColor.appbarcolor,
                                            child: Text(
                                              "Bank accounts : ",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  color: AppColor.fontwhite,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 50),
                                      child: ListView.builder(
                                          itemCount: snapshot.data?.length ?? 0,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ListTile(
                                                tileColor: AppColor
                                                    .backgraoundcontainer,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                title: Text(
                                                  snapshot.data?[i]
                                                      ['Bank_Name'],
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColor
                                                          .fontprimaryColor),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data?[i]
                                                          ['Account_Name'],
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                      ),
                                                    ),
                                                    Text(
                                                      snapshot.data![i]
                                                              ['Account_Number']
                                                          .toString(),
                                                    )
                                                  ],
                                                ),
                                                leading: CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        "images/gold1.jpg")),
                                              ),
                                            );
                                          }),
                                    )
                                  ],
                                );
                              });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        color: AppColor.botoum3,
                        child: Text(
                          "    More Info...   ",
                          style: TextStyle(color: AppColor.black, fontSize: 20),
                        ),
                      );
                    }),
              ],
            ),
          ],
        ));
  }
}
