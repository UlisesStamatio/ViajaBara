import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/domain/entities/resMsg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/custom_progress_indicator.dart';
import 'package:viajabara/kernel/widgets/profile/change_information.dart';
import 'package:viajabara/kernel/widgets/profile/change_password.dart';
import 'package:viajabara/kernel/widgets/profile/change_photo.dart';
import 'package:viajabara/providers/auth_provider.dart';
import 'package:viajabara/providers/session_manager.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double topWidgetHeight = 10.0;
  Future? _futureUserInfo;
  final double avatarRadius = 20.0;
  String email = '';
  String name = '';
  String cellphone = '';
  String birthDate = '';
  String sex = '';
  String state = '';
  String profile = '';
  bool isAdmin = false;

  void initState() {
    super.initState();
    _futureUserInfo = _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    if (mounted) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('data')) {
        Map<String, dynamic> jsonData = json.decode(prefs.getString('data')!);
        ResMsg responseMessage = ResMsg.fromJson(jsonData);
        ResMsg dataUser =
            await AuthProvider().getInfoUser(responseMessage.email);
        String? role = responseMessage.roles?.keyRole;
        _updateUserProfile(dataUser);
        _setRole(role);
      }
    }
  }

  void _setRole(String? role) {
    if (role == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else if (role == "ADMIN" || role == "COND") {
      setState(() {
        isAdmin = true;
      });
    }
  }

  void _updateUserProfile(ResMsg dataUser) {
    setState(() {
      profile = utf8.decode(base64.decode(dataUser.profile!));
      name = dataUser.name!;
      email = dataUser.email!;
      cellphone = dataUser.cellphone!;
      birthDate = dataUser.birthDate!;
      sex = dataUser.sex!;
      state = dataUser.state!;
    });
  }

  Future<void> cerrarSesion() async {
    await SessionManager.logOut();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureUserInfo,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CustomCircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return profileCard();
        }
      },
    );
  }

  Widget profileCard() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          child: SizedBox(
                            height: 120,
                            width: 120,
                            child: SvgPicture.string(
                              profile,
                              fit: BoxFit.contain, // Asegúrate de que el SVG se ajusta dentro del contenedor
                            ),
                          ),
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
                            _showModalChangeProfile(context, profile);
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
                              // Usando operador ternario para determinar el icono
                              Icon(
                                sex == 'M'
                                    ? Icons.female
                                    : sex == 'H'
                                        ? Icons.male
                                        : Icons.person,
                                color: ColorsApp.text,
                              ),

                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                sex,
                                style: const TextStyle(color: ColorsApp.text),
                              ),
                            ],
                          ),
                        ),
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
                                  state,
                                  style: const TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              cerrarSesion();
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorsApp.primayColor),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Cerrar sesión',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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

  void _showModalChangeProfile(BuildContext context, String photo) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return ChangePhotoModal(photo: photo);
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
