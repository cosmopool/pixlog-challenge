import 'dart:io';

class NetworkInfoService {
  static Future<bool> get isConnected async {
    try {
      await InternetAddress.lookup('exemple.com');
      return true;
    } on SocketException catch (_) {
      return false;
    }
  }
}
