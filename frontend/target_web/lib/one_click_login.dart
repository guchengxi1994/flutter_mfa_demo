// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:target_web/on_click_login_request.dart';

class OneClickLoginScreen extends StatefulWidget {
  const OneClickLoginScreen({super.key});

  @override
  State<OneClickLoginScreen> createState() => _OneClickLoginScreenState();
}

class _OneClickLoginScreenState extends State<OneClickLoginScreen> {
  final controller = TextEditingController();
  final dio = Dio();

  Stream<String> loginStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      Response r =
          await dio.get("http://127.0.0.1:15285/oneClick/xiaoshuyui/canLogin");
      yield r.data.toString();
    }
  }

  late final listener;

  @override
  void initState() {
    super.initState();
    controller.text = "xiaoshuyui";
    listener = loginStream().listen((event) {
      if (event == "true") {
        SmartDialog.showToast("Log in");
        listener.cancel();
      }
    });
  }

  @override
  void dispose() {
    try {
      listener.cancel();
    } catch (_) {}

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Random Code MFA Login"),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: "userinfo",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  try {
                    OneClickLoginRequest request = OneClickLoginRequest();
                    request.userinfo = controller.text;
                    request.loginTime =
                        DateTime.now().millisecondsSinceEpoch ~/ 1000;
                    Response r = await dio.post(
                        "http://127.0.0.1:15285/oneClick/first",
                        data: request.toJson());
                    if (r.data != null) {
                      SmartDialog.showToast(r.data.toString());
                    }
                  } catch (e) {
                    debugPrint(e.toString());
                    SmartDialog.showToast("unknow error");
                  }
                },
                child: const Text("登录"))
          ],
        ),
      ),
    );
  }
}
