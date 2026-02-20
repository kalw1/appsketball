// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayerAdapter extends TypeAdapter<Player> {
  @override
  final int typeId = 0;

  @override
  Player read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Player(
      name: fields[0] as String,
      jerseyNumber: fields[1] as int,
      points: fields[2] as int,
      assists: fields[3] as int,
      steals: fields[6] as int,
      blocks: fields[7] as int,
      defRebounds: fields[4] as int,
      offRebounds: fields[5] as int,
      fieldGoalsMade: fields[9] as int,
      fieldGoalsAttempted: fields[10] as int,
      threePointersMade: fields[11] as int,
      threePointersAttempted: fields[12] as int,
      freeThrowsMade: fields[13] as int,
      freeThrowsAttempted: fields[14] as int,
      turnovers: fields[15] as int,
      personalFouls: fields[8] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Player obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.jerseyNumber)
      ..writeByte(2)
      ..write(obj.points)
      ..writeByte(3)
      ..write(obj.assists)
      ..writeByte(4)
      ..write(obj.defRebounds)
      ..writeByte(5)
      ..write(obj.offRebounds)
      ..writeByte(6)
      ..write(obj.steals)
      ..writeByte(7)
      ..write(obj.blocks)
      ..writeByte(8)
      ..write(obj.personalFouls)
      ..writeByte(9)
      ..write(obj.fieldGoalsMade)
      ..writeByte(10)
      ..write(obj.fieldGoalsAttempted)
      ..writeByte(11)
      ..write(obj.threePointersMade)
      ..writeByte(12)
      ..write(obj.threePointersAttempted)
      ..writeByte(13)
      ..write(obj.freeThrowsMade)
      ..writeByte(14)
      ..write(obj.freeThrowsAttempted)
      ..writeByte(15)
      ..write(obj.turnovers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
