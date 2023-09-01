import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    return ListView.builder(
      itemCount: 10000000,
      shrinkWrap: true,
      itemBuilder: (_, index) => MeetItem(),
    );
  }

}

class MeetItem extends StatelessWidget {
  const MeetItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Item da lista"),
    );
  }

}
