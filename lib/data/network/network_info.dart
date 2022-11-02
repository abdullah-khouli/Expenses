import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class InternetConnection {
  Future<bool> hasNetwork() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //print('start');
      final ConnectivityResult result =
          await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        return hasInternet();
      } else {
        print('false');
        return false;
      }
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      print(e);
      return false;
    }
  }

  Future<bool> hasInternet() async {
    try {
      // final result = await InternetAddress.lookup('support.dell.com');
      final result = await InternetAddress.lookup('www.youtube.com');
      print('result= $result ===================================');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
// class NetworkInfoImpl {
//   final InternetConnectionChecker _internetConnectionChecker;

//   NetworkInfoImpl(this._internetConnectionChecker);

//   @override
//   Future<bool> get isConnected => _internetConnectionChecker.hasConnection;
// }
