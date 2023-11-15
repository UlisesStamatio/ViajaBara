import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

class CheckGpsEnabled extends StatelessWidget {
  const CheckGpsEnabled({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Es necesario habilitar el GPS",
              style: TextStyle(color: ColorsApp.text),
            ),
          ],
        ),
      ),
    );
  }
}
