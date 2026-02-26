import 'package:flutter/material.dart';
import 'package:appsketball/models/team.dart';
import 'package:appsketball/widgets/action_button.dart';

class AccreditPlayerScreen extends StatefulWidget {
  final Team teamA;
  final Team teamB;
  final String appBarText;

  const AccreditPlayerScreen({
    super.key,
    required this.teamA,
    required this.teamB,
    this.appBarText = 'Select Player',
  });

  @override
  State<AccreditPlayerScreen> createState() => _AccreditPlayerScreenState();
}

class _AccreditPlayerScreenState extends State<AccreditPlayerScreen> {
  Widget? noOneButton() {
    if (widget.appBarText.contains('assist') || widget.appBarText.contains('rebound')) {
      return ActionButton(
        onPressed: () {Navigator.pop(context, null);},
        text: 'No one',
        backgroundColor: Colors.grey
      );
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    Team teamA = widget.teamA;
    Team teamB = widget.teamB;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarText),
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
              children: [
                ...List.generate(teamA.players.length, (i) {
                  return ActionButton(
                    onPressed: () {Navigator.pop(context, teamA.players[i]);},
                    text: teamA.players[i].name,
                    backgroundColor: Colors.blue
                  );
                }),
                if (noOneButton() != null) noOneButton()!,
              ],
            ),
            SizedBox(height: 200),
            GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [...List.generate(teamB.players.length, (i) {
                return ActionButton(
                  onPressed: () {Navigator.pop(context, teamB.players[i]);},
                  text: teamB.players[i].name,
                  backgroundColor: Colors.red
                );
              }),
              if (noOneButton() != null) noOneButton()!,
              ]
            ),
          ],
        ),
      ),
    );
  }
}