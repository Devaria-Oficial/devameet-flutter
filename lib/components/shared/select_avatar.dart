import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectAvatar extends StatelessWidget {
  final String? initialAvatar;
  final dynamic onSave;
  const SelectAvatar({super.key, required this.onSave, this.initialAvatar});

  @override
  Widget build(BuildContext context) {
    print(initialAvatar);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => SelectAvatarCubit()..changeAvatar(initialAvatar ?? ""),
      child: BlocBuilder<SelectAvatarCubit, SelectAvatarState>(
        builder: (context, state) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
            ),
            insetPadding: EdgeInsets.symmetric(
              horizontal: width * 0.044444444444444,
              vertical: height * 0.1390625
            ),
            contentPadding: EdgeInsets.all(height * 0.025),
            titlePadding: EdgeInsets.only(top: height * 0.025, left: height * 0.025, right: height * 0.025),
            actionsPadding: EdgeInsets.only(bottom: height * 0.025, left: height * 0.025, right: height * 0.025),

            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Avatar",
                  style: TextStyle(
                      color: DColors.grey2,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Text("Selecione seu avatar",
                    style: TextStyle(
                        color: DColors.primary3,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: height * 0.025),
                const Divider()
              ],
            ),
            content: Container(
              width: width * 0.87058823529412,
              height: height * 0.87058823529412,
              child: GridView.count(
                  crossAxisSpacing: width * 0.021944444444444,
                  mainAxisSpacing: height * 0.01234375,
                  crossAxisCount: 3,
                  children: List.generate(
                      9,
                      (index) => InkWell(
                        onTap: () {
                          context.read<SelectAvatarCubit>().changeAvatar("avatar_0${index+1}");
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all((Radius.circular(4))),
                                color: DColors.white2,
                                border: state.avatar == "avatar_0${index+1}" ? Border.all(color: DColors.primary3, width: 2) : null
                            ),
                            child: Image.asset("assets/devameet/Avatar/avatar_0${index+1}_front.png", fit: BoxFit.contain,),

                        ),
                      ))),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: width * 0.22,
                      child: Button(text: "Voltar", onPressed: () => Navigator.pop(context, false), isInverted: true,)),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  SizedBox(
                      width: width * 0.41666666666667,
                      child: Button(text: "Salvar", onPressed: () {
                        onSave(state.avatar);
                        Navigator.pop(context, state.avatar);
                      },)),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}

class SelectAvatarState extends Equatable {
  final String avatar;

  const SelectAvatarState({required this.avatar});

  @override
  List<Object?> get props => [avatar];

  factory SelectAvatarState.initial() {
    return SelectAvatarState(
      avatar: ""
    );
  }

  SelectAvatarState copyWith({String? avatar}) {
    return SelectAvatarState(avatar: avatar ?? this.avatar);
  }

}
class SelectAvatarCubit extends Cubit<SelectAvatarState> {
  SelectAvatarCubit() : super(SelectAvatarState.initial());

  void changeAvatar(String avatar) {
    emit(state.copyWith(avatar: avatar));
  }

}
