import 'dart:convert';

import 'package:crypto/crypto.dart';

class UserManager {
  static String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Map<String, String> users = {
    'user': hashPassword('user123'),
  };
}
