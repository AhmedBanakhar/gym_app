//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/coachs/checkmember.dart';
import 'package:mohamed/coachs/editplan.dart';
import 'package:mohamed/coachs/homepagecoache.dart';
import 'package:mohamed/coachs/myaccountcoache.dart';
import 'package:mohamed/coachs/showfixedplan.dart';
import 'package:mohamed/coachs/showfixedplans.dart';
import 'package:mohamed/coachs/showplancoache.dart';
import 'package:mohamed/coachs/updateAccountcoache.dart';
import 'package:mohamed/login.dart';
import 'package:mohamed/membres/buysub.dart';
import 'package:mohamed/membres/dietarysupplement.dart';
import 'package:mohamed/membres/ditespage.dart';
import 'package:mohamed/membres/firstpage.dart';
import 'package:mohamed/membres/foodrations.dart';
import 'package:mohamed/membres/homepage.dart';
import 'package:mohamed/membres/information.dart';
import 'package:mohamed/membres/myaccount.dart';
import 'package:mohamed/membres/mycheckspage.dart';
import 'package:mohamed/membres/myplanpage.dart';
import 'package:mohamed/membres/myorders.dart';
import 'package:mohamed/membres/packages.dart';
import 'package:mohamed/membres/subscription.dart';
import 'package:mohamed/membres/updateAccount.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Merriweather",
          appBarTheme: const AppBarTheme(backgroundColor: AppColor.botoum1)),
      home: const Login(),
      routes: {
        "login": (context) => const Login(),
        ////////////////////////////////////////////////member
        "homemembre": (context) => const HomeMembres(),
        "myplan": (context) => const MyPlane(),
        "dites": (context) => const Dites(),
        "mycheck": (context) => const MyChecks(),
        "information": (context) => const Information(),
        "packages": (context) => const Packages(),
        "myorders": (context) => const My_Order(),
        "firstpage": (context) => const Firstpage(),
        "myaccount": (context) => const MyAccount(),
        "updateAccount": (context) => const UpDateAccount(),
        "foodration": (context) => const FoodRation(),
        "subscription": (context) => const Subscription(),
        "buysub": (context) => Buysubscription(),
        "dietarysupplement": (context) => const DietarySupplement(),
        /////////////////////////////////////////////////coache
        "homepagecoache": (context) => const HomeCoache(),
        "myaccountcoache": (context) => const MyAccountCoache(),
        "updateAccountcoache": (context) => const UpDateAccountCoache(),
        "showplancoache": (context) => ShowPlanCoache(),
        "editplan": (context) => EditPlan(),
        "checkmember": (context) => CheckMember(),
        "fixedplan": (context) => ShowFixdPlan(),
        "fixedplans": (context) => const ShowFixedPlans(),
      },
    );
  }
}
