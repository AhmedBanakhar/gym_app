// ignore_for_file: unnecessary_string_interpolations, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, prefer_const_declarations, unnecessary_brace_in_string_interps, dead_code, unused_field, prefer_final_fields, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  // static String serverUrl = "http://10.0.2.2:8000/api/L";
  // static String serverURL = "http://10.0.2.2:8000/api/v";
  static String serverUrl = "http://192.168.28.69:8000/api/L";
  static String serverURL = "http://192.168.28.69:8000/api/v";
  String serverimage = "http://192.168.28.69:8000/storage/";
  // static String serverUrl = "http://192.168.8.177:8000/api/L";
  // static String serverURL = "http://192.168.8.177:8000/api/v";
  // String serverimage = "http://192.168.8.177:8000/storage/";
  var status;
  var login;
  var datetime = DateTime.now();
  var id;
  var account;
  var value, value1, value2, value3, value4, value5, value6;
  var emaill,
      passsword,
      token,
      name1,
      name2,
      value7,
      value8,
      imagecoache,
      imagemember,
      water,
      datawater;

  Future<void> logindata(
      String email, String password, BuildContext context) async {
    try {
      var myUrl = Uri.parse("$serverUrl/accounts/login");

      final response = await http.post(myUrl, headers: {
        "Accept": "application/json",
      }, body: {
        "Email": "$email",
        "Passsword": "$password"
      });

      status = response.body.contains('message');
      id = json.decode(response.body);
      account = json.decode(response.body);
      token = json.decode(response.body);
      emaill = json.decode(response.body);
      passsword = json.decode(response.body);
      name1 = json.decode(response.body) ?? 0;
      name2 = json.decode(response.body) ?? 0;
      imagemember = json.decode(response.body) ?? 0;
      imagecoache = json.decode(response.body) ?? 0;
      //passsword= json.decode(response.body);

      if (status) {
        print('Login :${id['message']}');
      } else {
        print("Response body :${response.statusCode}");

        print("id :${id['id']}");

        print("Account_Type :${account['Account_Type']}");

        print("Emaill :${emaill['Email']}");

        print("Passsword :${passsword['Passsword']}");

        print("Token :${token['token']}");
        print("imageMember :${imagemember['Member_Image']}");
        print("imageCoache :${imagecoache['Coach_Image']}");

        print("Name :${name1['Coach_Name']}");
        print("Name :${name2['Member_Name']}");

        Map mapValue;
        mapValue = json.decode(response.body);

        print('Login : ${mapValue.values.toString()}');

        _save(
          id['id'].toString(),
          account['Account_Type'].toString(),
          token['token'].toString(),
          emaill['Email'].toString(),
          passsword['Passsword'].toString(),
          name1['Coach_Name'].toString(),
          name2['Member_Name'].toString(),
          imagemember['Member_Image'].toString(),
          imagecoache['Coach_Image'].toString(),
        );
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
        final key7 = 'Member_Image';
        final value7 = prefs.get(key7) ?? 0;
        final key8 = 'Coach_Image';
        final value8 = prefs.get(key8) ?? 0;
        print(
            'Info:$value,$value1,$value2,$value3,$value4,$value5,$value6,$imagecoache,$imagemember');
      }
      // ignore: unused_catch_clause
    }
    // ignore: unused_element

    catch (e) {
      status = 'error';
      print('Message:$e');

      print("$e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed'),
            content: Text("connection error"),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );
      // ignore: unused_element
    }
  }

  Future<void> logoutdata(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/accounts/logout");
    print('token:$value2');
    final response = await http.post(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    }, body: {
      "Email": "$email",
    });
    token = json.decode(response.body);
    print('$email,$value2');
    status = response.body.contains('message');
    if (status) {
      print('Logout :${token['message']}');
    } else {
      print("Response body :${response.statusCode}");
      Map mapValue;
      mapValue = json.decode(response.body);

      print('Logout : ${mapValue.values.toString()}');
    }
  }

  Future<Map<String, dynamic>> getDataMember($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverURL/gym_members/$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberserach(String membername) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print(membername);

    var myUrl = Uri.parse(
        "$serverURL/gym_members?Member_Name[like]=%$membername%&Coach_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);

      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getMemberConnectedToCoache() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverURL/gym_members?Coach_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<Map<String, dynamic>> getDataCoache() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    // print('token:$value,$value2');

    var myUrl = Uri.parse("$serverURL/coaches/$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      // print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      // print(json);
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<void> eidtdatamemberpassword(String id, String Passswordmember) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/gym_members/$id");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Authorization'] = 'Bearer $value2';
    request.fields['_method'] = 'PUT';
    request.fields['Passsword'] = Passswordmember;
    // request.files
    //     .add(await http.MultipartFile.fromPath('Member_Image', imagee.path));
    final response = await request.send();
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      // Map mapValue;
      // mapValue = json.decode(response);
      // print('Eidt : ${mapValue.values.toString()}');
    }
  }

  Future<void> eidtdatamemberimage(String id, File imagee) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/gym_members/$id");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Authorization'] = 'Bearer $value2';
    request.fields['_method'] = 'PUT';
    // request.fields['Passsword'] = Passswordmember;
    request.files
        .add(await http.MultipartFile.fromPath('Member_Image', imagee.path));
    final response = await request.send();
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      // Map mapValue;
      // mapValue = json.decode(response);
      // print('Eidt : ${mapValue.values.toString()}');
    }
  }

  Future<void> eidtdataCoachPassword(String id, String Passswordcoach) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/coaches/$value");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Authorization'] = 'Bearer $value2';
    request.fields['_method'] = 'PUT';
    request.fields['Passsword'] = Passswordcoach;

    final response = await request.send();
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      // Map mapValue;
      // mapValue = json.decode(response);
      // print('Eidt : ${mapValue.values.toString()}');
    }
  }

  Future<void> eidtdatatrainingplan(int id, int exrsiseId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/training_plans/$id");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Authorization'] = 'Bearer $value2';
    request.fields['_method'] = 'PUT';
    request.fields['Exercise_ID'] = '$exrsiseId';

    final response = await request.send();
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      // Map mapValue;
      // mapValue = json.decode(response);
      // print('Eidt : ${mapValue.values.toString()}');
    }
  }

  Future<void> eidtpulkdatatrainingplan(var plans) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/training_plans/bulkupdate");
    print('token:$value2');
    print(plans);
    String jsonData = jsonEncode(plans);
    final response = await http.post(myUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $value2'
        },
        body: jsonData);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
    } else {
      //throw " ";
    }
    // Map mapValue;
    // mapValue = json.decode(response);
    // print('Eidt : ${mapValue.values.toString()}');
  }

  Future<void> Addpulkdatatrainingplan(var plans) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/training_plans/bulkstore");
    print('token:$value2');
    print(plans);
    String jsonData = jsonEncode(plans);
    final response = await http.post(myUrl,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $value2'
        },
        body: jsonData);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
    } else {
      print(response.body);
    }
    // Map mapValue;
    // mapValue = json.decode(response);
    // print('Eidt : ${mapValue.values.toString()}');
  }

  Future<void> adddatatrainingplan(
      int memberId, int exrsiseId, String muscle) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/training_plans");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Authorization'] = 'Bearer $value2';
    // request.fields['_method'] = 'POST';
    request.fields['Exercise_ID'] = '$exrsiseId';
    request.fields['Member_ID'] = '$memberId';
    request.fields['Coach_ID'] = '$value';
    request.fields['Muscle_name'] = '$muscle';
    request.fields['Training_rest'] = '00:00:30';
    request.fields['Number_of_tours'] = '1';

    final response = await request.send();
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      // Map mapValue;
      // mapValue = json.decode(response);
      // print('Eidt : ${mapValue.values.toString()}');
    }
  }

  Future<void> eidtdataCoachimage(String id, File imagee) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/coaches/$value");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Authorization'] = 'Bearer $value2';
    request.fields['_method'] = 'PUT';
    // request.fields['Passsword'] = Passswordcoach;
    request.files
        .add(await http.MultipartFile.fromPath('Coach_Image', imagee.path));
    final response = await request.send();
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      // Map mapValue;
      // mapValue = json.decode(response);
      // print('Eidt : ${mapValue.values.toString()}');
    }
  }

  Future<void> addOrdermember(
    String type,
    String price,
    String orderkid,
    File imagee,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    var myUrl = Uri.parse("$serverURL/purchase_orders");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Accept'] = "application/json";
    request.headers['Authorization'] = 'Bearer $value2';
    request.fields['Type'] = '$type';
    request.fields['Price'] = '$price';
    request.fields['Order_Kind'] = '$orderkid';
    request.fields['Payment_Way'] = 'Bond';
    request.files
        .add(await http.MultipartFile.fromPath('Image_of_Bond', imagee.path));
    request.fields['Order_State'] = 'Waiting';
    request.fields['Date_Order'] = '$datetime';
    request.fields['Employee_ID'] = ' ';
    request.fields['Member_ID'] = '$value';

    final response = await request.send();
    final statusCode = response.statusCode;
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((event) {
      print(event);
    });
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      print(response.statusCode);
      response.stream.transform(utf8.decoder).listen((event) {
        print(event);
      });
    }
  }

  Future<List<dynamic>> getDataMembertrainingplan() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverURL/training_plans?Member_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMembertrainingplanfromCoache(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/training_plans?Member_ID[eq]=$id");
    print("$serverURL/training_plans?Member_ID[eq]=$value");

    var myUrl = Uri.parse(
        "$serverURL/training_plans?Member_ID[eq]=$id&Coach_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberExaminations($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverURL/examinations?Member_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberExaminationsforCoache(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverURL/examinations?Member_ID[eq]=$id");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberfoodRation($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    print("$serverURL/food_rations/$id");
    var myUrl = Uri.parse("$serverURL/food_rations?Member_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberDietarySupplement() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    print("$serverURL/food_rations/$id");
    var myUrl =
        Uri.parse("$serverURL/dietary_supplements?Member_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberDiteSat($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl =
        Uri.parse("$serverURL/diets?Member_ID[eq]=$value&Day[eq]=Saturday");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberDiteSun($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl =
        Uri.parse("$serverURL/diets?Member_ID[eq]=$value&Day[eq]=Sunday");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberDiteMon($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl =
        Uri.parse("$serverURL/diets?Member_ID[eq]=$value&Day[eq]=Monday");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberDiteTue($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl =
        Uri.parse("$serverURL/diets?Member_ID[eq]=$value&Day[eq]=Tuesday");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberDiteWed($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl =
        Uri.parse("$serverURL/diets?Member_ID[eq]=$value&Day[eq]=Wednesday");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberDiteThu($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl =
        Uri.parse("$serverURL/diets?Member_ID[eq]=$value&Day[eq]=Thursday");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberDiteFri($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl =
        Uri.parse("$serverURL/diets?Member_ID[eq]=$value&Day[eq]=Friday");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDataMemberOrder($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl = Uri.parse("$serverURL/purchase_orders?Member_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDatsusbscriptons() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl = Uri.parse("$serverURL/subscriptions");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getsusbscriptons() async {
    var myUrl = Uri.parse("$serverUrl/subscriptions");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDiteMember($id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverURL/diets?Member_ID[eq]=$value");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getDatsuspensions() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');
    print("$serverURL/food_rations/$value");
    var myUrl = Uri.parse("$serverURL/suspensions");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<Map<String, dynamic>> getDataGymInf() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverUrl/gym_info/1");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<Map<String, dynamic>> getDataExeriseMachine() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverURL/exercise_machines");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getcoache() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverUrl/coaches");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getcexercisemachines() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl = Uri.parse("$serverUrl/exercise_machines");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      //'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getNutritionist() async {
    var myUrl = Uri.parse("$serverUrl/nutritionists");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getbankaccount() async {
    var myUrl = Uri.parse("$serverUrl/bank_accounts");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // 'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<void> eidtnotMember(String note, int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'id';
      final value = prefs.get(key) ?? 0;
      final key2 = 'token';
      final value2 = prefs.get(key2) ?? 0;
      print(note);

      print('token:$value,$value2');
      print("$serverURL/training_plans/$value");
      var myUrl = Uri.parse("$serverURL/training_plans/$id");
      print('token:$note,$value2');
      final response = await http.put(myUrl, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $value2',
      }, body: {
        "Member_Note": "$note",
      });

      if (response.statusCode == 200) {
        // print('Login :${id['message']}');
      } else {
        print("Response body :${response.statusCode}");

        Map mapValue;
        mapValue = json.decode(response.body);

        print('Login : ${mapValue.values.toString()}');
      }
      // ignore: unused_catch_clause
    } catch (e) {
      // ignore: unused_element
      ShowDialogg(BuildContext context) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Failed'),
              content: Text('There is no note'),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<List<dynamic>> getExerciss(String exercisename) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl =
        Uri.parse("$serverURL/exercises?Target_muscle[eq]=$exercisename");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<List<dynamic>> getfixdpaln(String planType) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    print('token:$value,$value2');

    var myUrl =
        Uri.parse("$serverURL/fixedtraining_plans?Plan_type[eq]=$planType");

    http.Response response = await http.get(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    if (response.statusCode == 200) {
      print('hhhhhhhhhhhhhhhhh:$id,$value');
      var json = jsonDecode(response.body);
      print(json);
      if (json['data'] == null) {
        return json['data'];
      }
      return json['data'];
    } else {
      throw Exception('error');
    }
  }

  Future<Map<String, dynamic>> deletePlan(int planId) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;

    var myUrl = Uri.parse("$serverURL/training_plans/$planId");

    http.Response response = await http.delete(myUrl, headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $value2',
    });
    final data = json.decode(response.body);

    return data['data'];

    // if(response.statusCode==200)
    // {
    //      final data =json.decode(response.body);
    //      print(data);
    //      return data['data'];
    // }else{
    //   throw " ";
    // }
  }

  Future<void> eidtamemberpsuspinsion() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/gym_members/$value");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Authorization'] = 'Bearer $value2';
    request.fields['_method'] = 'PUT';
    request.fields['Suspension_date'] = '$datetime';
    // request.files
    //     .add(await http.MultipartFile.fromPath('Member_Image', imagee.path));
    final response = await request.send();
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      // Map mapValue;
      // mapValue = json.decode(response);
      // print('Eidt : ${mapValue.values.toString()}');
    }
  }

  Future<void> amemberUnsuspinsion() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = prefs.get(key) ?? 0;
    final key2 = 'token';
    final value2 = prefs.get(key2) ?? 0;
    var myUrl = Uri.parse("$serverURL/gym_members/endsuspension/$value");
    print('token:$value2');
    final request = http.MultipartRequest('POST', myUrl);
    request.headers['Authorization'] = 'Bearer $value2';
    // request.fields['_method'] = 'PUT';
    //request.fields['Suspension_date'] = '$datetime';
    // request.files
    //     .add(await http.MultipartFile.fromPath('Member_Image', imagee.path));
    final response = await request.send();
    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print('Eidt :${response}');
    } else {
      print("Response body :$statusCode");
      // Map mapValue;
      // mapValue = json.decode(response);
      // print('Eidt : ${mapValue.values.toString()}');
    }
  }

  _save(
      String id,
      String account,
      String token,
      String emaill,
      String passsword,
      String name1,
      String name2,
      String imagemember,
      String imagecoache) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'id';
    final value = id;
    final key1 = 'Account_Type';
    final value1 = account;
    final key2 = 'token';
    final value2 = token;
    final key3 = 'Email';
    final value3 = emaill;
    final key4 = 'Passsword';
    final value4 = passsword;
    final key5 = 'Coach_Name';
    final value5 = name1;
    final key6 = 'Member_Name';
    final value6 = name2;
    final key7 = 'Member_Image';
    final value7 = imagemember;
    final key8 = 'Coach_Image';
    final value8 = imagecoache;

    prefs.setString(key, value);
    prefs.setString(key1, value1);
    prefs.setString(key2, value2);
    prefs.setString(key3, value3);
    prefs.setString(key4, value4);
    prefs.setString(key5, value5);
    prefs.setString(key6, value6);
    prefs.setString(key7, value7);
    prefs.setString(key8, value8);
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
    final key7 = 'Member_Image';
    final value7 = prefs.get(key7) ?? 0;
    final key8 = 'Coach_Image';
    final value8 = prefs.get(key8) ?? 0;

    print('Read :$value,$value1,$value2,$value3,$value4');
  }
}
