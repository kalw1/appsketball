import 'package:appsketball/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var bgColor = Colors.white;

  final List<Widget> buttonCells = [
    ActionButton(
      text: '2 Pointer Made',
      onPressed: () {
        // Handle Team 1 action
      },
    ),
    ActionButton(
      text: '3 Pointer Made',
      onPressed: () {
        // Handle Team 2 action
      },
    ),
    ActionButton(
      text: 'Steal',
      onPressed: () {
        // Handle Team 1 action
      },
    ),
    ActionButton(
      text: '2 Pointer Missed',
      onPressed: () {
        // Handle Team 2 action
      },
      backgroundColor: Colors.red,
    ),
    ActionButton(
      text: '3 Pointer Missed',
      onPressed: () {
        // Handle Team 3 action
      },
      backgroundColor: Colors.red,
    ),
    ActionButton(
      text: 'Block',
      onPressed: () {
        // Handle Team 1 action
      },
    ),
    ActionButton(
      text: 'Turnover',
      onPressed: () {
        // Handle Team 2 action
      },
      backgroundColor: Colors.red,
    ),
    ActionButton(
      text: 'Foul',
      onPressed: () {
        // Handle Team 3 action
      },
      backgroundColor: Colors.red,
    ),
    ActionButton(
      text: 'Free Throws',
      onPressed: () {
        // Handle Team 3 action
      },
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Game Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: buttonCells,
            )
          ],
        ),
      ),
    );
  }
}

