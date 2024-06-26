// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:mohamed/Controllers/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
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
      backgroundColor: const Color(0xFF27374D),
      body: profileView(),
    );
  }

  Widget profileView() {
    return FutureBuilder(
        future: databaseHelper.getDataMember(memberId),
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
                        Navigator.of(context).pushNamed("homemembre");
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
                        if ((snapshot.data!['Member_Image'] != null))
                          CircleAvatar(
                            radius: 70,
                            child: ClipOval(
                              child: Image.network(
                                  "$imageurl${snapshot.data!['Member_Image']}",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover),
                            ),
                          )
                        else
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
                                      .pushNamed("updateAccount");
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
                    memberName,
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
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(11, 2, 0, 25),
                                child: Container(
                                  height: 100,
                                  width: 170,
                                  // color: Color(0xffDDE6ED),
                                  // ignore: sort_child_properties_last
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(11.0),
                                          child: Text('Number of Suspension:',
                                              style: TextStyle(
                                                fontSize: 13.5,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      Text(
                                          snapshot.data?['Number_of_suspension']
                                                  .toString() ??
                                              'none',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),

                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xFF27374D)),
                                      color: const Color(0xFF27374D)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(11, 2, 0, 25),
                                child: Container(
                                  height: 100,
                                  width: 170,

                                  // ignore: sort_child_properties_last
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(11.0),
                                          child: Text(
                                            'Days of Suspension:',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                          snapshot.data?['Days_of_suspension']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),

                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xFF27374D)),
                                      color: const Color(0xFF27374D)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Subscription end date: ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: const Color(
                                                        0xFF27374D)),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[
                                                              'Subscription_end_date']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF27374D),
                                                  ),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
                                                ),
                                              ),
                                            ],
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Suspension date: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data?['Suspension_date']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF27374D)),
                                              overflow: TextOverflow.clip,
                                              maxLines: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Trainee Case: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data?['Trainee_Case']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF27374D)),
                                              overflow: TextOverflow.clip,
                                              maxLines: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Expanded(
                                  child: Container(
                                    height: 100,
                                    // ignore: sort_child_properties_last
                                    child: Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'Weekly Training Days: ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      const Color(0xFF27374D)),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            snapshot.data?[
                                                        'Weekly_Training_Days']
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                                color: const Color(0xFF27374D)),
                                            overflow: TextOverflow.clip,
                                            maxLines: 20,
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Member sex: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
                                          ),
                                          Text(
                                            snapshot.data?['Member_sex']
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                                color: const Color(0xFF27374D)),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Member Age: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
                                          ),
                                          Text(
                                            snapshot.data?['Member_Age']
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                                color: const Color(0xFF27374D)),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Identity Number: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
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
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Identity Type: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
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
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Account Type : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
                                          ),
                                          Text(
                                            snapshot.data?['Account_Type']
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                                color: const Color(0xFF27374D)),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Employee Name : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data?['Employee_Name']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF27374D)),
                                              overflow: TextOverflow.clip,
                                              maxLines: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Coach Name : ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data?['Coach_Name']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF27374D)),
                                              overflow: TextOverflow.clip,
                                              maxLines: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 25, 20, 4),
                                child: Container(
                                  height: 60,
                                  // ignore: sort_child_properties_last
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Nutritionist Name: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF27374D)),
                                          ),
                                          Expanded(
                                            child: Text(
                                              snapshot.data?[
                                                          'Nutritionist_Name']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF27374D)),
                                              overflow: TextOverflow.clip,
                                              maxLines: 17,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      child: Align(
                                          //alignment: Alignment.centerRight,
                                          child: Container(
                                        height: 70,
                                        width: 150,
                                        // ignore: sort_child_properties_last
                                        child: const Align(
                                          child: Text(
                                            'Suspension',
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
                                                bottomRight:
                                                    Radius.circular(30))),
                                      )),
                                      onTap: () {
                                        databaseHelper.eidtamemberpsuspinsion();
                                        setState(() {});
                                      },
                                    ),
                                    InkWell(
                                      child: Align(
                                          //alignment: Alignment.centerRight,
                                          child: Container(
                                        height: 70,
                                        width: 150,
                                        // ignore: sort_child_properties_last
                                        child: const Align(
                                          child: Text(
                                            'Unsuspension',
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
                                                bottomRight:
                                                    Radius.circular(30))),
                                      )),
                                      onTap: () {
                                        databaseHelper.amemberUnsuspinsion();
                                        setState(() {});
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
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
