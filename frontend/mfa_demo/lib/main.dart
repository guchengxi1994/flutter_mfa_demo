import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:window_size/window_size.dart';

import 'one_click_mfa/screen.dart';
import 'random_code_mfa/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMaxSize(const Size(480, 800));
    setWindowMinSize(const Size(480, 800));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter MFA Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      home: const MyHomePage(title: 'Flutter MFA Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _wrapper(ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const RandomCodeMfa();
                }));
              },
              title: const Text("Flutter Random Code MFA"),
              trailing: const Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
            )),
            _wrapper(ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const OneClickScreen();
                }));
              },
              title: const Text("Flutter One Click MFA"),
              trailing: const Icon(
                Icons.navigate_next,
                color: Colors.black,
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _wrapper(Widget w) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 6,
      child: w,
    );
  }
}
