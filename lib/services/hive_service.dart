import 'package:hive_flutter/hive_flutter.dart';

class HiveService {

  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  Future<void> init() async {
    await Hive.initFlutter();

    final playerBox = await Hive.openBox('players');
    final teamBox = await Hive.openBox('teams');

    
  }
}