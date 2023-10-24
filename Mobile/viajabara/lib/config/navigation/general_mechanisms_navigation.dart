import 'package:flutter/material.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/login.dart';

class GeneralMechanismsNavigation extends StatelessWidget {
  const GeneralMechanismsNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
      },
    );
  }
}
