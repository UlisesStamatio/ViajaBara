import 'package:flutter/material.dart';
import 'package:viajabara/config/navigation/general_mechanisms_navigation.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const GeneralMechanismsNavigation())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset('assets/images/viajabara_logo.png',
                width: 200, height: 150),
          ),
        ],
      ),
    );
  }
}
