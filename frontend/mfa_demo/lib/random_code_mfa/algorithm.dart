import 'package:mfa_demo/utils/common.dart';

/// 根据时间戳和当前用户身份信息生成随机的字符串
/// 然后与服务器交互；服务器收到请求后采用相同算法
/// 验证这个随机code是否合法
///
/// [理论上不需要网络连接]
///
/// 这里考虑用[MD5]以及[每15秒]（1分钟内4次循环，
/// 例如12:15:00开始，12:15:15为一个周期）
///
/// [15s]是我觉得自己手比较慢
///
/// 理论上算法需要采用别的安全性更高的，不过由于
/// 是demo就提供一个思路

class Algorithm {
  /// 15s 的间隔
  static const periodDuration = 15;

  /// 5 位随机
  static const codeLength = 5;

  /// 获取剩余时间
  static int getRestTime(DateTime current) {
    final currentSecond = current.second;
    return periodDuration - currentSecond % periodDuration;
  }

  /// 生成随机code
  ///
  /// [userinfo] 可以自定义，demo里写死
  static String generateCode(dynamic userinfo, DateTime current) {
    return CommonUtils.md5_(userinfo.toString() +
            (current.millisecondsSinceEpoch ~/ 1000).toString())
        .substring(0, codeLength)
        .toUpperCase();
  }

  static AlgotithmContent generate(dynamic userinfo) {
    final current = DateTime.now();
    final restTime = getRestTime(current);
    final String code;
    if (restTime == 0) {
      code = generateCode(userinfo, current);
    } else {
      code = generateCode(userinfo,
          current.subtract(Duration(seconds: periodDuration - restTime)));
    }

    return AlgotithmContent(code: code, restSeconds: restTime);
  }
}

/// 一个周期产生的验证信息
///
/// [restSeconds] 剩余的时间
///
/// [code] 生成的随机code
class AlgotithmContent {
  int restSeconds;
  String code;

  AlgotithmContent({required this.code, required this.restSeconds});

  /// 重新生成一个
  void regenerate(dynamic userinfo) {
    final r = Algorithm.generate(userinfo);
    restSeconds = r.restSeconds;
    code = r.code;
  }

  @override
  String toString() {
    return code.toString();
  }
}
