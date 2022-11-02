import 'package:e_family_expenses/UI/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../data/network/network_info.dart';
import '../../../domain/models/outlay.dart';
import '../../../domain/repositories/outlay_repository.dart';
import '../materials/my_material _controller.dart';
import '../outlayTypes/outlayType_controller.dart';

class OutlayController extends GetxController {
  final outlaysRepo = OutlaysRepo();

  final MyMaterialController materialCotroller = MyMaterialController();
  final OutlayTypeController outlayTypeCotroller = OutlayTypeController();

  final _box = GetStorage();
  RxBool createOutlayIsLoading = false.obs;
  //RxBool isService = false.obs;
  RxBool outlayIsLoading = false.obs;
  RxBool editOutlayLoading = false.obs;

  RxList outlays = [].obs;
  RxList outlaysMonthly = [].obs;
  RxList outlaysYearly = [].obs;
  RxList outlaysWithService = [].obs;
  RxList outlaysWithMaterial = [].obs;
  RxDouble thisYearExpenses = 0.0.obs;
  RxDouble aYearExpenses = 0.0.obs;
  RxDouble lastMonthExpenses = 0.0.obs;
  RxDouble thisMonthExpenses = 0.0.obs;
  RxDouble aMonthExpenses = 0.0.obs;
  RxDouble allExpenses = 0.0.obs;
  RxInt selectedYear = DateTime.now().year.obs;
  Rx<String> selectedIsService = 'All'.obs;

  Rx<MaterialModel> selectedMaterial = MaterialModel(
          userId: 'userId', name: 'None', desc: 'desc', isService: true)
      .obs;
  Rx<OutlayType> selectedOutlayType =
      OutlayType(userId: 'userId', name: 'None', desc: 'desc').obs;

  Rx<DateTime> selectedDate = DateTime.now().obs;

  InternetConnection connection = InternetConnection();
  testInternetConnetion() {
    return connection.hasNetwork();
  }

