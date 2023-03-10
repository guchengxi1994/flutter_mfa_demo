class CodeLoginRequest {
  String? userinfo;
  String? code;

  CodeLoginRequest({this.userinfo, this.code});

  CodeLoginRequest.fromJson(Map<String, dynamic> json) {
    userinfo = json['userinfo'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userinfo'] = userinfo;
    data['code'] = code;
    return data;
  }
}
