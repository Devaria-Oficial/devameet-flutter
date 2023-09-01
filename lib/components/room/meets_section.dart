import 'package:devameet_flutter/components/shared/button.dart';
import 'package:devameet_flutter/constants/color.dart';
import 'package:devameet_flutter/cubits/meet/meet_cubit.dart';
import 'package:devameet_flutter/models/meet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MeetsSection extends StatelessWidget {
  const MeetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: MeetList(), onRefresh: () async {});
  }
}

class MeetList extends StatelessWidget {
  const MeetList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetCubit, MeetState>(builder: (context, state) {
      if (state.meets.isEmpty) {
        return const EmptyMeets();
      }

      return ListView.builder(
        itemCount: state.meets.length,
        shrinkWrap: true,
        itemBuilder: (_, index) => MeetItem(meet: state.meets[index]),
      );
    });
  }
}

class EmptyMeets extends StatelessWidget {
  const EmptyMeets({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: height * 0.0875),
      child: Column(
        children: [
          SvgPicture.asset("assets/images/empty.svg"),
          Text(
            "Você ainda não possui reuniões criadas :(",
            style: TextStyle(
                color: DColors.grey2,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 2.85,
                letterSpacing: 0.14),
          )
        ],
      ),
    );
  }
}

class MeetItem extends StatelessWidget {
  final MeetModel meet;
  const MeetItem({super.key, required this.meet});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: height * 0.025),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: DColors.grey1, width: 0.5))),
      child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          minLeadingWidth: 0,
          leading: Container(
            width: width * 0.016666666666667,
            height: height * 0.05,
            decoration: BoxDecoration(
                color: meet.color.toColor(),
                borderRadius: BorderRadius.circular(12)),
          ),
          title: Text(
            meet.name,
            style: TextStyle(
                color: DColors.grey3,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
          trailing: Wrap(
            spacing: width * 0.022222222222222,
            children: [
              InkWell(
                splashColor: DColors.grey1,
                onTap: () {},
                child: SvgPicture.asset(
                  "assets/icons/door.svg",
                  width: width * 0.044444444444444,
                  color: DColors.grey2,
                ),
              ),
              InkWell(
                splashColor: DColors.grey1,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: meet.link)).then((_) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Link copiado!"),
                    ));
                  });
                },
                child: SvgPicture.asset(
                  "assets/icons/copy.svg",
                  width: width * 0.044444444444444,
                  color: DColors.grey2,
                ),
              ),
              InkWell(
                splashColor: DColors.grey1,
                onTap: () {
                  showDialog(
                      context: context, builder: (_) => DeleteMeetModal());
                },
                child: SvgPicture.asset(
                  "assets/icons/trash.svg",
                  width: width * 0.044444444444444,
                  color: DColors.grey2,
                ),
              ),
            ],
          )),
    );
  }
}

extension ColorExtension on String {
  Color toColor() {
    String hexColor = this.replaceAll("#", "0xFF");
    return Color(int.parse(hexColor));
  }
}

class DeleteMeetModal extends StatelessWidget {
  const DeleteMeetModal({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return AlertDialog(
      title: Center(
          child: Text(
        "Deletar reunião",
        style: TextStyle(
            color: DColors.primary3,
            fontSize: 18.909,
            fontWeight: FontWeight.w700,
            height: 1.2),
      )),
      insetPadding: EdgeInsets.symmetric(
          horizontal: width * 0.044444444444444, vertical: 216),
      titlePadding: EdgeInsets.only(top: height * 0.0375, bottom: height * 0.025),
      contentPadding: EdgeInsets.only(bottom: height * 0.0375),
      actionsPadding: EdgeInsets.only(bottom: height * 0.0375),
      content: Container(
        width: width,
        height: height * 0.075,
        child: Column(
          children: [
            Text(
              "Deseja deletar a reunião?",
              style: TextStyle(
                  color: DColors.grey2,
                  fontSize: 16.545,
                  fontWeight: FontWeight.w400,
                  height: 1.45),
            ),
            Text("Essa ação não poderá ser desfeita.",
                style: TextStyle(
                    color: DColors.grey2,
                    fontSize: 16.545,
                    fontWeight: FontWeight.w400,
                    height: 1.45))
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width * 0.25,
              child: Button(
                text: "Cancelar",
                onPressed: () => Navigator.pop(context, false),
                isInverted: true,
              ),
            ),
            SizedBox(
              width: width * 0.01,
            ),
            SizedBox(
              width: width * 0.41666666666667,
              child: Button(
                text: "Confirmar",
                onPressed: () => Navigator.pop(context, false),
              ),
            )
          ],
        )
      ],
    );
  }
}
