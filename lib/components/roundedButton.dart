import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final Function() onPressed;
  final String title;

  RoundedButton({
    @required this.color,
    @required this.onPressed,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 300,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
