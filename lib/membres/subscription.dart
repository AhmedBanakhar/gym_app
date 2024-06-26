import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/login.dart';
import 'package:mohamed/membres/buysub.dart';

class Subscription extends StatefulWidget {
  const Subscription({super.key});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  GlobalKey name = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Subscription And Suspension"),
        ),
        body: ListView(children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  " Subscriptions ",
                  style: TextStyle(
                      color: AppColor.fontprimaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4, right: 5, left: 20),
            height: 300,
            child: FutureBuilder(
                future: databaseHelper.getDatsusbscriptons(),
                builder: (context, snapshot) {
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
                  return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Buysubscription(
                                        subscription: snapshot.data![i],
                                      )));
                            },
                            child: Container(
                                //margin: EdgeInsets.all(30),
                                padding: EdgeInsets.all(10),
                                height: 90,
                                width: 230,
                                decoration: BoxDecoration(
                                  color: AppColor.botoum4,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(2),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                snapshot.data?[i][
                                                            'Subscription_Type']
                                                        .toString() ??
                                                    '',
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data?[i]['Price']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xfff79122),
                                          ),
                                        ),
                                        Text(
                                          ' SAR',
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.all(2),
                                        child: Row(
                                          children: [
                                            Icon(Icons.turn_right),
                                            Text(
                                              snapshot.data?[i][
                                                          'Days_of_Subscriptions']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xfff79122),
                                              ),
                                            ),
                                            Text(
                                              " days",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.all(2),
                                        child: Row(
                                          children: [
                                            Icon(Icons.turn_right),
                                            Text(
                                              snapshot.data?[i][
                                                          'Days_of_suspensions']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xfff79122),
                                              ),
                                            ),
                                            Text(
                                              " Suspension days",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.turn_right),
                                            Text(
                                              snapshot.data?[i][
                                                          'Number_of_free_suspensions']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xfff79122)),
                                            ),
                                            Text(
                                              " Suspensions",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  ],
                                )),
                          ),
                        );
                      });
                }),
          ),
          // التوقيفات
          Container(
            margin: EdgeInsets.only(top: 40, left: 10, bottom: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  " Suspensions ",
                  style: TextStyle(
                      color: AppColor.fontprimaryColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4, right: 5, left: 20, bottom: 20),
            height: 300,
            child: FutureBuilder(
                future: databaseHelper.getDatsuspensions(),
                builder: (context, snapshot) {
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
                  return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20, left: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      Buysubscription(
                                        suspension: snapshot.data![i],
                                      )));
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                height: 90,
                                width: 230,
                                decoration: BoxDecoration(
                                  color: AppColor.botoum4,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 200,
                                              child: Text(
                                                snapshot.data?[i]
                                                            ['Suspension_Type']
                                                        .toString() ??
                                                    '',
                                                maxLines: 3,
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        )),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data?[i]['Price']
                                                  .toString() ??
                                              '',
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xfff79122),
                                          ),
                                        ),
                                        Text(
                                          ' SAR',
                                          style: TextStyle(
                                              fontSize: 27,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                    Container(
                                        margin: EdgeInsets.all(2),
                                        child: Row(
                                          children: [
                                            Icon(Icons.turn_right),
                                            Text(
                                              snapshot.data?[i]
                                                          ['Days_of_suspension']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xfff79122),
                                              ),
                                            ),
                                            Text(
                                              " days",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.all(2),
                                        child: Row(
                                          children: [
                                            Icon(Icons.turn_right),
                                            Text(
                                              snapshot.data?[i][
                                                          'Number_of_suspensions']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xfff79122),
                                              ),
                                            ),
                                            Text(
                                              " Suspension days",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Row(
                                          children: [
                                            Icon(Icons.turn_right),
                                            Text(
                                              "2 ",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xfff79122)),
                                            ),
                                            Text(
                                              "Suspensions",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  ],
                                )),
                          ),
                        );
                      });
                }),
          ),
        ]));
  }
}
