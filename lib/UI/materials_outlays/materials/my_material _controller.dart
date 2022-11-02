import 'package:e_family_expenses/UI/constants.dart';
import 'package:e_family_expenses/domain/models/outlay.dart';
import 'package:e_family_expenses/domain/repositories/material_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/network/network_info.dart';

class MyMaterialController extends GetxController {
  final materialsRepo = MaterialsRepo();
  RxBool createMaterialIsLoading = false.obs;
  RxBool isService = false.obs;
  RxBool materialIsLoading = false.obs;
  RxBool editMaterialsLoading = false.obs;

  final GetStorage _box = GetStorage();
  RxList materials = [].obs;
  InternetConnection connection = InternetConnection();
  testInternetConnetion() {
    return connection.hasNetwork();
  }

  changeisServiceStatus() {
    isService.value = !isService.value;
  }

  Future<String> addMaterial(MaterialModel material) async {
    createMaterialIsLoading.value = true;

    final isConnected = await testInternetConnetion();
    if (isConnected) {
      return (await materialsRepo.addMaterial(material)).fold((failure) {
        print(failure.message);
        createMaterialIsLoading.value = false;
        return failure.message;
      }, (material) async {
        materials.add(material);
        createMaterialIsLoading.value = false;
        return '';
      });
    } else {
      createMaterialIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getMaterials() async {
    print('getMaterials controller start');
    materialIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await materialsRepo.getMaterials()).fold((failure) {
        print('failure response');
        materials.value = [];
        materialIsLoading.value = false;
        return failure.message;
      }, (newMaterial) async {
        print('data response');
        materials.value = newMaterial;
        materialIsLoading.value = false;
        return '';
      });
    } else {
      print('not connected');
      print('failure');
      materials.value = [];
      materialIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getMaterialsById() async {
    materialIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      print(GetStorage().read('id'));
      print(GetStorage().read(Constants.headFamilyId));
      return (await materialsRepo.getMaterialsById(
              GetStorage().read(Constants.isHeadFamily)
                  ? GetStorage().read(Constants.id)
                  : GetStorage().read(Constants.headFamilyId) ?? ''))
          .fold((failure) {
        print('failure');
        materials.value = [];

        materialIsLoading.value = false;

        return failure.message;
      }, (material) async {
        materials.value = material;

        materialIsLoading.value = false;
        return '';
      });
    } else {
      materials.value = [];
      materialIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getMaterial(int materialId) async {
    editMaterialsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await materialsRepo.getmaterial(materialId)).fold((failure) {
        print('failure');
        editMaterialsLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (material) async {
        editMaterialsLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      materialIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future editMaterial(MaterialModel material) async {
    editMaterialsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await materialsRepo.editMaterial(material)).fold((failure) {
        print('failurehe');
        editMaterialsLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (material) async {
        final index = materials.indexWhere((element) {
          return element.id == material.id;
        });
        materials[index] = material;
        editMaterialsLoading.value = false;
        return '';
      });
    } else {
      print('failureco');
      materialIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> deleteMaterial(int materialId) async {
    editMaterialsLoading.value = true;

    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await materialsRepo.deleteMaterial(materialId)).fold((failure) {
        print('mmm$materialId');
        print('failurefff');
        editMaterialsLoading.value = false;
        print(failure.message);
        return failure.message == 'Error Deleteing Data'
            ? 'This Material is in use so you can\'t delete it'
            : failure.message;
      }, (deletedMaterial) async {
        materials.removeWhere((element) {
          final myMaterial = element;
          return deletedMaterial.id == myMaterial.id;
        });
        editMaterialsLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      editMaterialsLoading.value = false;
      return 'No internet connection';
    }
  }
}
