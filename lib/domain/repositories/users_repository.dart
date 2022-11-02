import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/data_source/api/user_api.dart';
import '../models/login.dart';

class UsersRepo {
  final api = UserApi();
  Future<Either<Failure, List<LoginModel>>> getUsers() async {
    try {
      print('userRepo');
      final response = await api.getUsers();
      print(response.statusCode);
      final resData = jsonDecode(response.body);
      print('here');
      print(resData);
      if (response.statusCode == 200) {
        List<LoginModel> usersData = [];
        print('here1');
        for (Map element in resData) {
          if (element['id'] != GetStorage().read('id')) {
            usersData.add(LoginModel(
                id: element['id'],
                userName: element['userName'],
                headFamilyId: element['headFamilyId'] ?? '',
                password: element['password']));
          }
        }
        /* resData.forEach((element) {
          usersData.add(LoginModel(
              id: element['id'],
              userName: element['userName'],
              headFamilyId: element['headFamilyId'],
              password: element['password']));
        });*/
        print('right');
        return Right(usersData);
      } else {
        print('left');
        return Left(
            Failure(code: response.statusCode, message: resData[0]['message']));
      }
    } catch (e) {
      print('catch left');
      print(e);
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, List<LoginModel>>> getUsersById(String headId) async {
    try {
      print('userRepo');
      final response = await api.getUsersByID(headId);
      print(response.statusCode);
      final resData = jsonDecode(response.body);
      print('here');
      print(resData);
      if (response.statusCode == 200) {
        List<LoginModel> usersData = [];
        print('here1');
        for (Map element in resData) {
          if (element['id'] != GetStorage().read('id')) {
            usersData.add(LoginModel(
                id: element['id'],
                userName: element['userName'],
                headFamilyId: element['headFamilyId'] ?? '',
                password: element['password']));
          }
        }
        print('right');
        return Right(usersData);
      } else {
        print('left');
        return Left(
            Failure(code: response.statusCode, message: resData[0]['message']));
      }
    } catch (e) {
      print('catch left');
      print(e);
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, LoginModel>> getUser(String userId) async {
    try {
      final response = await api.getUser(userId);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(
          LoginModel(
            id: resData['id'],
            userName: resData['userName'],
            headFamilyId: resData['headFamilyId'],
            password: resData['password'],
          ),
        );
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  editUser(LoginModel userInfo) async {
    try {
      final response = await api.editUser(userInfo);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(
          LoginModel(
            id: resData['id'],
            userName: resData['userName'],
            headFamilyId: resData['headFamilyId'],
            password: resData['password'],
          ),
        );
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  deleteUser(String userId) async {
    try {
      final response = await api.deleteUser(userId);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(
          LoginModel(
            id: resData['id'],
            userName: resData['userName'],
            headFamilyId: resData['headFamilyId'],
            password: resData['password'],
          ),
        );
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      print('catch');
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, LoginModel>> createUser(LoginModel userInfo) async {
    try {
      final response = await api.createUser(userInfo);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(
          LoginModel(
            id: resData['id'],
            userName: resData['userName'],
            headFamilyId: resData['headFamilyId'],
            password: resData['password'],
          ),
        );
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }
}
