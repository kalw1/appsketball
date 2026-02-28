import 'package:appsketball/widgets/list_button.dart';
import 'package:flutter/material.dart';
import 'package:appsketball/screens/game_screen.dart';
import 'package:flutter/services.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {@override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListButton(
              text: 'Teams',
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreen()));
              }
            ),
            SizedBox(height: 20),
            ListButton(
              text: 'Game Settings',
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreen()));
              }
            ),
            SizedBox(height: 20),
            ListButton(
              text: 'Start Game',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
              }
            ),
          ],
        ),
      ),
    );
  }
}