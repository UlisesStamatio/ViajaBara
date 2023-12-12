import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/providers/utils/utils.dart';

class ChangePhotoModal extends StatefulWidget {
  final String photo;
  const ChangePhotoModal({Key? key, required this.photo}) : super(key: key);

  @override
  _ChangePhotoModal createState() => _ChangePhotoModal();
}

class _ChangePhotoModal extends State<ChangePhotoModal> {
  late String photo;

  @override
  void initState() {
    super.initState();
    photo = widget.photo;
  }

  void _showPhoto() {
    late OverlayEntry overlayEntry; // Declara la variable como late
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        child: GestureDetector(
          onTap: () {
            overlayEntry.remove(); // Ahora puedes usar la variable directamente
          },
          child: Container(
            color: Colors.black.withOpacity(0.7),
            child: Center(
              child: Hero(
                tag: 'photo',
                child: Utils().profilePicture(photo),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Hero(
              tag: 'photo',
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.transparent,
                child: Utils().profilePicture(photo),
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Divider(
            color: ColorsApp.text,
          ),
          ListTile(
            title: const Text('Seleccionar foto desde la galería',
                style: TextStyle(color: ColorsApp.text),
                textAlign: TextAlign.center),
            onTap: () {},
          ),
          const Divider(color: ColorsApp.text),
          ListTile(
            title: const Text('Ver foto',
                style: TextStyle(color: ColorsApp.text),
                textAlign: TextAlign.center),
            onTap: _showPhoto,
          ),
          const Divider(color: ColorsApp.text),
          ListTile(
            title: const Text('Cancelar',
                style: TextStyle(color: ColorsApp.text),
                textAlign: TextAlign.center),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
