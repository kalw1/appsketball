import 'package:appsketball/models/player.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'team.g.dart';

@HiveType(typeId: 1)
class Team {
  @HiveField(0)
  String name;

  @HiveField(1)
  int score;

  @HiveField(2)
  List<Player> players;

  Team({
    required this.name,
    required this.score,
    required this.players,
  });
}