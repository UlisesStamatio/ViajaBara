import 'package:flutter/material.dart';
import 'package:viajabara/kernel/colors/colors_app.dart';

class CheckPermissionLocalization extends StatelessWidget {
  const CheckPermissionLocalization({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Es necesario el acceso a GPS"),
            IntrinsicWidth(
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(ColorsApp.primayColor),
                ),
                child: const InkWell(
                  child: Row(children: [
                    Icon(Icons.play_arrow),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Solicitar acceso')
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
