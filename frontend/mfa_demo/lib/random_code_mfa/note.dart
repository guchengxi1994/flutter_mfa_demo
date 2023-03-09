import 'package:flutter/material.dart';
import 'package:mfa_demo/random_code_mfa/count_down.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 212, 212, 209),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text("SECURITY NOTE:"),
          const Text(
              "You should only need to enter a code if \nyour phone doesn't have internet access."),
          const SizedBox(
            height: 20,
          ),
          const Text("Never give your code to another user or website"),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const CountDownWidget();
              }));
            },
            child: Container(
              height: 40,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(5)),
              child: const Center(
                child: Text("Show Random Code"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
