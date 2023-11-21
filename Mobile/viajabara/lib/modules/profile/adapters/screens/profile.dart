import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/profile/change_information.dart';
import 'package:viajabara/kernel/widgets/profile/change_password.dart';
import 'package:viajabara/kernel/widgets/profile/change_photo.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  final double topWidgetHeight = 10.0;
  final double avatarRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Perfil',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        foregroundColor: ColorsApp.muted,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.asset(StuffApp.logoViajabara, height: 35),
          ),
        ],
        backgroundColor: ColorsApp.whiteColor,
        shadowColor: ColorsApp.blackColor,
        elevation: 2,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SvgPicture.asset(
              StuffApp.bgGeneral,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 70),
                  Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 5,
                    color: ColorsApp.transparentColor,
                    child: Column(
                      children: [
                        const SizedBox(height: 70),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Title(
                            color: ColorsApp.primayColor,
                            child: const Text(
                              'Vanessa',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '89',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Viajes realizados',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '23',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Último mes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Divider(color: ColorsApp.text)),
                        GestureDetector(
                          onTap: () {
                            _showModalPassword(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Cambiar contraseña',
                              style: TextStyle(
                                  color: ColorsApp
                                      .primayColor, 
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showModalChangeProfile(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Editar foto de perfil',
                              style: TextStyle(
                                  color: ColorsApp.primayColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _showModalChangeInformation(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Modificar tu información personal',
                              style: TextStyle(
                                  color: ColorsApp.primayColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Divider(color: ColorsApp.text)),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: ColorsApp.text,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'vanessa987@gmail.com',
                                  style: TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: ColorsApp.text,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '7776788767',
                                  style: TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.cake,
                                  color: ColorsApp.text,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '1996-06-08',
                                  style: TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.female,
                                  color: ColorsApp.text,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Mujer',
                                  style: TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        const SizedBox(
                            height:
                                20), // Espacio en la parte inferior de la Card
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: (MediaQuery.of(context).size.width / 3),
              top: avatarRadius,
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/Girl.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalPassword(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return const ChangePassword();
      },
    );
  }

  void _showModalChangeProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return const ChangePhotoModal();
      },
    );
  }

  void _showModalChangeInformation(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return const ChangeInformation();
      },
    );
  }
}
