import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final dynamic onPressed;
  final bool isInverted;

  const Button({super.key, required this.text, required this.onPressed, this.isInverted = false});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: isInverted ? DColors.white : DColors.primary3,
            foregroundColor: isInverted ? DColors.primary3 : DColors.white,
            minimumSize: Size.fromHeight(height * 0.075),
            elevation: isInverted ? 0 : null
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, decoration: isInverted ? TextDecoration.underline : null),
        ));
  }
}
