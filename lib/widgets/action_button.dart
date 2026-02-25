import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.deepPurple,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox (
      width: 150,
      height: 150,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 12,
          ),
          
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}