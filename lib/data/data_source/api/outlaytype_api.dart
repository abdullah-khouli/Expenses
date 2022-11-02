import 'dart:convert';

import 'package:e_family_expenses/domain/models/outlay.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class OutlayTypeApi {
  Future<http.Response> getOutlayTypes() async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/OutlayType/ShowOutlayTypes");
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

  Future<http.Response> getOutlayTypeByUserId(String headId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/OutlayType/GetOutlayTypeUser/$headId");
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

  Future<http.Response> addOutlayType(OutlayType outlayType) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/OutlayType/AddOutlayType");
    try {
      final response = await http.post(myUri,
          body: jsonEncode({
            "name": outlayType.name,
            "userId": outlayType.userId,
            "description": outlayType.desc,
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

  getOutlayType(int outlayTypeId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/OutlayType/GetOutlayType/$outlayTypeId");
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

  editOutlayType(OutlayType outlayType) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/OutlayType/EditOutlayType");
    try {
      final response = await http.put(myUri,
          body: jsonEncode({
            "id": outlayType.id,
            "name": outlayType.name,
            "userId": outlayType.userId,
            "description": outlayType.desc,
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

  deleteOutlayType(int outlayTypeId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/OutlayType/DeleteOutlayType/$outlayTypeId");
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
