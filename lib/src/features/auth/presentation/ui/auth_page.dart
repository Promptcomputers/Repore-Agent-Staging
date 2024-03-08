import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:repore_agent/lib.dart';

class AuthHomePage extends StatelessWidget {
  const AuthHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final state = ref.watch(authControllerProvider);

        if (state == false && PreferenceManager.isloggedIn == true) {
          //Auto login
          return AutoLoginScreen(
            email: PreferenceManager.email,
            firstName: PreferenceManager.firstName,
          );
        } else if (state == false && PreferenceManager.isloggedIn == false) {
          //App not launch for the first, but user login logout
          return const LoginScreen();
        } else {
          //user just launch app for the first time
          return const LoginScreen();
        }
      },
    );
  }
}
