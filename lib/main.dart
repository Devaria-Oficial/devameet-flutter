import 'package:devameet_flutter/views/login.dart';
import 'package:devameet_flutter/views/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'injection_container.dart' as di;

void main() async {
  di.init();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devameet',
      theme: ThemeData(
        fontFamily: "Biennale"
      ),
      home: RegisterPage()
    );
  }
}
