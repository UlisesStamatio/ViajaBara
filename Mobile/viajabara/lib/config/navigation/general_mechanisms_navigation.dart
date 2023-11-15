import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viajabara/kernel/cubits/login/login_form_cubit.dart';
import 'package:viajabara/kernel/widgets/menu.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/forgot_password.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/login.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/register.dart';
import 'package:viajabara/modules/generalMechanisms/adapters/screens/register2.dart';

class GeneralMechanismsNavigation extends StatelessWidget {
  const GeneralMechanismsNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => BlocProvider(
              create: (context) => LoginFormCubit(),
              child: const Login(),
            ),
        '/menu': (context) => const Menu(),
        '/register': (context) => const Register(),
        '/register2': (context) => const Register2(),
        '/forgotPassword': (context) => const ForgotPassword()
      },
    );
  }
}
