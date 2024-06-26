import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class My_Order extends StatefulWidget {
  const My_Order({super.key});

  @override
  State<My_Order> createState() => _My_OrderState();
}

class _My_OrderState extends State<My_Order> {
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
          backgroundColor: const Color(0xFF27374D), title: Text("My Orders")),
      body: FutureBuilder(
          future: databaseHelper.getDataMemberOrder(memberId),
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, top: 25),
                              height: 600,
                              padding: const EdgeInsets.only(
                                  left: 15, right: 15, bottom: 20),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF526D82),
                                    borderRadius: const BorderRadius.only(
                                      // bottomLeft: Radius.circular(80.0),
                                      //bottomRight: Radius.circular(80.0),
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
                                  top: 50.0,
                                  bottom: 50,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 200,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  offset:
                                                      const Offset(-10.0, 10.0),
                                                  blurRadius: 20.0,
                                                  spreadRadius: 4.0)
                                            ],
                                          ),
                                          child: InstaImageViewer(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: (snapshot.data![i]
                                                          ['Image_of_Bond'] ==
                                                      null)
                                                  ? Image(
                                                      image: AssetImage(
                                                          'images/person2.png'))
                                                  : Image(
                                                      image: NetworkImage(
                                                          "$imageurl${snapshot.data![i]['Image_of_Bond']}")),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Type: ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[i]['Type']
                                                          .toString() ??
                                                      '',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text('Order_State: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[i]
                                                              ['Order_State']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text('Reject Reason: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[i]
                                                              ['Reject_reason']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text('Price: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[i]['Price']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text('Date_Order: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[i]
                                                              ['Date_Order']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text('Payment_Way: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[i]
                                                              ['Payment_Way']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text('Order_Kind: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[i]
                                                              ['Order_Kind']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text('Employee: ',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 17)),
                                              Expanded(
                                                child: Text(
                                                  snapshot.data?[i]
                                                              ['Employee_Name']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                  overflow: TextOverflow.clip,
                                                  maxLines: 17,
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
                            );
                          },
                        )))
              ],
            );
          }),
    );
  }
}
