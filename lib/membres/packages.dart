//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mohamed/login.dart';

class Packages extends StatefulWidget {
  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff27374D),
        title: const Text("Packages"),
      ),
      body: FutureBuilder(
          future: databaseHelper.getsusbscriptons(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('error'),
              );
            }

            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 280),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, i) {
                  return Card(
                      margin: const EdgeInsets.all(10),
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.grey[200],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      snapshot.data?[i]['Subscription_Type']
                                              .toString() ??
                                          '',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              )),
                          Text(
                            snapshot.data?[i]['Price'].toString() ?? '',
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
                          ),
                          Container(
                              margin: const EdgeInsets.all(2),
                              child: Row(
                                children: [
                                  Icon(Icons.turn_right),
                                  Text(
                                    snapshot.data?[i]['Days_of_Subscriptions']
                                            .toString() ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xfff79122),
                                    ),
                                  ),
                                  Text(
                                    "days",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                          Container(
                              margin: const EdgeInsets.all(2),
                              child: Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.turn_right),
                                    Text(
                                      snapshot.data?[i]['Days_of_suspensions']
                                              .toString() ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfff79122),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Suspensions days",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                              margin: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Icon(Icons.turn_right),
                                  Text(
                                    snapshot.data?[i]
                                                ['Number_of_free_suspensions']
                                            .toString() ??
                                        '',
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
                      ));
                });
          }),
    );
  }
}
