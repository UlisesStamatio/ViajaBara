import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:viajabara/kernel/blocs/blocs.dart';
import 'package:viajabara/kernel/cubits/login/login_form_cubit.dart';
import 'package:viajabara/kernel/widgets/Splash.dart';
import 'package:viajabara/kernel/widgets/menu.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/forgot_password.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/login.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/register.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => GpsBloc(),
      ),
      BlocProvider(
        create: (context) => LocationBloc(),
      ),
      BlocProvider(
        create: (context) => UserBloc(),
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/login': (context) => BlocProvider(
              create: (context) => LoginFormCubit(),
              child: const Login(),
            ),
        '/menu': (context) => const Menu(),
        '/register': (context) => const Register(),
        '/forgotPassword': (context) => const ForgotPassword()
      },
    );
  }
}
