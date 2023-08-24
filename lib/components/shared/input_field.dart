import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputField extends StatelessWidget {

  final String hint;
  final String iconPath;

  const InputField({super.key, required this.hint, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: DColors.primary3, width: 1))
      ),
      child: TextFormField(
        style: TextStyle(color: DColors.primary3),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            icon: SvgPicture.asset(iconPath),
            hintText: hint,
            hintStyle: TextStyle(color: DColors.grey2),
            border: InputBorder.none
        ),
      ),
    );
  }

}