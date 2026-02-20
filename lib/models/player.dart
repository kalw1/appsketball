import 'package:hive_flutter/hive_flutter.dart';

part 'player.g.dart';

@HiveType(typeId: 0)
class Player {
  @HiveField(0)
  String name;

  @HiveField(1)
  int jerseyNumber;

  @HiveField(2)
  int points;

  @HiveField(3)
  int assists;

  @HiveField(4)
  int defRebounds;

  @HiveField(5)
  int offRebounds;

  @HiveField(6)
  int steals;

  @HiveField(7)
  int blocks;

  @HiveField(8)
  int personalFouls;

  @HiveField(9)
  int fieldGoalsMade;

  @HiveField(10)
  int fieldGoalsAttempted;

  @HiveField(11)
  int threePointersMade;

  @HiveField(12)
  int threePointersAttempted;

  @HiveField(13)
  int freeThrowsMade;

  @HiveField(14)
  int freeThrowsAttempted;

  @HiveField(15)
  int turnovers;

  Player({
    required this.name,
    required this.jerseyNumber,
    this.points = 0,
    this.assists = 0,
    this.steals = 0,
    this.blocks = 0,
    this.defRebounds = 0,
    this.offRebounds = 0,
    this.fieldGoalsMade = 0,
    this.fieldGoalsAttempted = 0,
    this.threePointersMade = 0,
    this.threePointersAttempted = 0,
    this.freeThrowsMade = 0,
    this.freeThrowsAttempted = 0,
    this.turnovers = 0,
    this.personalFouls = 0,
  });
}