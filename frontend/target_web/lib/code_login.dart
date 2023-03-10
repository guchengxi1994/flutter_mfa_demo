import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:target_web/code_login_request.dart';

class CodeLoginScreen extends StatefulWidget {
  const CodeLoginScreen({super.key});

  @override
  State<CodeLoginScreen> createState() => _CodeLoginScreenState();
}

class _CodeLoginScreenState extends State<CodeLoginScreen> {
  final controller = TextEditingController();
  final controller2 = TextEditingController();
  final dio = Dio();

  @override
  void initState() {
    super.initState();
    controller.text = "xiaoshuyui";
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
            SizedBox(
              width: 300,
              height: 50,
              child: TextField(
                controller: controller2,
                decoration: const InputDecoration(hintText: "mfa"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  try {
                    CodeLoginRequest request = CodeLoginRequest();
                    request.code = controller2.text;
                    request.userinfo = controller.text;
                    Response r = await dio.post(
                        "http://127.0.0.1:15285/codeMatch",
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
