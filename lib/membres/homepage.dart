// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mohamed/Controllers/databasehelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMembres extends StatefulWidget {
  const HomeMembres({super.key});

  @override
  State<HomeMembres> createState() => _HomeMembresState();
}

class _HomeMembresState extends State<HomeMembres> {
  DatabaseHelper databaseHelper = DatabaseHelper();

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
    });
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
                              future: databaseHelper.getDataMember(memberId),
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

                                if ((snapshot.data!['Member_Image'] != null)) {
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "$imageurl${snapshot.data!['Member_Image']}"),
                                      radius: 40,
                                    ),
                                    title: Text(
                                      memberName,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      memberEmail,
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
                                      memberName,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                      memberEmail,
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
                                  Navigator.of(context).pushNamed("myaccount");
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
                  // Navigator.of(context).pushReplacementNamed("homemembre");
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('homemembre');
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.apps,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Diets"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("dites");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.fastfood_sharp,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Dietary Supplement"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("dietarysupplement");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.food_bank_outlined,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Food Rations"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("foodration");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.menu,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Subscription and Suspensions"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("subscription");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.article,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Order"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("myorders");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.place,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Plan"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("myplan");
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.ac_unit,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text("Information"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("information");
                },
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff27374D),
        title: const Text(
          "HomeMember",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
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
                            databaseHelper.logoutdata(memberEmail);
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

                // Navigator.of(context).pushReplacementNamed('login');
              })
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("myplan");
            },
            child: Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.symmetric(vertical: 0),
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "images/plan.jpg",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff9DB2BF),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 200.0, bottom: 20),
                child: Text(
                  "Plan",
                  style: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("dites");
            },
            child: Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.symmetric(vertical: 40),
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "images/dites.jpg",
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20),
                color: Color(0xff9DB2BF),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 200.0),
                child: Text(
                  "Diets",
                  style: TextStyle(fontSize: 50, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed("mycheck");
            },
            child: Container(
              margin: EdgeInsets.all(30),
              padding: EdgeInsets.symmetric(vertical: 40),
              height: 150,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/cheek.jpg",
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 135, 129, 129)),
              child: Padding(
                padding: const EdgeInsets.only(left: 150.0, top: 22),
                child: Text(
                  "Check",
                  style: TextStyle(fontSize: 50, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
