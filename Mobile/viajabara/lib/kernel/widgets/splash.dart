import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, '/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo de pantalla
          Image.asset(
            'assets/images/bg.png', // Ruta de tu imagen de fondo
            fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el espacio
          ),
          // Contenido centrado
          Center(
            child: Image.asset('assets/images/viajabara_logo.png',
                width: 200, height: 150),
          ),
        ],
      ),
    );
  }
}
