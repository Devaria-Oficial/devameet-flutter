import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;

  const Button({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return ElevatedButton(
        onPressed: () => {},
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: DColors.primary3,
            foregroundColor: DColors.white,
            minimumSize: Size.fromHeight(height * 0.075)),
        child: Text(
          text,
          style: TextStyle(fontSize: 16),
        ));
  }
}
