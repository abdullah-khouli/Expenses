import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import '../../data/data_source/api/outlay_api.dart';
import '../models/login.dart';

class OutlaysRepo {
  final api = OutlayApi();
  Future<Either<Failure, List<Outlay>>> getExpenses() async {
    try {
      print('repo getmaterial start');
      final response = await api.getExpenses();
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        print(200);
        List<Outlay> outlaysData = [];
        for (Map outlay in resData) {
          outlaysData.add(
            Outlay(
              id: outlay['id'],
              materialId: outlay['materialId'],
              outlayTypeId: outlay['outlayTypeId'],
              userId: outlay['userId'],
              price: outlay['price'],
              date: outlay['date'],
              desc: outlay['description'] ?? '',
              material: MaterialModel(
                userId: outlay['material']['userId'],
                id: outlay['material']['id'],
                name: outlay['material']['name'],
                isService: outlay['material']['isService'],
                desc: outlay['material']['description'] ?? '',
              ),
              outlayType: OutlayType(
                id: outlay['outlayType']['id'],
                name: outlay['outlayType']['name'],
                userId: outlay['outlayType']['userId'],
                desc: outlay['outlayType']['description'] ?? '',
              ),
            ),
          );
        }
        return Right(outlaysData);
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

  Future<Either<Failure, List<Outlay>>> getEspensesByUserIdAndIsService(
      String userId, bool isService) async {
    try {
      print('repo getmaterial start');
      final response =
          await api.getEspensesByUserIdAndIsService(userId, isService);
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        print(200);
        List<Outlay> outlaysData = [];
        for (Map outlay in resData) {
          outlaysData.add(
            Outlay(
              id: outlay['id'],
              materialId: outlay['materialId'],
              outlayTypeId: outlay['outlayTypeId'],
              userId: outlay['userId'],
              price: outlay['price'],
              date: outlay['date'],
              desc: outlay['description'] ?? '',
              material: MaterialModel(
                userId: outlay['material']['userId'],
                id: outlay['material']['id'],
                name: outlay['material']['name'],
                isService: outlay['material']['isService'],
                desc: outlay['material']['description'] ?? '',
              ),
              outlayType: OutlayType(
                id: outlay['outlayType']['id'],
                name: outlay['outlayType']['name'],
                userId: outlay['outlayType']['userId'],
                desc: outlay['outlayType']['description'] ?? '',
              ),
            ),
          );
        }
        return Right(outlaysData);
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

  Future<Either<Failure, List<Outlay>>> getEspensesByUserId(
      String userId) async {
    try {
      print('repo getmaterial start');
      final response = await api.getEspensesByUserId(userId);
      final resData = jsonDecode(response.body);
      // print(resData);
      if (response.statusCode == 200) {
        print(200);
        List<Outlay> outlaysData = [];
        print(resData);
        for (Map outlay in resData) {
          outlaysData.add(
            Outlay(
              id: outlay['id'],
              materialId: outlay['materialId'],
              outlayTypeId: outlay['outlayTypeId'],
              userId: outlay['userId'],
              price: outlay['price'],
              date: outlay['date'],
              desc: outlay['description'] ?? '',
              material: MaterialModel(
                userId: outlay['material']['userId'],
                id: outlay['material']['id'],
                name: outlay['material']['name'],
                isService: outlay['material']['isService'],
                desc: outlay['material']['description'] ?? '',
              ),
              outlayType: OutlayType(
                id: outlay['outlayType']['id'],
                name: outlay['outlayType']['name'],
                userId: outlay['outlayType']['userId'],
                desc: outlay['outlayType']['description'] ?? '',
              ),
            ),
          );
        }
        return Right(outlaysData);
      } else {
        print('not 200');
        return Left(
            Failure(code: response.statusCode, message: resData[0]['message']));
      }
    } catch (e) {
      print('catch');
      print(e);
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, Outlay>> getExpense(int outlayId) async {
    try {
      final response = await api.getExpense(outlayId);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return Right(
          Outlay(
            id: resData['id'],
            materialId: resData['materialId'],
            outlayTypeId: resData['outlayTypeId'],
            userId: resData['userId'],
            price: resData['price'],
            date: resData['date'],
            desc: resData['description'] ?? '',
            material: MaterialModel(
              userId: resData['material']['userId'],
              id: resData['material']['id'],
              name: resData['material']['name'],
              isService: resData['material']['isService'],
              desc: resData['material']['description'] ?? '',
            ),
            outlayType: OutlayType(
              id: resData['outlayType']['id'],
              name: resData['outlayType']['name'],
              userId: resData['outlayType']['userId'],
              desc: resData['outlayType']['description'] ?? '',
            ),
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

  Future<Either<Failure, List<Outlay>>> getmonthlyEspensesByUserId(
      String userId, String date) async {
    try {
      print('repo getmaterial start');
      final response = await api.getmonthlyEspensesByUserId(userId, date);
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        print(200);
        List<Outlay> outlaysData = [];
        for (Map outlay in resData) {
          outlaysData.add(
            Outlay(
              id: outlay['id'],
              materialId: outlay['materialId'],
              outlayTypeId: outlay['outlayTypeId'],
              userId: outlay['userId'],
              price: outlay['price'],
              date: outlay['date'],
              desc: outlay['description'] ?? '',
              material: MaterialModel(
                userId: outlay['material']['userId'],
                id: outlay['material']['id'],
                name: outlay['material']['name'],
                isService: outlay['material']['isService'],
                desc: outlay['material']['description'] ?? '',
              ),
              outlayType: OutlayType(
                id: outlay['outlayType']['id'],
                name: outlay['outlayType']['name'],
                userId: outlay['outlayType']['userId'],
                desc: outlay['outlayType']['description'] ?? '',
              ),
            ),
          );
        }
        return Right(outlaysData);
      } else {
        print('not 200');
        return Left(
            Failure(code: response.statusCode, message: resData[0]['message']));
      }
    } catch (e) {
      print('catch');
      print(e);
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, List<Outlay>>> getYearlyEspensesByUserId(
      String userId, int year) async {
    try {
      print('repo getmaterial startttttttttt');
      final response = await api.getYearlyEspensesByUserId(userId, year);
      final resData = jsonDecode(response.body);
      print(resData);
      if (response.statusCode == 200) {
        print(200);
        List<Outlay> outlaysData = [];
        for (Map outlay in resData) {
          outlaysData.add(
            Outlay(
              id: outlay['id'],
              materialId: outlay['materialId'],
              outlayTypeId: outlay['outlayTypeId'],
              userId: outlay['userId'],
              price: outlay['price'],
              date: outlay['date'],
              desc: outlay['description'] ?? '',
              material: MaterialModel(
                userId: outlay['material']['userId'],
                id: outlay['material']['id'],
                name: outlay['material']['name'],
                isService: outlay['material']['isService'],
                desc: outlay['material']['description'] ?? '',
              ),
              outlayType: OutlayType(
                id: outlay['outlayType']['id'],
                name: outlay['outlayType']['name'],
                userId: outlay['outlayType']['userId'],
                desc: outlay['outlayType']['description'] ?? '',
              ),
            ),
          );
        }
        return Right(outlaysData);
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

  Future<Either<Failure, Outlay>> addExpense(Outlay outlay) async {
    try {
      print(outlay.material!.name);
      final response = await api.addExpense(outlay);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print('200');
        print(resData);
        outlay.id = resData['id'];
        return Right(outlay
            // Outlay(
            //   id: resData['id'],
            //   materialId: resData['materialId'],
            //   outlayTypeId: resData['outlayTypeId'],
            //   userId: resData['userId'],
            //   price: resData['price'],
            //   date: resData['date'],
            //   desc: resData['description'],
            //   material: MaterialModel(
            //       userId: resData['material']['userId'],
            //       id: resData['material']['id'],
            //       name: resData['material']['name'],
            //       isService: resData['material']['isService'],
            //       desc: resData['material']['description']),
            //   outlayType: OutlayType(
            //       id: resData['outlayType']['id'],
            //       name: resData['outlayType']['name'],
            //       userId: resData['outlayType']['userId'],
            //       desc: resData['outlayType']['description']),
            // ),
            );
      } else {
        print('not 200');
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      print('catch');
      print(e);
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, Outlay>> editExpense(Outlay outlay) async {
    try {
      final response = await api.editExpense(outlay);
      print(response.statusCode);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(' 200');

        return Right(
          Outlay(
            id: resData['id'],
            materialId: resData['materialId'],
            outlayTypeId: resData['outlayTypeId'],
            userId: resData['userId'],
            price: resData['price'],
            date: resData['date'],
            desc: resData['description'] ?? '',
            // material: MaterialModel(
            //     userId: resData['material']['userId'],
            //     id: resData['material']['id'],
            //     name: resData['material']['name'],
            //     isService: resData['material']['isService'],
            //     desc: resData['material']['description']),
            // outlayType: OutlayType(
            //     id: resData['outlayType']['id'],
            //     name: resData['outlayType']['name'],
            //     userId: resData['outlayType']['userId'],
            //     desc: resData['outlayType']['description']),
          ),
        );
      } else {
        print('not 200');

        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      print('repo catchhhh');
      print(e);
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }

  Future<Either<Failure, Outlay>> deleteExpense(int outlayId) async {
    try {
      final response = await api.deleteExpense(outlayId);
      final resData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(200);
        print(resData);
        return Right(
          Outlay(
            id: resData['id'],
            materialId: resData['materialId'],
            outlayTypeId: resData['outlayTypeId'],
            userId: resData['userId'],
            price: resData['price'],
            date: resData['date'],
            desc: resData['description'] ?? '',
            // material: MaterialModel(
            //     userId: resData['material']['userId'],
            //     id: resData['material']['id'],
            //     name: resData['material']['name'],
            //     isService: resData['material']['isService'],
            //     desc: resData['material']['description']),
            // outlayType: OutlayType(
            //     id: resData['outlayType']['id'],
            //     name: resData['outlayType']['name'],
            //     userId: resData['outlayType']['userId'],
            //     desc: resData['outlayType']['description']),
          ),
        );
      } else {
        return Left(Failure(code: response.statusCode, message: resData));
      }
    } catch (e) {
      print('catch');
      print(e);
      return Left(Failure(
          code: 400, message: 'Some thing went wrong please try again'));
    }
  }
}
