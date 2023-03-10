class OneClickLoginRequest {
  String? userinfo;
  int? loginTime;

  OneClickLoginRequest({this.userinfo, this.loginTime});

  OneClickLoginRequest.fromJson(Map<String, dynamic> json) {
    userinfo = json['userinfo'];
    loginTime = json['login_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userinfo'] = userinfo;
    data['login_time'] = loginTime;
    return data;
  }
}
