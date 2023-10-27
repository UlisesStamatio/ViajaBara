import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viajabara/config/navigation/general_mechanisms_navigation.dart';
import 'package:viajabara/kernel/blocs/gps/gps_bloc.dart';
import 'package:viajabara/kernel/widgets/Splash.dart';
import 'package:viajabara/kernel/widgets/menu.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/forgot_password.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/login.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/register.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/register2.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GpsBloc(),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/login': (context) => const GeneralMechanismsNavigation(),
      },
    );
  }
}
