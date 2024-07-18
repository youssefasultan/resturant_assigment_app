import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  NetworkService._();

  static Future<bool> isConnected() async {
    try {
      final result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on Exception catch (_) {
      return false;
    }
  }
}
