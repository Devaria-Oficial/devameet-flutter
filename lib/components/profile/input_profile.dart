import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputProfile extends StatelessWidget {
  final String label;
  final Stream? stream;
  const InputProfile({super.key, required this.label, this.stream});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Text(label,
            style: TextStyle(
              color: DColors.grey3,
              fontSize: 14,
              fontWeight: FontWeight.w400
            ),
            )),
        Expanded(
          flex: 7,
          child: StreamBuilder(
            stream: stream,
            builder: (context, snapshot) {

              if (snapshot.hasData && snapshot.data != "") {
                return TextFormField(
                  initialValue: snapshot.data,
                  decoration: const InputDecoration(border: InputBorder.none),
                );
              }

              return LinearProgressIndicator();

            }
          ),
        ),
        Expanded(child: SvgPicture.asset("assets/icons/x-circle.svg")),
      ],
    );
  }
}
