import 'package:flutter/material.dart';
import 'package:viajabara/kernel/widgets/Splash.dart';
import 'package:viajabara/kernel/widgets/menu.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/forgot_password.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/login.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/register.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/register2.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/menu',
      routes: {
        '/': (context) => Splash(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/register2': (context) => const Register2(),
        '/forgot_password': (context) => const ForgotPassword(),
        '/menu': (context) => const Menu()
      },
    );
  }
}
