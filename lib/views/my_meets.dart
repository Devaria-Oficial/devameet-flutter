
import 'package:devameet_flutter/components/shared/header.dart';
import 'package:devameet_flutter/components/shared/menu.dart';
import 'package:flutter/material.dart';

class MyMeetsPage extends StatelessWidget {
  const MyMeetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: Header(height: height * 0.075,),
      body: const MyMeetsView(),
      bottomNavigationBar: const Menu(currentSelected: 0),
    );
  }

}

class MyMeetsView extends StatelessWidget {
  const MyMeetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child:
        Text("Minhas Reunioes")
    );
  }
  
}