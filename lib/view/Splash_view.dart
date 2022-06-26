import 'dart:async';
import 'package:apresentacao/features/NavigationService.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_view.dart';

class Splash_View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        Future.delayed(const Duration(milliseconds: 3000), () async {
          if (state is AuthenticationSuccess) {
            Navigator.of(NavigationService.navigatorKeyGlobal.currentContext!).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeView()),
                (Route<dynamic> route) => false);
          } else if (state is AuthenticationFailure) {
            Navigator.of(NavigationService.navigatorKeyGlobal.currentContext!).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInView()),
                (Route<dynamic> route) => false);
          }
        });
        return Scaffold(
            backgroundColor: Colors.black54,
            body: Container(
              alignment: Alignment.center,
              child: Image.asset(
                "imagens/iconmovie.png",
                width: 200,
              ),
            ));
      },
    );
  }
}
