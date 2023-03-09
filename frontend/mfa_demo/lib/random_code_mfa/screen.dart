import 'dart:math';

import 'package:flutter/material.dart';

import 'note.dart';
import 'count_down.dart';

class RandomCodeMfa extends StatefulWidget {
  const RandomCodeMfa({super.key});

  @override
  State<RandomCodeMfa> createState() => _RandomCodeMfaState();
}

const String userinfo = "xiaoshuyui";

class _RandomCodeMfaState extends State<RandomCodeMfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Flutter Random Code MFA"),
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
            const Text("Enter this code to confirm your sign in as:"),
            const SizedBox(
              height: 20,
            ),
            _buildSelectUser(),
            const SizedBox(
              height: 20,
            ),
            _buildCenter()
          ],
        ),
      ),
    );
  }

  Widget _buildSelectUser() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 109, 156, 237),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
                image:
                    DecorationImage(image: AssetImage("assets/avatar/a.jpg"))),
            width: 60,
            height: 60,
            // child: Image.asset("assets/avatar/a.jpg"),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                userinfo,
                style: TextStyle(fontSize: 25),
              ),
              Text("Bala Bala")
            ],
          ),
          const Expanded(child: SizedBox()),
          Transform.rotate(
            angle: pi / 2,
            child: const Icon(
              Icons.chevron_right,
              size: 30,
            ),
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }

  Widget _buildCenter() {
    return SizedBox(
      height: 200,
      child: Navigator(
        initialRoute: "/",
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case "/":
              builder = (context) => const NoteWidget();
              break;
            default:
              builder = (context) => const CountDownWidget();
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
