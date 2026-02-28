import 'package:flutter/material.dart';
import 'package:appsketball/models/team.dart';
import 'package:appsketball/widgets/list_button.dart';

class EndOfGameScreen extends StatelessWidget {
  final Team teamA;
  final Team teamB;
  final bool isEndOfGame;

  const EndOfGameScreen({
    super.key,
    required this.teamA,
    required this.teamB,
    this.isEndOfGame = true,
  });

  @override
  Widget build(BuildContext context) {
    Team teamA = this.teamA;
    Team teamB = this.teamB;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEndOfGame ? 'End of Game' : 'Game Stats'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${teamA.name} Score: ${teamA.score}', style: TextStyle(fontSize: 24)),
            Table(
              border: TableBorder.all(width: 1, color: Colors.black),
              children: [
                const TableRow(children: [Text('Name'),Text('Pts'), Text('Ast'), Text('DReb'), Text('OReb'), Text('Stl'), Text('Blk'), Text('TO'), Text('PF'), Text('FG/FGM'), Text('3P/3PM'), Text('FT/FTM')]),
                ...List.generate(teamA.players.length, (i) {
                  return TableRow(children: [
                    Text(teamA.players[i].name),
                    Text('${teamA.players[i].points}'),
                    Text('${teamA.players[i].assists}'),
                    Text('${teamA.players[i].defRebounds}'),
                    Text('${teamA.players[i].offRebounds}'),
                    Text('${teamA.players[i].steals}'),
                    Text('${teamA.players[i].blocks}'),
                    Text('${teamA.players[i].turnovers}'),
                    Text('${teamA.players[i].personalFouls}'),
                    Text('${teamA.players[i].fieldGoalsMade}/${teamA.players[i].fieldGoalsAttempted}'),
                    Text('${teamA.players[i].threePointersMade}/${teamA.players[i].threePointersAttempted}'),
                    Text('${teamA.players[i].freeThrowsMade}/${teamA.players[i].freeThrowsAttempted}'),
                  ]);
                }),
              ],
            ),
            SizedBox(height: 16),
            Text('${teamB.name} Score: ${teamB.score}', style: TextStyle(fontSize: 24)),
            Table(
              border: TableBorder.all(width: 1, color: Colors.black),
              children: [
                const TableRow(children: [Text('Name'),Text('Pts'), Text('Ast'), Text('DReb'), Text('OReb'), Text('Stl'), Text('Blk'), Text('TO'), Text('PF'), Text('FG/FGM'), Text('3P/3PM'), Text('FT/FTM')]),
                ...List.generate(teamB.players.length, (i) {
                  return TableRow(children: [
                    Text(teamB.players[i].name),
                    Text('${teamB.players[i].points}'),
                    Text('${teamB.players[i].assists}'),
                    Text('${teamB.players[i].defRebounds}'),
                    Text('${teamB.players[i].offRebounds}'),
                    Text('${teamB.players[i].steals}'),
                    Text('${teamB.players[i].blocks}'),
                    Text('${teamB.players[i].turnovers}'),
                    Text('${teamB.players[i].personalFouls}'),
                    Text('${teamB.players[i].fieldGoalsMade}/${teamB.players[i].fieldGoalsAttempted}'),
                    Text('${teamB.players[i].threePointersMade}/${teamB.players[i].threePointersAttempted}'),
                    Text('${teamB.players[i].freeThrowsMade}/${teamB.players[i].freeThrowsAttempted}'),
                  ]);
                }),
              ],
            ),
            SizedBox(height: 16),
            ListButton(
              text: isEndOfGame ? 'Close Game' : 'Back',
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}