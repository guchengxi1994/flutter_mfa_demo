import 'dart:convert';

import 'package:crypto/crypto.dart';

class CommonUtils {
  CommonUtils._();

  static String md5_(String s) {
    return md5.convert(utf8.encode(s)).toString();
  }
}
