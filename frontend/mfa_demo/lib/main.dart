import 'package:flutter/material.dart';

import 'random_code_mfa/screen.dart';

void main() {
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
