import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/login.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Information")),
      body: ListView(children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.account_balance),
              SizedBox(
                width: 10,
              ),
              Text(
                " Bank accounts",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColor.fontprimaryColor),
              ),
            ],
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
              return Container(
                padding: EdgeInsets.all(8),
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: AppColor.backgraoundcontainer,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(children: [
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                  backgroundImage:
                                      AssetImage("images/gold1.jpg")),
                              Text(
                                snapshot.data?[i]['Bank_Name'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.fontprimaryColor),
                              ),
                              Text(
                                snapshot.data?[i]['Account_Name'],
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                snapshot.data![i]['Account_Number'].toString(),
                              )
                            ],
                          )
                        ]),
                      );
                    }),
              );
            }),
        SizedBox(
          height: 20,
        ),
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
                decoration: BoxDecoration(),
                padding: EdgeInsets.only(bottom: 0),
                margin: EdgeInsets.only(
                  top: 20,
                ),
                height: 120,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10),
                      child: Row(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.social_distance),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              " Phone Number : ",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.fontprimaryColor),
                            ),
                            Text(
                              snapshot.data!['Gym_Phone'].toString(),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.fontprimaryColor),
                            ),
                          ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.location_on),
                          Text(
                            "   Location :",
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
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              snapshot.data!['Gym_Location'],
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                // color: AppColor.fontsecColor
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ]),
    );
  }
}
