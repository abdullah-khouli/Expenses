// import 'dart:convert';

// import 'package:dartz/dartz.dart';
// import 'package:e_family_expenses/data/data_source/api/outlaytype_api.dart';
// import 'package:e_family_expenses/domain/models/outlay.dart';
// import 'package:get_storage/get_storage.dart';

// import '../../data/data_source/api/outlay_api.dart';
// import '../models/login.dart';

// class OutlaysRepo {
//   final api = OutlayApi();
//   Future<Either<Failure, List<Outlay>>> getExpenses() async {
//     try {
//       final response = await api.getExpenses();
//       final resData = jsonDecode(response.body);
//       print(resData);
//       if (response.statusCode == 200) {
//         print(200);
//         List<Outlay> expensesData = [];
//         for (Map expense in resData) {
//           expensesData.add(
//             Outlay(
//               id: expense['id'],
//               outlayTypeId: expense['outlayTypeId'],
//               userId: expense['userId'],
//               materialId: expense['materialId'],
//               date: expense['date'],
//               price: expense['price'],
//               desc: expense['description'],
//             ),
//           );
//         }
//         return Right(expensesData);
//       } else {
//         print('not 200');
//         return Left(
//             Failure(code: response.statusCode, message: resData[0]['message']));
//       }
//     } catch (e) {
//       print('catch');
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }

//   Future<Either<Failure, List<Outlay>>> getEspensesByUserIdAndIsService(
//       String userId, bool isService) async {
//     try {
//       final response =
//           await api.getEspensesByUserIdAndIsService(userId, isService);
//       final resData = jsonDecode(response.body);
//       print(resData);
//       if (response.statusCode == 200) {
//         print(200);
//         List<Outlay> expensesData = [];
//         for (Map expense in resData) {
//           expensesData.add(
//             Outlay(
//               id: expense['id'],
//               outlayTypeId: expense['outlayTypeId'],
//               userId: expense['userId'],
//               materialId: expense['materialId'],
//               date: expense['date'],
//               price: expense['price'],
//               desc: expense['description'],
//             ),
//           );
//         }
//         return Right(expensesData);
//       } else {
//         print('not 200');
//         return Left(
//             Failure(code: response.statusCode, message: resData[0]['message']));
//       }
//     } catch (e) {
//       print('catch');
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }

//   Future<Either<Failure, List<Outlay>>> getEspensesByUserId(
//       String userId) async {
//     try {
//       final response = await api.getEspensesByUserId(userId);
//       final resData = jsonDecode(response.body);
//       print(resData);
//       if (response.statusCode == 200) {
//         print(200);
//         List<Outlay> expensesData = [];
//         for (Map expense in resData) {
//           expensesData.add(
//             Outlay(
//               id: expense['id'],
//               outlayTypeId: expense['outlayTypeId'],
//               userId: expense['userId'],
//               materialId: expense['materialId'],
//               date: expense['date'],
//               price: expense['price'],
//               desc: expense['description'],
//             ),
//           );
//         }
//         return Right(expensesData);
//       } else {
//         print('not 200');
//         return Left(
//             Failure(code: response.statusCode, message: resData[0]['message']));
//       }
//     } catch (e) {
//       print('catch');
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }

//   Future<Either<Failure, List<Outlay>>> getmonthlyEspensesByUserId(
//       String userId, DateTime date) async {
//     try {
//       final response = await api.getmonthlyEspensesByUserId(userId, date);
//       final resData = jsonDecode(response.body);
//       print(resData);
//       if (response.statusCode == 200) {
//         print(200);
//         List<Outlay> expensesData = [];
//         for (Map expense in resData) {
//           expensesData.add(
//             Outlay(
//               id: expense['id'],
//               outlayTypeId: expense['outlayTypeId'],
//               userId: expense['userId'],
//               materialId: expense['materialId'],
//               date: expense['date'],
//               price: expense['price'],
//               desc: expense['description'],
//             ),
//           );
//         }
//         return Right(expensesData);
//       } else {
//         print('not 200');
//         return Left(
//             Failure(code: response.statusCode, message: resData[0]['message']));
//       }
//     } catch (e) {
//       print('catch');
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }

//   Future<Either<Failure, List<Outlay>>> getYearlyEspensesByUserId(
//       String userId, int year) async {
//     try {
//       final response = await api.getYearlyEspensesByUserId(userId, year);
//       final resData = jsonDecode(response.body);
//       print(resData);
//       if (response.statusCode == 200) {
//         print(200);
//         List<Outlay> expensesData = [];
//         for (Map expense in resData) {
//           expensesData.add(
//             Outlay(
//               id: expense['id'],
//               outlayTypeId: expense['outlayTypeId'],
//               userId: expense['userId'],
//               materialId: expense['materialId'],
//               date: expense['date'],
//               price: expense['price'],
//               desc: expense['description'],
//             ),
//           );
//         }
//         return Right(expensesData);
//       } else {
//         print('not 200');
//         return Left(
//             Failure(code: response.statusCode, message: resData[0]['message']));
//       }
//     } catch (e) {
//       print('catch');
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }

//   Future<Either<Failure, Outlay>> getExpense(int outlayId) async {
//     try {
//       final response = await api.getExpense(outlayId);
//       final resData = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         return Right(
//           Outlay(
//             id: resData['id'],
//             outlayTypeId: resData['outlayTypeId'],
//             userId: resData['userId'],
//             materialId: resData['materialId'],
//             date: resData['date'],
//             price: resData['price'],
//             desc: resData['description'],
//           ),
//         );
//       } else {
//         return Left(Failure(code: response.statusCode, message: resData));
//       }
//     } catch (e) {
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }

//   Future<Either<Failure, Outlay>> editOutlay(Outlay outlay) async {
//     try {
//       final response = await api.editExpense(outlay);
//       final resData = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         return Right(
//           Outlay(
//             id: resData['id'],
//             outlayTypeId: resData['outlayTypeId'],
//             userId: resData['userId'],
//             materialId: resData['materialId'],
//             date: resData['date'],
//             price: resData['price'],
//             desc: resData['description'],
//           ),
//         );
//       } else {
//         return Left(Failure(code: response.statusCode, message: resData));
//       }
//     } catch (e) {
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }

//   Future<Either<Failure, Outlay>> deleteOutlay(int outlayId) async {
//     try {
//       final response = await api.deleteExpense(outlayId);
//       final resData = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         return Right(
//           Outlay(
//             id: resData['id'],
//             outlayTypeId: resData['outlayTypeId'],
//             userId: resData['userId'],
//             materialId: resData['materialId'],
//             date: resData['date'],
//             price: resData['price'],
//             desc: resData['description'],
//           ),
//         );
//       } else {
//         return Left(Failure(code: response.statusCode, message: resData));
//       }
//     } catch (e) {
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }

//   Future<Either<Failure, Outlay>> addOutlay(Outlay outlay) async {
//     try {
//       final response = await api.addExpense(outlay);
//       final resData = jsonDecode(response.body);
//       if (response.statusCode == 200) {
//         return Right(
//           Outlay(
//             id: resData['id'],
//             outlayTypeId: resData['outlayTypeId'],
//             userId: resData['userId'],
//             materialId: resData['materialId'],
//             date: resData['date'],
//             price: resData['price'],
//             desc: resData['description'],
//           ),
//         );
//       } else {
//         return Left(Failure(code: response.statusCode, message: resData));
//       }
//     } catch (e) {
//       return Left(Failure(
//           code: 400, message: 'Some thing went wrong please try again'));
//     }
//   }
// }
