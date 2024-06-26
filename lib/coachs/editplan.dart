// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mohamed/auth/appcolor.dart';
import 'package:mohamed/login.dart';

class EditPlan extends StatefulWidget {
  var Id_member;
  EditPlan({super.key, this.Id_member});

  @override
  State<EditPlan> createState() => _EditPlanState();
}

class _EditPlanState extends State<EditPlan> {
  //final bool _customIcon = false;
  List<String> Muscles = ['Abs', 'Chest', 'Arms', 'Legs', 'Back and Shoulders'];
  String? selected_Muscle = null;

  String imageurl = '';
  var futuresearch;
  int selectedplan = -1;
  int count = 0;
  List<int> plansID = [];

  List<TextEditingController> Reps = [];
  List<TextEditingController> Tours = [];
  List<TextEditingController> Rest_Min = [];
  List<TextEditingController> Rest_Sec = [];
  List<TextEditingController> Period_Min = [];
  List<TextEditingController> Period_Sec = [];
  List<TextEditingController> Weight = [];

  @override
  void initState() {
    super.initState();
    _readCoachName();
    futuresearch = databaseHelper.getExerciss('');
    print(futuresearch);
  }

  _readCoachName() async {
    setState(() {
      imageurl = databaseHelper.serverimage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.botoum4,
      appBar:
          AppBar(backgroundColor: Color(0xfff27374D), title: Text("Edit Plan")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: databaseHelper.getDataMembertrainingplanfromCoache(
                  widget.Id_member,
                ),
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
                  count = snapshot.data!.length;
                  Reps = List.generate(snapshot.data!.length,
                      (index) => TextEditingController());
                  Tours = List.generate(snapshot.data!.length,
                      (index) => TextEditingController());
                  Weight = List.generate(snapshot.data!.length,
                      (index) => TextEditingController());

                  Rest_Min = List.generate(snapshot.data!.length,
                      (index) => TextEditingController());
                  Rest_Sec = List.generate(snapshot.data!.length,
                      (index) => TextEditingController());
                  Period_Min = List.generate(snapshot.data!.length,
                      (index) => TextEditingController());
                  Period_Sec = List.generate(snapshot.data!.length,
                      (index) => TextEditingController());
                  plansID = List.generate(count, (index) => 0);

                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        plansID[i] = snapshot.data![i]['id'];
                        if (snapshot.data![i]['Number_of_times'] == null) {
                          Reps[i].text = '';
                        } else {
                          Reps[i].text =
                              snapshot.data![i]['Number_of_times'].toString();
                        }
                        if (snapshot.data![i]['Weight'] == null) {
                          Weight[i].text = '';
                        } else {
                          Weight[i].text =
                              snapshot.data![i]['Weight'].toString();
                        }

                        Tours[i].text =
                            snapshot.data![i]['Number_of_tours'].toString();

                        if (snapshot.data![i]['Training_rest'] != null) {
                          List<String> rest_spliter =
                              (snapshot.data![i]['Training_rest']).split(':');
                          Rest_Min[i].text = rest_spliter[1];
                          Rest_Sec[i].text = rest_spliter[2];
                        }

                        if (snapshot.data![i]['Time_period'] != null) {
                          List<String> period_spliter =
                              (snapshot.data![i]['Time_period']).split(':');
                          Period_Min[i].text = period_spliter[1];
                          Period_Sec[i].text = period_spliter[2];
                        }

                        return Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: AppColor.botoum2),
                                color: Colors.white),
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: ExpansionTile(
                              //backgroundColor: AppColor.botoum3,
                              title: Text(
                                snapshot.data?[i]['Exercise_Name'].toString() ??
                                    '',
                                style: TextStyle(fontSize: 20),
                              ),

                              leading: Image.network(
                                  "$imageurl${snapshot.data![i]['Exercise_Image']}",
                                  height: 150),
                              subtitle: Text(
                                snapshot.data?[i]['Muscle_name'].toString() ??
                                    '',
                                style: TextStyle(fontSize: 18),
                              ),

                              trailing: IconButton(
                                icon: Icon(Icons.more_vert),
                                onPressed: () {
                                  selectedplan = snapshot.data?[i]['id'];
                                  print('hi $selectedplan');

                                  _showbottom();
                                },
                              ),
                              children: <Widget>[
                                Form(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: 90,
                                              height: 60,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  // color:  AppColor.botoum2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: TextFormField(
                                                controller: Reps[i],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                    suffixIcon: Icon(Icons
                                                        .restart_alt_rounded),
                                                    suffixIconColor:
                                                        AppColor.botoum1,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColor
                                                                    .botoum3)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    label: Text(
                                                      "Reps",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 55, 53, 53),
                                                          fontSize: 17),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: 90,
                                              height: 60,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  // color:  AppColor.botoum2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: TextFormField(
                                                controller: Tours[i],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                    suffixIcon: Icon(
                                                        Icons.touch_app_sharp),
                                                    suffixIconColor:
                                                        AppColor.botoum1,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColor
                                                                    .botoum3)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    label: Text(
                                                      "Tours",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 55, 53, 53),
                                                          fontSize: 17),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: 90,
                                              height: 60,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  // color:  AppColor.botoum2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: TextFormField(
                                                controller: Rest_Min[i],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                    suffixIcon:
                                                        Icon(Icons.watch_later),
                                                    suffixIconColor:
                                                        AppColor.botoum1,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColor
                                                                    .botoum3)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    label: Text(
                                                      "Rest_Min",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 55, 53, 53),
                                                          fontSize: 16),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: 90,
                                              height: 60,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  // color:  AppColor.botoum2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: TextFormField(
                                                controller: Rest_Sec[i],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                    suffixIcon:
                                                        Icon(Icons.watch_later),
                                                    suffixIconColor:
                                                        AppColor.botoum1,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColor
                                                                    .botoum3)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    label: Text(
                                                      "Rest_Sec",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 55, 53, 53),
                                                          fontSize: 16),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: 90,
                                              height: 60,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  // color:  AppColor.botoum2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: TextFormField(
                                                controller: Period_Min[i],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                    suffixIcon:
                                                        Icon(Icons.watch_later),
                                                    suffixIconColor:
                                                        AppColor.botoum1,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColor
                                                                    .botoum3)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    label: Text(
                                                      "Period_Min",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 55, 53, 53),
                                                          fontSize: 13),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              width: 90,
                                              height: 60,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  // color:  AppColor.botoum2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: TextFormField(
                                                controller: Period_Sec[i],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                    suffixIcon:
                                                        Icon(Icons.watch_later),
                                                    suffixIconColor:
                                                        AppColor.botoum1,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColor
                                                                    .botoum3)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    label: Text(
                                                      "Period_Sec",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 55, 53, 53),
                                                          fontSize: 13),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 90,
                                              height: 60,
                                              margin: EdgeInsets.all(10),
                                              padding: EdgeInsets.all(10),
                                              decoration: const BoxDecoration(
                                                  // color:  AppColor.botoum2,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                              child: TextFormField(
                                                controller: Weight[i],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                decoration: InputDecoration(
                                                    suffixIcon: Icon(Icons
                                                        .monitor_weight_outlined),
                                                    suffixIconColor:
                                                        AppColor.botoum1,
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: AppColor
                                                                    .botoum3)),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                20),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black)),
                                                    fillColor: Colors.white,
                                                    filled: true,
                                                    label: Text(
                                                      "Weight",
                                                      style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255, 55, 53, 53),
                                                          fontSize: 20),
                                                    ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      MaterialButton(
                                        onPressed: () {
                                          print('object');
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Confirm Logout'),
                                                content: const Text(
                                                    'Are you sure you want to Delete ?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            context, 'Ignore'),
                                                    child: const Text('Ignore'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      databaseHelper.deletePlan(
                                                          snapshot.data![i]
                                                              ['id']);

                                                      setState(() {});
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        color: AppColor.botoum1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: AppColor.botoum4,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  List<dynamic> data = [];
                  print(count);
                  for (int i = 0; i < count; i++) {
                    data.add({
                      "id": plansID[i],
                      "Weight": Weight[i].text,
                      "Number_of_tours": Tours[i].text,
                      "Number_of_times": Reps[i].text,
                      "Training_rest":
                          "00:${Rest_Min[i].text}:${Rest_Sec[i].text}",
                      "Time_period":
                          "00:${Period_Min[i].text}:${Period_Sec[i].text}"
                    });
                    databaseHelper.eidtpulkdatatrainingplan(data);
                  }

                  databaseHelper.eidtpulkdatatrainingplan(data);
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: AppColor.botoum1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: AppColor.botoum4,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  selectedplan = -1;
                  _showbottom();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                color: AppColor.botoum1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: AppColor.botoum4,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showbottom() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 600,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  margin:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  child: DropdownButtonFormField<String>(
                    onSaved: (newValue) {
                      setState(() {
                        futuresearch = databaseHelper.getExerciss(newValue!);
                      });
                      Navigator.pop(context);
                    },
                    iconEnabledColor: Color(0xfff79122),
                    decoration: InputDecoration(
                        label: Container(
                          child: const Text(
                            maxLines: 1,
                            "Target Muscle",
                            style: TextStyle(
                              color: Color.fromARGB(255, 55, 53, 53),
                            ),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )),
                    value: selected_Muscle,
                    items: Muscles.map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          maxLines: 1,
                          item,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ))).toList(),
                    onChanged: (item) {
                      setState(() {
                        selected_Muscle = item;
                        futuresearch =
                            databaseHelper.getExerciss(selected_Muscle!);
                      });
                      Navigator.pop(context);
                      _showbottom();
                    },

                    hint: const Text(
                      maxLines: 1,
                      "Choose Muscle",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    // iconEnabledColor: Color(0xfff79122),
                    iconSize: 15.0,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<dynamic>>(
                      future: futuresearch,
                      builder: (context, snapshot) {
                        print(snapshot.data);
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('error'),
                          );
                        }
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, i) {
                              return InkWell(
                                onTap: () {
                                  print('this $selectedplan');
                                  if (selectedplan != -1) {
                                    databaseHelper.eidtdatatrainingplan(
                                        selectedplan, snapshot.data?[i]['id']);
                                    selectedplan = -1;
                                    setState(() {});
                                  } else {
                                    databaseHelper.adddatatrainingplan(
                                        widget.Id_member,
                                        snapshot.data?[i]['id'],
                                        snapshot.data?[i]['Target_muscle']);
                                    setState(() {});
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    margin: EdgeInsets.all(15),
                                    padding: EdgeInsets.all(10),
                                    height: MediaQuery.of(context).size.height *
                                        0.16,
                                    decoration: BoxDecoration(
                                        color: AppColor.botoum3,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(25),
                                            topLeft: Radius.circular(25),
                                            bottomLeft: Radius.circular(25))),
                                    child: Row(
                                      children: [
                                        if ((snapshot.data![i]
                                                ['Exercise_Image'] !=
                                            null))
                                          Container(
                                            height: 70,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      "$imageurl${snapshot.data![i]['Exercise_Image']}",
                                                    ),
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
                                                      "images/dum.gif",
                                                    ),
                                                    fit: BoxFit.cover)),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 200,
                                                child: Expanded(
                                                  child: Text(
                                                    snapshot.data![i]
                                                            ['Exercise_Name']
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                    overflow: TextOverflow.clip,
                                                    maxLines: 15,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  snapshot.data?[i]
                                                              ['Target_muscle']
                                                          .toString() ??
                                                      '',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          AppColor.fontwhite),
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
        });
  }
}
