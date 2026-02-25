import 'package:flutter/material.dart';
import 'package:appsketball/models/team.dart';
import 'package:appsketball/widgets/list_button.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SelectTeamSetup extends StatefulWidget {
  const SelectTeamSetup({super.key});

  @override
  State<SelectTeamSetup> createState() => _SelectTeamSetupState();
}

class _SelectTeamSetupState extends State<SelectTeamSetup> {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Team Setup'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListButton(
              text: 'Create New Team',
              onPressed: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => const StartScreen()));
              }
            ),
          ],
        ),
      ),
    );
  }
}
