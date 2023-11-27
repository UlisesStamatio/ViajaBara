import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/domain/entities/response_message.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/profile/change_information.dart';
import 'package:viajabara/kernel/widgets/profile/change_password.dart';
import 'package:viajabara/kernel/widgets/profile/change_photo.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double topWidgetHeight = 10.0;
  final double avatarRadius = 20.0;
  String userRole = '';
  String email = '';
  String name = '';
  String cellphone = '';
  String birthDate = '';
  String sex = '';
  bool isAdmin = false;

  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('data');
    Map<String, dynamic> jsonData = json.decode(data!);
    ResponseMessage responseMessage = ResponseMessage.fromJson(jsonData);
    String? role = responseMessage.roles?.keyRole;
    print(prefs.getString('data'));

    if (role == null) {
      Navigator.pushNamed(context, '/login');
    }

    setState(() {
      name = responseMessage.name ?? 'Agrega tu nombre';
      email = responseMessage.email ?? 'Agrega tu correo';
      cellphone = responseMessage.cellphone ?? 'Agrega tu celular';
      birthDate = responseMessage.birthDate ?? 'Agrega tu fecha de nacimiento';
      sex = responseMessage.sex ?? 'Agrega tu sexo';
    });

    if (role == "ADMIN") {
      setState(() {
        isAdmin = true;
      });
    }
  }

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
                  const SizedBox(height: 10),
                  Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 5,
                    color: ColorsApp.transparentColor,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/images/Girl.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Title(
                            color: ColorsApp.primayColor,
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        if (isAdmin) ...{
                          Column(
                            children: [
                              const Text("Calificación general"),
                              const SizedBox(height: 10),
                              Center(
                                child: RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: const Divider(color: ColorsApp.text)),
                            ],
                          ),
                        },
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
                                  color: ColorsApp.primayColor,
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
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                  color: ColorsApp.text,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  email,
                                  style: const TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.phone,
                                  color: ColorsApp.text,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  cellphone,
                                  style: const TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.cake,
                                  color: ColorsApp.text,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  birthDate,
                                  style: const TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                if (sex == 'M') ...{
                                  const Icon(
                                    Icons.female,
                                    color: ColorsApp.text,
                                  ),
                                },
                                if (sex == 'H') ...{
                                  const Icon(
                                    Icons.male,
                                    color: ColorsApp.text,
                                  ),
                                },
                                if (sex == 'Agrega tu sexo') ...{
                                  const Icon(
                                    Icons.person,
                                    color: ColorsApp.text,
                                  ),
                                },
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  sex,
                                  style: const TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_city,
                                  color: ColorsApp.text,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  birthDate,
                                  style: const TextStyle(color: ColorsApp.text),
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
