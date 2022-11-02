import 'dart:convert';

import 'package:e_family_expenses/domain/models/outlay.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class MaterialApi {
  Future<http.Response> getMaterials() async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Materials/ShowMaterials");
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

  Future<http.Response> getMaterialsByID(String headId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Materials/GetMaterialUser/$headId");
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

  Future<http.Response> addMaterial(MaterialModel material) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Materials/AddMaterial");
    try {
      final response = await http.post(myUri,
          body: jsonEncode({
            "userId": material.userId,
            "id": material.id,
            "name": material.name,
            "isService": material.isService,
            "description": material.desc,
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

  getMaterial(int materialId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Materials/GetMaterial/$materialId");
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

  Future<http.Response> editMaterial(MaterialModel material) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Materials/EditMaterial");
    try {
      final response = await http.put(myUri,
          body: jsonEncode({
            "id": material.id,
            "name": material.name,
            "isService": material.isService,
            "description": material.desc,
            "userId": material.userId
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

  deleteMaterial(int materialId) async {
    Uri myUri = Uri.parse(
        "Http://familyexpensesapi.somee.com/api/Materials/DeleteMaterial/$materialId");
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
