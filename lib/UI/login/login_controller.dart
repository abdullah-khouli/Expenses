import 'package:e_family_expenses/UI/constants.dart';
import 'package:e_family_expenses/UI/login/login_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/network/network_info.dart';
import '../../domain/models/login.dart';
import '../../domain/repositories/login_reppsitory.dart';

class LoginController extends GetxController {
  final GetStorage _box = GetStorage();
  RxBool sinupIsloading = false.obs;
  RxBool sininIsloading = false.obs;
  RxBool changePassIsloading = false.obs;
  RxBool hidePassword = true.obs;
  RxBool rememberMe = true.obs;
  bool isLoggedin = false;
  final loginRepo = LoginRepo();
  InternetConnection connection = InternetConnection();
  testInternetConnetion() {
    return connection.hasNetwork();
  }

  changeHidePasswordStatus() {
    hidePassword.value = !hidePassword.value;
  }

  changerememberMeStatus() {
    rememberMe.value = !rememberMe.value;
  }

  Future<String> signUp(LoginModel logModel) async {
    sinupIsloading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      return (await loginRepo.signUp(logModel)).fold((failure) {
        sinupIsloading.value = false;
        return failure.message;
      }, (loginModel) async {
        await _box.write(Constants.id, loginModel.id);
        await _box.write(Constants.userName, logModel.userName);
        await _box.write(Constants.isHeadFamily, true);
        await _box.write(Constants.isLoggedin, true);
        await _box.write(Constants.headFamilyId, loginModel.headFamilyId);

        sinupIsloading.value = false;
        return '';
      });
    } else {
      sinupIsloading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> signin(LoginModel logModel) async {
    sininIsloading.value = true;
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      return (await loginRepo.signin(logModel)).fold((failure) {
        sininIsloading.value = false;
        print('failure2');
        print(failure.message);
        return failure.message;
      }, (userData) async {
        print(userData);
        await _box.write(Constants.id, userData['id']);
        await _box.write('userName', logModel.userName);
        await _box.write(
            Constants.isHeadFamily, userData['IsHeadfamily'] == "True");
        await _box.write(Constants.headFamilyId, userData['HeadfamilyID']);
        if (rememberMe.value) {
          await _box.write(Constants.isLoggedin, true);
        }
        sininIsloading.value = false;
        return '';
      });
    } else {
      sininIsloading.value = false;
      return 'No internet connection';
    }
  }

  Future<String> changePassword(
      {required String oldPass, required String newPass}) async {
    changePassIsloading.value = true;
    final id = _box.read(Constants.id);
    final isConnected = await testInternetConnetion();
    if (isConnected) {
      return (await loginRepo.changePassword(
              Passwords(old: oldPass, newPass: newPass, id: id)))
          .fold((failure) {
        changePassIsloading.value = false;
        return failure.message;
      }, (_) async {
        changePassIsloading.value = false;
        return '';
      });
    } else {
      changePassIsloading.value = false;
      return 'No internet connection';
    }
  }

  logout() async {
    await _box.erase();
    Get.offAll(const LoginScreen());
  }
}