  Future<String> getExpenses() async {
    outlayIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlaysRepo.getExpenses()).fold((failure) {
        print('failure response');
        //outlays.value = [];
        outlayIsLoading.value = false;
        return failure.message;
      }, (newOutlayTypes) async {
        print('data response');
        outlays.value = newOutlayTypes;
        outlayIsLoading.value = false;
        return '';
      });
    } else {
      print('not connected');
      print('failure');
      // outlays.value = [];
      outlayIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getEspensesByUserIdAndIsService(
      String userId, bool isService) async {
    outlayIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlaysRepo.getEspensesByUserIdAndIsService(
              userId, isService))
          .fold((failure) {
        print('failure response');
        //outlays.value = [];
        outlayIsLoading.value = false;
        return failure.message;
      }, (newOutlayTypes) async {
        print('data response');
        if (isService) {
          outlaysWithService.value = newOutlayTypes;
        } else {
          outlaysWithMaterial.value = newOutlayTypes;
        }
        double expenses = 0;
        for (Outlay outlay in newOutlayTypes) {
          expenses = expenses + outlay.price;
        }
        //  expensesValues['all'] = expenses;
        allExpenses.value = expenses;
        _box.write(Constants.allExpenses, expenses);
        outlayIsLoading.value = false;
        return '';
      });
    } else {
      print('not connected');
      print('failure');
      //outlays.value = [];
      outlayIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getExspensesByUserId(String userId) async {
    outlayIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlaysRepo.getEspensesByUserId(userId)).fold((failure) {
        print('failure response');
        //outlays.value = [];
        outlayIsLoading.value = false;
        return failure.message;
      }, (newOutlayTypes) async {
        print('data response');
        outlays.value = newOutlayTypes;
        double expenses = 0;
        for (Outlay outlay in newOutlayTypes) {
          expenses = expenses + outlay.price;
        }
        //  expensesValues['all'] = expenses;
        allExpenses.value = expenses;
        _box.write(Constants.allExpenses, expenses);
        outlayIsLoading.value = false;
        return '';
      });
    } else {
      print('not connected');
      print('failure');
      //outlays.value = [];
      outlayIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getExpense(int outlayId) async {
    outlayIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlaysRepo.getExpense(outlayId)).fold((failure) {
        print('failure response');
        //outlays.value = [];
        outlayIsLoading.value = false;
        return failure.message;
      }, (newOutlayTypes) async {
        print('data response');
        outlays.add(newOutlayTypes);
        outlayIsLoading.value = false;
        return '';
      });
    } else {
      print('not connected');
      print('failure');
      // outlays.value = [];
      outlayIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getmonthlyEspensesByUserId(
      String userId, String date, bool? thisMonth) async {
    print('start');
    outlayIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlaysRepo.getmonthlyEspensesByUserId(userId, date)).fold(
          (failure) {
        print('failure response');
        // outlays.value = [];
        outlayIsLoading.value = false;
        return failure.message;
      }, (newOutlayTypes) async {
        print('data response');
        outlaysMonthly.value = newOutlayTypes;
        print(newOutlayTypes);
        double monthly = 0;
        for (Outlay outlay in outlaysMonthly) {
          monthly = monthly + outlay.price;
        }
        print(monthly);
        if (thisMonth == null) {
          //expensesValues['aMonth'] = monthly;
          aMonthExpenses.value = monthly;
          _box.write(Constants.aMonthExpenses, monthly);
        } else if (thisMonth == true) {
          print('true');
          //  expensesValues['thisMonth'] = monthly;
          thisMonthExpenses.value = monthly;
          _box.write(Constants.thisMonthExpenses, monthly);
        } else {
          // expensesValues['lastMonth'] = monthly;
          lastMonthExpenses.value = monthly;
          _box.write(Constants.lastMonthExpenses, monthly);
        }
        outlayIsLoading.value = false;
        print('finished');
        return '';
      });
    } else {
      print('not connected');
      print('failure');
      // outlays.value = [];
      outlayIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getYearlyEspensesByUserId(String userId, int year) async {
    outlayIsLoading.value = true;
    print(userId);
    print(year);
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlaysRepo.getYearlyEspensesByUserId(userId, year)).fold(
          (failure) {
        print('failure response');
        // outlays.value = [];
        outlayIsLoading.value = false;
        return failure.message;
      }, (newOutlayTypes) async {
        print('data response');
        print(newOutlayTypes);
        outlaysYearly.value = newOutlayTypes;
        double yearly = 0;
        for (Outlay outlay in newOutlayTypes) {
          yearly = yearly + outlay.price;
        }
        //expensesValues['thisYear'] = yearly;
        if (year == DateTime.now().year) {
          thisYearExpenses.value = yearly;
          _box.write(Constants.thisYearExpenses, yearly);
        }
        //else {
        aYearExpenses.value = yearly;
        // }
        outlayIsLoading.value = false;
        return '';
      });
    } else {
      print('not connected');
      print('failure');
      // outlays.value = [];
      outlayIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> addExpense(Map outlayData) async {
    createOutlayIsLoading.value = true;
    print(selectedDate.value);
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlaysRepo.addExpense(
        Outlay(
          outlayTypeId: selectedOutlayType.value.id!,
          materialId: selectedMaterial.value.id!,
          userId: GetStorage().read('id'),
          price: double.parse(outlayData['price']),
          date: myDateFormat(selectedDate.value),
          desc: outlayData['desc'],
          material: selectedMaterial.value,
          outlayType: selectedOutlayType.value,
        ),
      ))
          .fold((failure) {
        print('fold failure');
        createOutlayIsLoading.value = false;
        return failure.message;
      }, (outlay) async {
        print('success');
        print(outlay.id);
        outlays.add(outlay);
        if (selectedMaterial.value.isService) {
          outlaysWithService.add(outlay);
        } else {
          outlaysWithMaterial.add(outlay);
        }
        getExpensesNewValue(GetStorage().read('id'));
        createOutlayIsLoading.value = false;
        return '';
      });
    } else {
      createOutlayIsLoading.value = false;
      return 'No internet connection';
    }
  }

  editExpense(Map outlayData) async {
    editOutlayLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      print(outlayData);
      return (await outlaysRepo.editExpense(
        Outlay(
          id: outlayData['id'],
          outlayTypeId: selectedOutlayType.value.id!,
          materialId: selectedMaterial.value.id!,
          userId: GetStorage().read('id'),
          price: double.parse(outlayData['price']),
          date: myDateFormat(selectedDate.value),
          desc: outlayData['desc'],
          material: selectedMaterial.value,
          outlayType: selectedOutlayType.value,
        ),
      ))
          .fold((failure) {
        print('failure');
        editOutlayLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (newOutlay) async {
        final index = outlays.indexWhere((element) {
          return element.id == newOutlay.id;
        });
        outlays[index] = Outlay(
          id: newOutlay.id,
          outlayTypeId: newOutlay.outlayTypeId,
          materialId: newOutlay.materialId,
          userId: newOutlay.userId,
          price: newOutlay.price,
          date: myDateFormat(selectedDate.value),
          desc: newOutlay.desc,
          material: selectedMaterial.value,
          outlayType: selectedOutlayType.value,
        );

        editOutlayLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      editOutlayLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> deleteExpense(int outlayId) async {
    editOutlayLoading.value = true;

    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      print(outlayId);
      return (await outlaysRepo.deleteExpense(outlayId)).fold((failure) {
        print('failure');
        editOutlayLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (deletedOutlay) async {
        outlays.removeWhere((element) {
          final myOutlayType = element;
          return deletedOutlay.id == myOutlayType.id;
        });
        editOutlayLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      editOutlayLoading.value = false;
      return 'No internet connection';
    }
  }

  getStoredExpenses() {
    thisYearExpenses.value = _box.read(Constants.thisYearExpenses) ?? 0.0;
    lastMonthExpenses.value = _box.read(Constants.lastMonthExpenses) ?? 0.0;
    thisMonthExpenses.value = _box.read(Constants.thisMonthExpenses) ?? 0.0;
    aMonthExpenses.value = _box.read(Constants.aMonthExpenses) ?? 0.0;
    allExpenses.value = _box.read(Constants.allExpenses) ?? 0.0;
  }

  getExpensesNewValue(String id) async {
    outlayIsLoading.value = true;
    //final id = _box.read('id');
    print(id);
    final now = DateTime.now();
    print('${_box.read('id')},${DateFormat('y-M-d').format(now)},${true}');

    await getmonthlyEspensesByUserId(id, DateFormat('y-M-d').format(now), true);
    print('llllllllllllllllll');
    print(myDateFormat(DateTime(now.year, now.month - 1, now.day)));
    await getmonthlyEspensesByUserId(
        id,
        myDateFormat(DateTime(now.year, now.month - 1, now.day)),
        //DateFormat('y-M-d').format(DateTime(now.year, now.month - 1, now.day)),
        false);
    await getYearlyEspensesByUserId(id, now.year);
  }

  myDateFormat([DateTime? date]) {
    return DateFormat('y-M-d').format(date ?? selectedDate.value);
  }
}
