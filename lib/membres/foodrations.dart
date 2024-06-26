import 'package:flutter/material.dart';
import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FoodRation extends StatefulWidget {
  const FoodRation({super.key});

  @override
  State<FoodRation> createState() => _FoodRationState();
}

class _FoodRationState extends State<FoodRation> {
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
          title: Text("Food Rations")),
      body: FutureBuilder(
          future: databaseHelper.getDataMemberfoodRation(memberId),
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
                        child: ListView(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              //height: 200,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              child: Container(
                                height: 100,
                                //width: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF526D82),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(80.0),
                                      bottomRight: Radius.circular(80.0),
                                      topLeft: Radius.circular(80.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 116, 112, 112)
                                                  .withOpacity(0.3),
                                          offset: const Offset(-10.0, 10.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 4.0)
                                    ]),
                                padding: const EdgeInsets.only(
                                  left: 32,
                                  top: 20.0,
                                  bottom: 20,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              offset: const Offset(-10.0, 10.0),
                                              blurRadius: 20.0,
                                              spreadRadius: 4.0)
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                            image: AssetImage(
                                                'images/starch.png')),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            //Text("Type:", style: TextStyle(color: Colors.white, fontSize: 17)),
                                            Text(
                                              'Starches:',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                            Text(
                                              snapshot.data?[0]['Starches']
                                                      .toString() ??
                                                  '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10, top: 5),
                              //height: 200,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              child: Container(
                                height: 100,
                                //width: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF526D82),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(80.0),
                                      bottomRight: Radius.circular(80.0),
                                      topLeft: Radius.circular(80.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 116, 112, 112)
                                                  .withOpacity(0.3),
                                          offset: const Offset(-10.0, 10.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 4.0)
                                    ]),
                                padding: const EdgeInsets.only(
                                  left: 32,
                                  top: 20.0,
                                  bottom: 20,
                                ),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              offset: const Offset(-10.0, 10.0),
                                              blurRadius: 20.0,
                                              spreadRadius: 4.0)
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                            image: AssetImage(
                                                'images/vegetable.png')),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Vegetable:',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                            Text(
                                              snapshot.data?[0]['Vegetable']
                                                      .toString() ??
                                                  '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10, top: 5),
                              //height: 200,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              child: Container(
                                height: 100,
                                //width: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF526D82),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(80.0),
                                      bottomRight: Radius.circular(80.0),
                                      topLeft: Radius.circular(80.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 116, 112, 112)
                                                  .withOpacity(0.3),
                                          offset: const Offset(-10.0, 10.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 4.0)
                                    ]),
                                padding: const EdgeInsets.only(
                                  left: 32,
                                  top: 20.0,
                                  bottom: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              offset: const Offset(-10.0, 10.0),
                                              blurRadius: 20.0,
                                              spreadRadius: 4.0)
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                            image:
                                                AssetImage('images/fruit.png')),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Fruit:',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                            Text(
                                              snapshot.data?[0]['Fruit']
                                                      .toString() ??
                                                  '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10, top: 5),
                              //height: 200,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              child: Container(
                                height: 100,
                                //width: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF526D82),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(80.0),
                                      bottomRight: Radius.circular(80.0),
                                      topLeft: Radius.circular(80.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 116, 112, 112)
                                                  .withOpacity(0.3),
                                          offset: const Offset(-10.0, 10.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 4.0)
                                    ]),
                                padding: const EdgeInsets.only(
                                  left: 32,
                                  top: 20.0,
                                  bottom: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              offset: const Offset(-10.0, 10.0),
                                              blurRadius: 20.0,
                                              spreadRadius: 4.0)
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                            image:
                                                AssetImage('images/dairy.png')),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Dairy:',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                            Text(
                                              snapshot.data?[0]['Dairy']
                                                      .toString() ??
                                                  '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10, top: 5),
                              //height: 200,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              child: Container(
                                height: 100,
                                //width: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF526D82),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(80.0),
                                      bottomRight: Radius.circular(80.0),
                                      topLeft: Radius.circular(80.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 116, 112, 112)
                                                  .withOpacity(0.3),
                                          offset: const Offset(-10.0, 10.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 4.0)
                                    ]),
                                padding: const EdgeInsets.only(
                                  left: 32,
                                  top: 20.0,
                                  bottom: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              offset: const Offset(-10.0, 10.0),
                                              blurRadius: 20.0,
                                              spreadRadius: 4.0)
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                            image:
                                                AssetImage('images/meat.png')),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Meat:',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                            Text(
                                              snapshot.data?[0]['Meat']
                                                      .toString() ??
                                                  '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10, top: 5),
                              //height: 200,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 10),
                              child: Container(
                                height: 100,
                                //width: 150,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF526D82),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(80.0),
                                      bottomRight: Radius.circular(80.0),
                                      topLeft: Radius.circular(80.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Color.fromARGB(255, 116, 112, 112)
                                                  .withOpacity(0.3),
                                          offset: const Offset(-10.0, 10.0),
                                          blurRadius: 20.0,
                                          spreadRadius: 4.0)
                                    ]),
                                padding: const EdgeInsets.only(
                                  left: 32,
                                  top: 20.0,
                                  bottom: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              offset: const Offset(-10.0, 10.0),
                                              blurRadius: 20.0,
                                              spreadRadius: 4.0)
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image(
                                            image:
                                                AssetImage('images/water.png')),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: [
                                            Text(
                                              'Cup of water:',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
                                            ),
                                            Text(
                                              snapshot.data?[0]['Cup_of_water']
                                                      .toString() ??
                                                  '',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                              overflow: TextOverflow.clip,
                                              maxLines: 10,
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
                        )))
              ],
            );
          }),
    );
  }
}
