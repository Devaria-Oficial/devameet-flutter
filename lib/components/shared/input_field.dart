import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum InputType {
  text,
  password
}

class InputField extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final String iconPath;
  final Stream<String>? stream;
  final String? initialValue;
  final InputType? inputType;


  const InputField(
      {super.key, required this.hint, required this.iconPath, required this.onChanged, this.stream, this.initialValue, this.inputType = InputType.text});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: DColors.primary3, width: 1))),
                child: TextFormField(
                  style: TextStyle(color: DColors.primary3),
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      icon: SvgPicture.asset(iconPath),
                      hintText: hint,
                      hintStyle: TextStyle(color: DColors.grey2),
                      border: InputBorder.none),
                  initialValue: initialValue,
                  onChanged: onChanged,
                  obscureText: inputType == InputType.password,
                ),
              ),
              if (snapshot.hasError) Text(snapshot.error.toString(), style: TextStyle(color: DColors.redError),)
            ],
          );
        });
  }
}
