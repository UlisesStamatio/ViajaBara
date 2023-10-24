import 'package:flutter/material.dart';
import 'package:viajabara/modules/profile/adapters/screens/profile.dart';

class ProfileNavigation extends StatelessWidget {
  const ProfileNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => const Profile(),
      },
    );
  }
}
