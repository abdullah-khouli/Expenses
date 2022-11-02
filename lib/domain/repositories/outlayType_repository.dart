import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_family_expenses/data/data_source/api/outlaytype_api.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import 'package:get_storage/get_storage.dart';
import '../models/login.dart';

class OutlaysTypeRepo {
  final api = OutlayTypeApi();
  Future<Either<Failure, List<OutlayType>>> getOutlayTypes() async {
    try {
      print('repo getmaterial start');
      final response = await api.getOutlayTypes();
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        print(200);
        List<OutlayType> outlayTypesData = [];
        for (Map outlayType in resData) {
          outlayTypesData.add(
            OutlayType(
              id: outlayType['id'],
              name: outlayType['name'],
              userId: outlayType['userId'],
              desc: outlayType['description'] ?? '',
            ),
          );
        }
        return Right(outlayTypesData);
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

  Future<Either<Failure, List<OutlayType>>> getOutlayTypesByUserId(
      String userId) async {
    try {
      final response = await api.getOutlayTypeByUserId(userId);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<OutlayType> outlayTypesData = [];
        for (Map element in resData) {
          if (element['id'] != GetStorage().read('id')) {
            outlayTypesData.add(OutlayType(
                id: element['id'],
                name: element['name'],
                userId: element['userId'],
                desc: element['description'] ?? ''));
          }
        }
        return Right(outlayTypesData);
      } else {
        return Left(
            Failure(code: response.statusCode, message: resData[0]['message']));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, OutlayType>> getOutlayType(int outlayTypeId) async {
    try {
      final response = await api.getOutlayType(outlayTypeId);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(OutlayType(
            id: resData['id'],
            name: resData['name'],
            userId: resData['userId'],
            desc: resData['description'] ?? ''));
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, OutlayType>> editOutlayType(
      OutlayType outlayType) async {
    try {
      final response = await api.editOutlayType(outlayType);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(OutlayType(
            id: resData['id'],
            name: resData['name'],
            userId: resData['userId'],
            desc: resData['description'] ?? ''));
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, OutlayType>> deleteOutlayType(int outlayTypeID) async {
    try {
      final response = await api.deleteOutlayType(outlayTypeID);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(OutlayType(
            id: resData['id'],
            name: resData['name'],
            userId: resData['userId'],
            desc: resData['description'] ?? ''));
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, OutlayType>> addOutlayType(
      OutlayType outlayType) async {
    try {
      final response = await api.addOutlayType(outlayType);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(OutlayType(
            id: resData['id'],
            name: resData['name'],
            userId: resData['userId'],
            desc: resData['description'] ?? ''));
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }
}
