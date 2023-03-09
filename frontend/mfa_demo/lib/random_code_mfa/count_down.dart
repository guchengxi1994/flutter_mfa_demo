import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:mfa_demo/random_code_mfa/algorithm.dart';
import 'package:mfa_demo/random_code_mfa/algorithm_controller.dart';
import 'package:provider/provider.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget({super.key});

  @override
  State<CountDownWidget> createState() => _CountDownWidgetState();
}

class _CountDownWidgetState extends State<CountDownWidget> {
  CountDownController controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlgoController()..init())
      ],
      builder: (ctx, child) {
        return InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {},
          child: CircularCountDownTimer(
            controller: controller,
            onComplete: () {
              ctx.read<AlgoController>().init();
              controller.restart();
            },
            width: 180,
            height: 180,
            initialDuration: Algorithm.periodDuration -
                ctx.select<AlgoController, int>(
                    (value) => value.algotithmContent?.restSeconds ?? 0),
            isTimerTextShown: false,
            duration: Algorithm.periodDuration,
            fillColor: Colors.grey[300]!,
            ringColor: Colors.purpleAccent[100]!,
            customWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(ctx.select<AlgoController, String>(
                    (value) => value.algotithmContent?.code ?? "")),
                const Text("Tap to copy")
              ],
            ),
          ),
        );
      },
    );
  }
}
