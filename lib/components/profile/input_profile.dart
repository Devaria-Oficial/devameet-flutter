import 'package:devameet_flutter/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputProfile extends StatelessWidget {
  final String label;
  final Stream? stream;
  final ValueChanged<String> onChanged;
  const InputProfile(
      {super.key, required this.label, this.stream, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Text(
                        label,
                        style: TextStyle(
                            color: DColors.grey3,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )),
                  Expanded(
                      flex: 7,
                      child: snapshot.hasData || snapshot.hasError
                          ? Column(
                              children: [
                                TextFormField(
                                  onChanged: onChanged,
                                  initialValue: snapshot.data,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ],
                            )
                          : LinearProgressIndicator()),
                  Expanded(
                      child: SvgPicture.asset("assets/icons/x-circle.svg")),
                ],
              ),
              if (snapshot.hasError)
                Text(
                  snapshot.error.toString(),
                  style: TextStyle(color: DColors.redError),
                )
            ],
          );
        });
  }
}
