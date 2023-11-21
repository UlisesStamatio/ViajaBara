import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

class ChangePhotoModal extends StatefulWidget {
  const ChangePhotoModal({Key? key}) : super(key: key);

  @override
  _ChangePhotoModal createState() => _ChangePhotoModal();
}

class _ChangePhotoModal extends State<ChangePhotoModal> {
  final photo = 'assets/images/perfilGirl.avif';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min, 
        children: <Widget>[
          CircleAvatar(
            radius: 60, 
            backgroundImage: AssetImage(photo),
          ),
          const SizedBox(height: 30),
          const Divider(color: ColorsApp.text, ),
          ListTile(
            title: const Text('Seleccionar foto desde la galería', style: TextStyle(color: ColorsApp.text), textAlign: TextAlign.center),
            onTap: () {
            },
          ),
          const Divider(color: ColorsApp.text),
          ListTile(
            title: const Text('Ver foto', style: TextStyle(color: ColorsApp.text), textAlign: TextAlign.center),
            onTap: () {
            },
          ),
          const Divider(color: ColorsApp.text),
          ListTile(
            title: const Text('Cancelar', style: TextStyle(color: ColorsApp.text), textAlign: TextAlign.center),
            onTap: () {
              Navigator.of(context).pop(); 
            },
          ),
        ],
      ),
    );
  }
}