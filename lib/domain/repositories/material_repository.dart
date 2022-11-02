import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/data_source/api/material_api.dart';
import '../models/login.dart';

class MaterialsRepo {
  final api = MaterialApi();
  Future<Either<Failure, List<MaterialModel>>> getMaterials() async {
    try {
      print('repo getmaterial start');
      final response = await api.getMaterials();
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        print(200);
        List<MaterialModel> materialsData = [];
        for (Map material in resData) {
          materialsData.add(MaterialModel(
              userId: resData['userId'],
              id: material['id'],
              name: material['name'],
              isService: material['isService'],
              desc: material['description'] ?? ''));
        }
        return Right(materialsData);
      } else {
        print('not 200');
        return Left(
            Failure(code: response.statusCode, message: resData[0]['message']));
      }
    } catch (e) {
      print('catch');
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, List<MaterialModel>>> getMaterialsById(
      String materialId) async {
    try {
      final response = await api.getMaterialsByID(materialId);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<MaterialModel> materialsData = [];
        for (Map element in resData) {
          if (element['id'] != GetStorage().read('id')) {
            materialsData.add(MaterialModel(
                userId: element['userId'],
                id: element['id'],
                name: element['name'],
                isService: element['isService'],
                desc: element['description'] ?? ''));
          }
        }
        return Right(materialsData);
      } else {
        return Left(
            Failure(code: response.statusCode, message: resData[0]['message']));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, MaterialModel>> getmaterial(int materialId) async {
    try {
      final response = await api.getMaterial(materialId);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(MaterialModel(
            userId: resData['userId'],
            id: resData['id'],
            name: resData['name'],
            isService: resData['isService'],
            desc: resData['description'] ?? ''));
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, MaterialModel>> editMaterial(
      MaterialModel material) async {
    try {
      final response = await api.editMaterial(material);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(MaterialModel(
            userId: resData['userId'],
            id: resData['id'],
            name: resData['name'],
            isService: resData['isService'],
            desc: resData['description'] ?? ''));
      } else {
        print('here');
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      print('catch');
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, MaterialModel>> deleteMaterial(int materialId) async {
    try {
      final response = await api.deleteMaterial(materialId);
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        return Right(MaterialModel(
            userId: resData['userId'],
            id: resData['id'],
            name: resData['name'],
            isService: resData['isService'],
            desc: resData['description'] ?? ''));
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, MaterialModel>> addMaterial(
      MaterialModel material) async {
    try {
      final response = await api.addMaterial(material);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('right');
        return Right(MaterialModel(
            userId: resData['userId'],
            id: resData['id'],
            name: resData['name'],
            isService: resData['isService'],
            desc: resData['description'] ?? ''));
      } else {
        print(response.statusCode);
        print('left res');
        print(resData);
        print('here');
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      print('left catch');
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }
}
