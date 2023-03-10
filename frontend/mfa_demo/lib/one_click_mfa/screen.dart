import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'on_click_login_request.dart';

class OneClickScreen extends StatefulWidget {
  const OneClickScreen({super.key});

  @override
  State<OneClickScreen> createState() => _OneClickScreenState();
}

class _OneClickScreenState extends State<OneClickScreen> {
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Flutter One Click MFA"),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          SizedBox(
            width: 40,
            height: 40,
            child: Image.asset("assets/avatar/a.jpg"),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () async {
                  try {
                    OneClickLoginRequest request = OneClickLoginRequest();
                    request.userinfo = "xiaoshuyui";
                    request.loginTime =
                        DateTime.now().millisecondsSinceEpoch ~/ 1000;
                    Response r = await dio.post(
                        "http://127.0.0.1:15285/oneClick/second",
                        data: request.toJson());
                    if (r.data != null) {
                      SmartDialog.showToast(r.data.toString());
                    }
                  } catch (e) {
                    debugPrint(e.toString());
                    SmartDialog.showToast("unknow error");
                  }
                },
                child: const Text("确定")),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
