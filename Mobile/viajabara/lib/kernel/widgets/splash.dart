import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/config/navigation/general_mechanisms_navigation.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';

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
          ColorFiltered(
            colorFilter: const ColorFilter.mode(
              ColorsApp.backgroundImagesColor,
              BlendMode.color,
            ),
            child: SvgPicture.asset(
              StuffApp.bgSplash,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SvgPicture.asset(StuffApp.logoViajabara),
          ),
        ],
      ),
    );
  }
}
