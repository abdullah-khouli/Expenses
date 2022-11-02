import 'package:e_family_expenses/UI/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/network/network_info.dart';
import '../../domain/models/login.dart';
import '../../domain/repositories/login_reppsitory.dart';
import '../../domain/repositories/users_repository.dart';

class UsersController extends GetxController {
  final GetStorage _box = GetStorage();
  RxList users = [].obs;
  RxString userName = ''.obs;
  final loginRepo = LoginRepo();
  final userRepo = UsersRepo();
  RxBool hidePassword = true.obs;
  RxBool createUserIsLoading = false.obs;
  RxBool settingsIsLoading = false.obs;
  RxBool editUserIsLoading = false.obs;
  RxBool getUserIsLoading = false.obs;

  InternetConnection connection = InternetConnection();
  testInternetConnetion() {
    return connection.hasNetwork();
  }

  changeHidePasswordStatus() {
    hidePassword.value = !hidePassword.value;
  }

  Future<String> createUser(LoginModel logModel) async {
    createUserIsLoading.value = true;

    final isConnected = await testInternetConnetion();
    if (isConnected) {
      return (await userRepo.createUser(logModel)).fold((failure) {
        createUserIsLoading.value = false;
        return failure.message;
      }, (loginModel) async {
        users.add(loginModel);
        createUserIsLoading.value = false;
        return '';
      });
    } else {
      createUserIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getUsers() async {
    print('controller start');
    settingsIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await userRepo.getUsers()).fold((failure) {
        print('failure');
        users.value = [];
        settingsIsLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (usersData) async {
        users.value = usersData;
        print(usersData);
        settingsIsLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      users.value = [];
      settingsIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getUsersById() async {
    print('controller start');
    settingsIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await userRepo
              .getUsersById(GetStorage().read(Constants.id) ?? ''))
          .fold((failure) {
        print('failure');
        users.value = [];
        settingsIsLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (usersData) async {
        users.value = usersData;
        print(usersData);
        settingsIsLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      users.value = [];
      settingsIsLoading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> getUser(String userId) async {
    //editUserIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await userRepo.getUser(userId)).fold((failure) {
        print('failure');
        //  editUserIsLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (usersData) async {
        //   editUserIsLoading.value = false;
        return '';
      });
    } else {
      print('failure');
      // settingsIsLoading.value = false;
      return 'No internet connection';
    }
  }

  editUser(LoginModel userinfo, bool istheLoggedUser) async {
    editUserIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await userRepo.editUser(userinfo)).fold((failure) {
        print('failure');
        editUserIsLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (usersData) async {
        final index = users.indexWhere((element) {
          print('1');
          print(element.userName);
          return element.id == usersData.id;
        });
        print('object');
        print(users.length);
        if (istheLoggedUser) {
          _box.write(Constants.userName, usersData.userName);
          userName.value = usersData.userName;
        } else {
          users[index] = usersData;
        }
        editUserIsLoading.value = false;
        print('sucess');
        return '';
      });
    } else {
      print('failure');
      settingsIsLoading.value = false;
      return 'No internet connection';
    }
  }

  deleteUser(String userId) async {
    editUserIsLoading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      print('connected');
      return (await userRepo.deleteUser(userId)).fold((failure) {
        print('failuremm');
        editUserIsLoading.value = false;
        print(failure.message);
        return failure.message;
      }, (usersData) async {
        users.removeWhere((element) {
          return element.id == usersData.id;
        });
        editUserIsLoading.value = false;
        print('sucess');
        print(_box.read('id'));

        return '';
      });
    } else {
      print('failurerr');
      settingsIsLoading.value = false;
      return 'No internet connection';
    }
  }
}
