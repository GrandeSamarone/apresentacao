import 'dart:async';
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/view/home_view.dart';
import 'package:apresentacao/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Splash_View extends StatelessWidget{

/* if (state is AuthenticationSuccess) {
          return  HomeView();
        } else {
          return const SignInView();
        }*/


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        Future.delayed( const Duration(milliseconds: 2000), () async {
          print("time");
          print(state);
           if (state is AuthenticationSuccess) {
             print("HomeView");
             Navigator.of(context).push(
               PageRouteBuilder(
                   transitionDuration:const Duration(milliseconds: 1500),
                   maintainState: true,
                   pageBuilder: (c, a1, a2) {
                     return HomeView();
                   }),
             );
        } else {
             print("SignInView");
             Navigator.of(context).push(
               PageRouteBuilder(
                   transitionDuration: const Duration(milliseconds: 1500),
                   maintainState: true,
                   pageBuilder: (c, a1, a2) {
                     return const SignInView();
                   }),
             );
        }
        });
        return  Scaffold(
            backgroundColor:Colors.black54,
            body: Container(
              alignment: Alignment.center,
              child: Image.asset(
                "imagens/iconmovie.png",
                width:200,
              ),
            )
        );
      },
    );
  }
}
