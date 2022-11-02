import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../domain/models/login.dart';

class LoginApi {
  Future<http.Response> signUp(LoginModel userInfo) async {
    Uri myUri =
        Uri.parse("Http://familyexpensesapi.somee.com/api/Login/SignUp");
    try {
      final response = await http.post(myUri,
          body: jsonEncode({
            "id": userInfo.id,
            "userName": userInfo.userName,
            "headFamilyId": userInfo.headFamilyId,
            "password": userInfo.password,
          }),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> signin(LoginModel userInfo) async {
    Uri myUri =
        Uri.parse("Http://familyexpensesapi.somee.com/api/Login/Signin");

    try {
      final response = await http.post(myUri,
          body: jsonEncode({
            "id": userInfo.id,
            "userName": userInfo.userName,
            "headFamilyId": userInfo.headFamilyId,
            "password": userInfo.password,
          }),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<http.Response> changePassword(Passwords passwords) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Login/ChangePassword?ID=${passwords.id}&OldPassword=${passwords.old}&NewPassword=${passwords.newPass}");
    try {
      final response = await http.get(myUri, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
