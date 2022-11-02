import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

import '../../../domain/models/login.dart';

class UserApi {
  Future<http.Response> getUsers() async {
    Uri myUri =
        Uri.parse("Http://familyexpensesapi.somee.com/api/Users/ShowUsers");
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

  Future<http.Response> getUsersByID(String headId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Users/ShowUsersByheadid/$headId");
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

  Future<http.Response> createUser(LoginModel userInfo) async {
    Uri myUri =
        Uri.parse("Http://familyexpensesapi.somee.com/api/Users/CreateUser");
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

  getUser(String userId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Users/GetUser/$userId");
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

  editUser(LoginModel userInfo) async {
    Uri myUri =
        Uri.parse("Http://familyexpensesapi.somee.com/api/Users/EditUser");
    try {
      final response = await http.put(myUri,
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

  Future<http.Response> deleteUser(String userId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Users/DeleteUser/$userId");
    try {
      final response = await http.delete(myUri, headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      });

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
