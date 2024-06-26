// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buysubscription extends StatefulWidget {
  var suspension;
  var subscription;

  Buysubscription({super.key, this.subscription, this.suspension});

  @override
  State<Buysubscription> createState() => _BuysubscriptionState();
}

class _BuysubscriptionState extends State<Buysubscription> {
  ImagePicker picker = ImagePicker();
  File? ImageofBond;
  Future pickImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (PickedFile != null) {
        ImageofBond = File(PickedFile.path);
      }
    });
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
    print(widget.subscription);
    print(widget.suspension);
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
      print(widget.subscription);
      print(widget.suspension);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buy Subscription"),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.subscription == null)
                    Text(
                      widget.suspension['Suspension_Type'].toString(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  else
                    Text(
                      widget.subscription['Subscription_Type'].toString(),
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: 390,
                      child: Text(
                        " To Buy This packge Pleas Enter image of bond",
                        // textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: ImageofBond == null
                    ? Text("No selceted ")
                    : Container(
                        height: 350,
                        child: Image.file(File(ImageofBond!.path)),
                      )),
            SizedBox(
              height: 30,
            ),
            Positioned(
                child: InkWell(
              onTap: () {
                pickImage();
              },
              child: Container(
                height: 40,
                width: 40,
                child: const Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                ),
                decoration: const BoxDecoration(
                    color: AppColor.botoum2,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ),
            )),
            SizedBox(
              height: 10,
            ),
            MaterialButton(
              //minWidth: 100,
              onPressed: () {
                if (ImageofBond != null) {
                  if (widget.subscription == null) {
                    databaseHelper.addOrdermember(
                      widget.suspension['Suspension_Type'].toString(),
                      widget.suspension['Price'].toString(),
                      'Suspension',
                      ImageofBond!,
                    );
                  } else {
                    databaseHelper.addOrdermember(
                      widget.subscription['Subscription_Type'].toString(),
                      widget.subscription['Price'].toString(),
                      'Subscription',
                      ImageofBond!,
                    );
                  }
                  Navigator.of(context).pop();
                } else {
                  _ShowDialogg();
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: AppColor.botoum2,
              child: Text(
                "    send   ",
                style: TextStyle(
                  color: AppColor.fontwhite,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _ShowDialogg() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // ignore: prefer_const_constructors
            title: Text('Failed'),
            content: const Text('There is no Picture'),
            actions: <Widget>[
              // ignore: unnecessary_new
              new ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Close",
                ),
              )
            ],
          );
        });
  }
}
