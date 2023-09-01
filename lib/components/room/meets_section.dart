import 'package:devameet_flutter/cubits/meet/meet_cubit.dart';
import 'package:devameet_flutter/models/meet_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetsSection extends StatelessWidget {
  const MeetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: MeetList(), onRefresh: ()async{});
  }

}


class MeetList extends StatelessWidget {
  const MeetList({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MeetCubit, MeetState>(builder: (context, state) {

      print(state);

      return ListView.builder(
        itemCount: state.meets.length,
        shrinkWrap: true,
        itemBuilder: (_, index) => MeetItem(meet: state.meets[index]),
      );
    });

  }

}

class MeetItem extends StatelessWidget {
  final MeetModel meet;
  const MeetItem({super.key, required this.meet});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(meet.name),
    );
  }

}
