import 'dart:async';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:mobile_version/controller/user_model.dart';

class UserController {
  final url = "http://localhost:8080/api/users/auth/signup";
  final ping = "http://localhost:8080/ping";
  Map<String, String> customHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };
  Future<User> fetchPost() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      return User.fromJson(json.decode(response.body));
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('Failed to load post');
    }
  }

  Future<User?> signup({required User user}) async {
    var url = "http://localhost:8080/api/users/auth/signup/";

    final response = await http.post(Uri.parse(url), body: {
      "email": user.email,
      "name": user.name,
      "approvalCode": user.approvalCode,
      "bloodType": user.bloodType,
      "companyId": user.companyId,
      "department": user.department,
      "gender": user.gender,
      "password": user.password,
      "phoneNumber": user.phoneNumber,
      "phoneCountryId": user.phoneCountryId,
      "dateOfBirth": user.dateOfBirth,
    });
    var data = response.body;
    if (response.statusCode == 201) {
      String responseString = response.body;
      userFromJson(responseString);
    } else
      return null;
  }

  Future PostData(User user) async {
    http.Response response = await http.post(Uri.parse(url),
        headers: customHeaders, body: jsonEncode(user));

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   return User.fromJson(json.decode(response.body));
    // } else {
    //   print(response.statusCode);
    //   printError();
    //   throw Exception();
    // }
    printError();
    print(response.statusCode);
    return response.body;
  }

  Future<http.Response> createdata(User user) async {
    return http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": user.email,
        "name": user.name,
        "approvalCode": user.approvalCode,
        "bloodType": user.bloodType,
        "companyId": user.companyId,
        "department": user.department,
        "gender": user.gender,
        "password": user.password,
        "phoneNumber": user.phoneNumber,
        "phoneCountryId": user.phoneCountryId,
        "dateOfBirth": user.dateOfBirth,
      }),
    );
  }
}
