import 'dart:async';
import 'package:appsketball/widgets/action_button.dart';
import 'package:appsketball/widgets/list_button.dart';
import 'package:flutter/material.dart';
import 'package:appsketball/models/player.dart';
import 'package:appsketball/models/team.dart';
import 'package:appsketball/services/player_game_service.dart';
import 'package:appsketball/screens/accredit_player_screen.dart';
import 'package:appsketball/screens/end_of_game.dart';
import 'package:audioplayers/audioplayers.dart';

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

  Future<Player?> navigateToAccreditPlayerScreen(Team team1, Team? team2, String appBarText, {bool showNoOneButton = false, Color buttonColor = Colors.blue}) async {
    if (appBarText.isNotEmpty) {
      appBarText += ' - Select Player';
    }
    return await Navigator.push<Player>(
      context,
      MaterialPageRoute(
        builder: (context) => AccreditPlayerScreen(teamA: team1, teamB: team2, appBarText: appBarText, showNoOneButton: showNoOneButton, buttonColor: buttonColor),
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

  Team getPlayerOppositeTeam(Player player) {
    if (teamA.players.contains(player)) {
      return teamB;
    } else {
      return teamA;
    }
  }

  Duration quarterDuration = Duration(seconds: 5);

  Duration currentDuration = Duration(seconds: 5);

  bool isGamePaused = true;

  late Timer timer;

  final AudioPlayer audioPlayer = AudioPlayer();

  void _startTimer() {
    setState(() {
      isGamePaused = false;
    });
    if (currentDuration <= Duration.zero) {
      setState(() {
        currentDuration = Duration(seconds: quarterDuration.inSeconds);
      });
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (currentDuration > Duration.zero) {
          currentDuration -= Duration(seconds: 1);
        } else {
          audioPlayer.play(AssetSource('buzzer.mp3'), volume: 1.0);
          timer.cancel();
          isGamePaused = true;
        }
      });
    });
  }

  void _stopTimer() {
    setState(() {
      isGamePaused = true;
    });
    timer.cancel();
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('${teamA.name} - ${teamB.name}', style: TextStyle(fontSize: 24)),
            Text('${teamA.score} - ${teamB.score}', style: TextStyle(fontSize: 32)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${currentDuration.inMinutes}:${(currentDuration.inSeconds % 60).toString().padLeft(2, '0')}", style: TextStyle(fontSize: 32)),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: isGamePaused ? _startTimer : _stopTimer,
                  child: Text(isGamePaused ? "Start" : "Pause"),
                ),
              ],
            ),
            GridView.count(
              padding: const EdgeInsets.all(16),
              crossAxisCount: 3,
              childAspectRatio: 1,
              crossAxisSpacing: 8,
              mainAxisSpacing: 5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ActionButton(
                  text: '2 Pointer Made',
                  onPressed: () async {
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, '2 Pointer Made');

                    if (selectedPlayer != null) {
                      Team playerTeam = getPlayerTeam(selectedPlayer);
                      playerGameService.recordFieldGoal(playerTeam, selectedPlayer, true);

                      Player? assister = await navigateToAccreditPlayerScreen(playerTeam, null, 'Who assisted?', showNoOneButton: true, buttonColor: playerTeam == teamA ? Colors.blue : Colors.red);
                      if (assister != null) {
                        playerGameService.recordAssist(assister);
                      }
                      setState(() {});
                    }
                  },
                ),
                ActionButton(
                  text: '3 Pointer Made',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, '3 Pointer Made');

                    if (selectedPlayer != null) {
                      Team playerTeam = getPlayerTeam(selectedPlayer);
                      playerGameService.recordThreePointer(playerTeam, selectedPlayer, true);
                      setState(() {});

                      Player? assister = await navigateToAccreditPlayerScreen(playerTeam, null, 'Who assisted?', showNoOneButton: true, buttonColor: playerTeam == teamA ? Colors.blue : Colors.red);
                      if (assister != null) {
                        playerGameService.recordAssist(assister);
                      }
                    }
                  },
                ),
                ActionButton(
                  text: 'Steal',
                  onPressed: () async{
                    Player? playerThatStole = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who stole the ball?');

                    if (playerThatStole != null) {
                      Team playerOppositeTeam = getPlayerOppositeTeam(playerThatStole);
                      Player? playerThatLostBall = await navigateToAccreditPlayerScreen(playerOppositeTeam, null, 'Who lost the ball?', buttonColor: playerOppositeTeam == teamA ? Colors.blue : Colors.red);
                      if (playerThatLostBall != null) {
                        playerGameService.recordSteal(playerThatStole, playerThatLostBall);
                      }
                    }
                  },
                ),
                ActionButton(
                  text: '2 Pointer Missed',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, '2 Pointer Missed');
                    Player? rebounder = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who got the rebound?', showNoOneButton: true);

                    if (selectedPlayer != null) {
                      Team playerTeam = getPlayerTeam(selectedPlayer);
                      playerGameService.recordFieldGoal(playerTeam, selectedPlayer, false);
                      if (rebounder != null) {
                        playerGameService.recordRebound(rebounder, playerTeam != getPlayerTeam(rebounder));
                      }
                    }
                  },
                  backgroundColor: Colors.red,
                ),
                ActionButton(
                  text: '3 Pointer Missed',
                  onPressed: () async{
                    Player? selectedPlayer = await navigateToAccreditPlayerScreen(teamA, teamB, '3 Pointer Missed');
                    Player? rebounder = await navigateToAccreditPlayerScreen(teamA, teamB, 'Who got the rebound?', showNoOneButton: true);

                    if (selectedPlayer != null) {
                      Team playerTeam = getPlayerTeam(selectedPlayer);
                      playerGameService.recordThreePointer(playerTeam, selectedPlayer, false);
                      if (rebounder != null) {
                        playerGameService.recordRebound(rebounder, playerTeam != getPlayerTeam(rebounder));
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
                SizedBox(),
                ActionButton(
                  text: 'View Stats',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EndOfGameScreen(teamA: teamA, teamB: teamB, isEndOfGame: false),
                      ),
                    );
                  },
                  backgroundColor: Colors.blue,
                ),
              ],
            ),
            //SizedBox(height: 200),
            ListButton(
              text: 'End Game',
              onPressed: () {
                AlertDialog endGameDialog = AlertDialog(
                  title: Text('End Game'),
                  content: Text('Are you sure you want to end the game?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EndOfGameScreen(teamA: teamA, teamB: teamB),
                          ),
                        );
                      },
                      child: Text('Confirm'),
                    ),
                  ],
                );
                showDialog(
                  context: context,
                  builder: (context) => endGameDialog,
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

