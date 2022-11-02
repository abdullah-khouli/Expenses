import 'dart:convert';

import 'package:e_family_expenses/domain/models/outlay.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class OutlayApi {
  Future<http.Response> getExpenses() async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Outlays/ShowExpenses");
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

  Future<http.Response> getEspensesByUserIdAndIsService(
      String userId, bool isService) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Outlays/GetUserMaterialExpense/$userId?isService=$isService");
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

  Future<http.Response> getEspensesByUserId(String userId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Outlays/GetUserExpense/$userId");
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

  getExpense(int outlayId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Outlays/GetExpense/$outlayId");
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

  Future<http.Response> getmonthlyEspensesByUserId(
      String userId, String date) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Outlays/GetUserMonthlyExpense/$userId?monthly=$date");
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

  Future<http.Response> getYearlyEspensesByUserId(
      String userId, int year) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Outlays/GetUserYearlyExpense/$userId?yearly=$year");
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

  Future<http.Response> addExpense(Outlay outlay) async {
    Uri myUri =
        Uri.parse("Http://familyexpensesapi.somee.com/api/Outlays/AddExpense");
    try {
      final response = await http.post(myUri,
          body: jsonEncode({
            "materialId": outlay.materialId,
            "outlayTypeId": outlay.outlayTypeId,
            "userId": outlay.userId,
            "price": outlay.price,
            "date": outlay.date,
            "description": outlay.desc
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

  editExpense(Outlay outlay) async {
    Uri myUri =
        Uri.parse("Http://familyexpensesapi.somee.com/api/Outlays/EditExpense");
    try {
      print({
        "id": outlay.id,
        "materialId": outlay.materialId,
        "outlayTypeId": outlay.outlayTypeId,
        "userId": outlay.userId,
        "price": outlay.price,
        "date": outlay.date,
        "description": outlay.desc
      });
      final response = await http.put(myUri,
          body: jsonEncode({
            "id": outlay.id,
            "materialId": outlay.materialId,
            "outlayTypeId": outlay.outlayTypeId,
            "userId": outlay.userId,
            "price": outlay.price,
            "date": outlay.date,
            "description": outlay.desc
          }),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json"
          });

      return response;
    } catch (e) {
      print('catch api');
      print(e);
      rethrow;
    }
  }

  deleteExpense(int outlayId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Outlays/DeleteExpense/$outlayId");
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
