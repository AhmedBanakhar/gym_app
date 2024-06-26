// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:mohamed/Controllers/databasehelper.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/coachs/showplancoache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeCoache extends StatefulWidget {
  const HomeCoache({super.key});

  @override
  State<HomeCoache> createState() => _HomeCoacheState();
}

class _HomeCoacheState extends State<HomeCoache> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  final TextEditingController textController = TextEditingController();

  _save(String account, String token) async {
    final prefs = await SharedPreferences.getInstance();

    final key1 = 'Account_Type';
    final value1 = account;
    prefs.setString(key1, value1);
    final key2 = 'token';
    final value2 = token;
    prefs.setString(key2, value2);
  }

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
  String coachpassword = '';
  String imageurl = '';
  String coachid = '';
  var futuresearch;

  _readCoachName() async {
    final result = await read();
    setState(() {
      coachName = result['Coach_Name'];
      coachEmail = result['Email'];
      coachpassword = result['Passsword'];
      coachid = result['id'];
      imageurl = databaseHelper.serverimage;
    });
  }

  @override
  void initState() {
    super.initState();
    _readCoachName();
    futuresearch = databaseHelper.getDataMemberserach('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    color: Color(0xff27374D),
                    child: Center(
                      child: Column(
                        children: [
                          FutureBuilder(
                              future: databaseHelper.getDataCoache(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text(
                                        'An error occurred: ${snapshot.error}'),
                                  );
                                }
                                if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Text('there is no data'),
                                  );
                                }

                                if ((snapshot.data!['Coach_Image'] != null)) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "$imageurl${snapshot.data!['Coach_Image']}"),
                                      radius: 40,
                                    ),
                                    title: Text(
                                      coachName,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      coachEmail,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                } else {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('images/person2.png'),
                                      radius: 40,
                                    ),
                                    title: Text(
                                      coachName,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      coachEmail,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20)),
                              MaterialButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.black)),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("myaccountcoache");
                                },
                                child: Container(
                                  child: Text(
                                    " Mange Account",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed("homepagecoache");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.playlist_add_check_outlined,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Fixed Plan"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('fixedplans');
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff27374D),
        title: Text(
          "HomeCoache",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Confirm Logout'),
                      content: const Text('Are you sure you want to Logout ?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Ignore'),
                          child: const Text('Ignore'),
                        ),
                        TextButton(
                          onPressed: () {
                            databaseHelper.logoutdata(coachEmail);
                            _save('out', 'out');
                            Navigator.pushNamedAndRemoveUntil(
                                context, 'login', (route) => false);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              })
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  futuresearch = databaseHelper.getDataMemberserach(value);
                });
              },
              decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.search),
                  suffixIconColor: Colors.black,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: AppColor.botoum1,
                      )),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black)),
                  fillColor: Colors.white,
                  filled: true,
                  label: const Text(
                    "Name",
                    style: TextStyle(
                        color: Color.fromARGB(255, 55, 53, 53), fontSize: 15),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: futuresearch,
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
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ShowPlanCoache(
                                      memberID: snapshot.data![i]['id'],
                                      member_Name: snapshot.data![i]
                                          ['Member_Name'],
                                    )));
                            // Navigator.of(context).pushNamed('fixedplan');
                          },
                          child: Container(
                              margin: const EdgeInsets.all(15),
                              padding: const EdgeInsets.all(10),
                              height: 100,
                              decoration: const BoxDecoration(
                                  color: AppColor.botoum3,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(25),
                                      topLeft: Radius.circular(25),
                                      bottomLeft: Radius.circular(25))),
                              child: Row(
                                children: [
                                  if ((snapshot.data![i]['Member_Image'] !=
                                      null))
                                    Container(
                                      height: 70,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "$imageurl${snapshot.data![i]['Member_Image']}"),
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
                                                fit: BoxFit.cover))),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20, top: 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            snapshot.data?[i]['Member_Name']
                                                    .toString() ??
                                                '',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppColor.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}
