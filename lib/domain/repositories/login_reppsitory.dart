import 'dart:convert';

import 'package:dartz/dartz.dart';

import '../../data/data_source/api/login_api.dart';
import '../models/login.dart';

class LoginRepo {
  final api = LoginApi();
  Future<Either<Failure, LoginModel>> signUp(LoginModel userInfo) async {
    try {
      final response = await api.signUp(userInfo);
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

  Future<Either<Failure, Map>> signin(LoginModel userInfo) async {
    try {
      final response = await api.signin(userInfo);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(200);
        return Right(resData); //return user id to store it in getx storage
      } else {
        print('failure');
        print(resData);
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      print('catch');
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  changePassword(Passwords passwords) async {
    try {
      final response = await api.changePassword(passwords);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(resData); //return user id to store it in getx storage
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      print('catch');
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }
}
