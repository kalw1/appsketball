import 'package:appsketball/widgets/action_button.dart';
import 'package:appsketball/widgets/list_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:appsketball/models/player.dart';
import 'package:appsketball/models/team.dart';
import 'package:appsketball/services/player_game_service.dart';
import 'package:appsketball/screens/accredit_player_screen.dart';
import 'package:appsketball/screens/end_of_game.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var bgColor = Colors.white;

  Team teamA = Team(name: 'Team A', players: [
    Player(name: 'Player A1', jerseyNumber: 1),
    Player(name: 'Player A2', jerseyNumber: 2),
    Player(name: 'Player A3', jerseyNumber: 3),
    Player(name: 'Player A4', jerseyNumber: 4),
    Player(name: 'Player A5', jerseyNumber: 5),
  ]);

  Team teamB = Team(name: 'Team B', players: [
    Player(name: 'Player B1', jerseyNumber: 6),
    Player(name: 'Player B2', jerseyNumber: 7),
    Player(name: 'Player B3', jerseyNumber: 8),
    Player(name: 'Player B4', jerseyNumber: 9),
    Player(name: 'Player B5', jerseyNumber: 10),
  ]);

  PlayerGameService playerGameService = PlayerGameService();

  Future<Player?> navigateToAccreditPlayerScreen(Team team1, Team team2, String appBarText) async {
    if (appBarText.isNotEmpty) {
      appBarText += ' - Select Player';
    }
    return await Navigator.push<Player>(
      context,
      MaterialPageRoute(
        builder: (context) => AccreditPlayerScreen(teamA: team1, teamB: team2, appBarText: appBarText),
      ),
    );
  }

  Team getPlayerTeam(Player player) {
    if (teamA.players.contains(player)) {
      return teamA;
    } else {
      return teamB;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.landscapeRight,
    // ]);

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${teamA.name} - ${teamB.name}', style: TextStyle(fontSize: 24)),
            Text('${teamA.score} - ${teamB.score}', style: TextStyle(fontSize: 32)),
            GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ActionButton(
                  text: '2 Pointer Made',
                  onPressed: () async {
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, '2 Pointer Made');
                    Player? assister = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who assisted?');

                    if (selectedPlayer != null) {
                      playerGameService.recordFieldGoal(getPlayerTeam(selectedPlayer), selectedPlayer, true);
                      setState(() {});
                    }
                    if (assister != null) {
                      playerGameService.recordAssist(assister);
                    }
                  },
                ),
                ActionButton(
                  text: '3 Pointer Made',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, '3 Pointer Made');
                    Player? assister = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who assisted?');

                    if (selectedPlayer != null) {
                      playerGameService.recordThreePointer(getPlayerTeam(selectedPlayer), selectedPlayer, true);
                      setState(() {});
                    }
                    if (assister != null) {
                      playerGameService.recordAssist(assister);
                    }
                  },
                ),
                ActionButton(
                  text: 'Steal',
                  onPressed: () async{
                    Player? playerThatStole = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who stole the ball?');
                    Player? playerThatLostBall = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who lost the ball?');

                    if (playerThatStole != null && playerThatLostBall != null) {
                      playerGameService.recordSteal(playerThatStole, playerThatLostBall);
                    }
                  },
                ),
                ActionButton(
                  text: '2 Pointer Missed',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, '2 Pointer Missed');
                    Player? rebounder = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who got the rebound?');

                    if (selectedPlayer != null) {
                      playerGameService.recordFieldGoal(getPlayerTeam(selectedPlayer), selectedPlayer, false);
                      if (rebounder != null) {
                        playerGameService.recordRebound(rebounder, getPlayerTeam(selectedPlayer) != getPlayerTeam(rebounder));
                      }
                    }
                  },
                  backgroundColor: Colors.red,
                ),
                ActionButton(
                  text: '3 Pointer Missed',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, '3 Pointer Missed');
                    Player? rebounder = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who got the rebound?');

                    if (selectedPlayer != null) {
                      playerGameService.recordThreePointer(getPlayerTeam(selectedPlayer), selectedPlayer, false);
                      if (rebounder != null) {
                        playerGameService.recordRebound(rebounder, getPlayerTeam(selectedPlayer) != getPlayerTeam(rebounder));
                      }
                    }
                  },
                  backgroundColor: Colors.red,
                ),
                ActionButton(
                  text: 'Block',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, 'Blocked Shot');

                    if (selectedPlayer != null) {
                      playerGameService.recordBlock(selectedPlayer);
                    }
                  },
                ),
                ActionButton(
                  text: 'Turnover',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, 'Turnover');

                    if (selectedPlayer != null) {
                      playerGameService.recordTurnover(selectedPlayer);
                    }
                  },
                  backgroundColor: Colors.red,
                ),
                ActionButton(
                  text: 'Foul',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, 'Personal Foul');

                    if (selectedPlayer != null) {
                      playerGameService.recordPersonalFoul(selectedPlayer);
                    }
                  },
                  backgroundColor: Colors.red,
                ),
                ActionButton(
                  text: 'Free Throws',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, 'Free Throw Made');

                    if (selectedPlayer != null) {
                      playerGameService.recordFreeThrow(teamA, selectedPlayer, true);
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 200),
            ListButton(
              text: 'End Game',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EndOfGameScreen(teamA: teamA, teamB: teamB),
                  ),
                );
              },
              backgroundColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

