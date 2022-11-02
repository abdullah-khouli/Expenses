import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:e_family_expenses/UI/constants.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';

import '../../../data/network/network_info.dart';
import '../../../domain/repositories/outlayType_repository.dart';

class OutlayTypeController extends GetxController {
  final outlayTypesRepo = OutlaysTypeRepo();
  @override
  void dispose() {
    print('dispooooooooooooooose');
    super.dispose();
  }

  RxBool createOutlayTypeIsLoading = false.obs;
  //RxBool isService = false.obs;
  RxBool outlayTypeIsLoading = false.obs;
  RxBool editOutlayTypeLoading = false.obs;

  // final GetStorage _box = GetStorage();
  RxList outlayTypes = [].obs;
  InternetConnection connection = InternetConnection();
  testInternetConnetion() {
    return connection.hasNetwork();
  }

  Future<String> addOutlayType(OutlayType outlayType) async {
    createOutlayTypeIsLoading.value = true;

    final isConnected = await testInternetConnetion();
    if (isConnected) {
      return (await outlayTypesRepo.addOutlayType(outlayType)).fold((failure) {
        createOutlayTypeIsLoading.value = false;
        return failure.message;
      }, (outlayType) async {
        outlayTypes.add(outlayType);
        createOutlayTypeIsLoading.value = false;
        return '';
      });
    } else {
      createOutlayTypeIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getOutlayTypes() async {
    outlayTypeIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlayTypesRepo.getOutlayTypes()).fold((failure) {
        print('failure response');
        outlayTypes.value = [];
        outlayTypeIsLoading.value = false;
        return failure.message;
      }, (newOutlayTypes) async {
        print('data response');
        outlayTypes.value = newOutlayTypes;
        outlayTypeIsLoading.value = false;
        return '';
      });
    } else {
      print('not connected');
      print('failure');
      outlayTypes.value = [];
      outlayTypeIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getOutlayTypesByUserId() async {
    outlayTypeIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      return (await outlayTypesRepo.getOutlayTypesByUserId(
              GetStorage().read(Constants.isHeadFamily)
                  ? GetStorage().read(Constants.id)
                  : GetStorage().read(Constants.headFamilyId) ?? ''))
          .fold((failure) {
        print('failure');
        outlayTypes.value = [];
        //outlays.value = [
        //   MaterialModel(
        //       id: 0,
        //       name: 'namenamenamenamenamenamenamenamenamenamenamenamename',
        //       desc: 'descdescdescdescdescdescdescdescdescdescdescdescdescdesc',
        //       isService: true),
        //   MaterialModel(id: 00, name: 'name', desc: 'desc', isService: true)
        // ];
        outlayTypeIsLoading.value = false;

        return failure.message;
      }, (newOutlays) async {
        outlayTypes.value = newOutlays;
        print('xxxxxxxxxxxx${outlayTypes.length}');
        outlayTypeIsLoading.value = false;
        return '';
      });
    } else {
      outlayTypes.value = [];
      outlayTypeIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getOutlayType(int outlayTypeId) async {
    editOutlayTypeLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlayTypesRepo.getOutlayType(outlayTypeId)).fold(
          (failure) {
        print('failure');
        editOutlayTypeLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (outlayType) async {
        editOutlayTypeLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      editOutlayTypeLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> editOutlayType(OutlayType outlayType) async {
    editOutlayTypeLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlayTypesRepo.editOutlayType(outlayType)).fold((failure) {
        print('failure');
        editOutlayTypeLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (newOutlayType) async {
        // int x = 0;
        // for (OutlayType ot in outlayTypes) {
        //   print(x += 1);
        //   print('lllllllllllllllllllllllllllllllllllllllllllll${ot.id}');
        // }
        final index = outlayTypes.indexWhere((element) {
          //print('element${element.id}');
          print('object');
          return element.id == newOutlayType.id;
        });
        print('xxxxxxxxxxxx${outlayTypes.length}');
        print('new${newOutlayType.id}');
        print(outlayType.id);
        print('bbbbbbbbbbbbbbbbbbbbbbbbbb');
        print(index);
        outlayTypes[index] = newOutlayType;
        editOutlayTypeLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      editOutlayTypeLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> deleteOutlayType(int outlayTypeId) async {
    editOutlayTypeLoading.value = true;

    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await outlayTypesRepo.deleteOutlayType(outlayTypeId)).fold(
          (failure) {
        print('failure');
        editOutlayTypeLoading.value = false;
        print(failure.message);
        return failure.message == 'Error Deleteing Data'
            ? 'This Outlay Type is in use so you can\'t delete it'
            : failure.message;
      }, (deletedOutlayType) async {
        outlayTypes.removeWhere((element) {
          final myOutlayType = element;
          return deletedOutlayType.id == myOutlayType.id;
        });
        editOutlayTypeLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      editOutlayTypeLoading.value = false;
      return 'No internet connection';
    }
  }
}
