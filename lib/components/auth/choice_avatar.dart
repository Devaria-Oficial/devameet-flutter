import 'package:devameet_flutter/components/shared/select_avatar.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fsp;

class ChoiceAvatar extends StatelessWidget {
  const ChoiceAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {

        return StreamBuilder(
          stream: state.form.getStream("avatar"),
          builder: (context, snapshot) {
            return Column(
              children: [
                Container(
                    width: height * 0.1875,
                    height: height * 0.1875,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: DColors.white,
                      border: Border.all(color: DColors.primary3, width: 3),
                      image:
                      state.form.getValue("avatar").toString().isEmpty ?
                      DecorationImage(
                        image: fsp.Svg("assets/icons/empty_avatar.svg"),
                        alignment: Alignment.bottomCenter,
                      ) :
                         DecorationImage(image: AssetImage("assets/devameet/Avatar/${state.form.getValue("avatar")}_front.png"), fit: BoxFit.contain)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: SizedBox.fromSize(
                              size: Size(height * 0.0625, height * 0.0625),
                              child: ClipOval(
                                  child: Material(
                                color: DColors.primary3,
                                child: InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    showDialog(context: context, builder: (_) => SelectAvatar(
                                      initialAvatar: state.form.getValue("avatar"),
                                      onSave: context.read<RegisterCubit>().changeAvatar,
                                    ));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset("assets/icons/edit.svg")
                                    ]
                                  )
                                ),
                              )),
                            ))
                      ],
                    )),
                if (snapshot.hasError) Text(snapshot.error.toString(), style: TextStyle(color: DColors.redError),)
              ],
            );
          }
        );
      }
    );
  }
}
