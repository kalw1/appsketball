import 'package:appsketball/models/player.dart';
import 'package:appsketball/models/team.dart';

class PlayerGameService {
  void recordFieldGoal(Team team, Player player, bool made, {int points = 2}) {
    player.fieldGoalsAttempted++;
    if (made) {
      player.fieldGoalsMade++;
      player.points += points;
      team.score += points;
    }
  }

  void recordThreePointer(Team team, Player player, bool made, {int points = 3}) {
    player.threePointersAttempted++;
    player.fieldGoalsAttempted++;
    if (made) {
      player.threePointersMade++;
      player.fieldGoalsMade++;
      player.points += points;
      team.score += points;
    }
  }

  void recordFreeThrow(Team team, Player player, bool made, {int points = 1}) {
    player.freeThrowsAttempted++;
    if (made) {
      player.freeThrowsMade++;
      player.points += points;
      team.score += points;
    }
  }

  void recordAssist(Player player) {
    player.assists++;
  }

  void recordSteal(Player playerThatStole, Player playerThatLostBall) {
    playerThatStole.steals++;
    playerThatLostBall.turnovers++;
  }

  void recordBlock(Player player) {
    player.blocks++;
  }

  void recordTurnover(Player player) {
    player.turnovers++;
  }

  void recordPersonalFoul(Player player) {
    player.personalFouls++;
  }

  void recordRebound(Player player, bool isOffensive) {
    if (isOffensive) {
      player.offRebounds++;
    } else {
      player.defRebounds++;
    }
  }
}