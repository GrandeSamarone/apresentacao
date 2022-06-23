import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/database/bloc/database_bloc.dart';
import 'package:apresentacao/features/database/bloc/database_event.dart';
import 'package:apresentacao/features/database/bloc/database_state.dart';
import 'package:apresentacao/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class userview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

   /// recebendo os dados do usuario atual
    final userdados = context.select((AuthenticationBloc bloc) => bloc.state.get_Dados);


        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions:[
                ///fazerndo logout
                IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationSignedOut());
                    })
              ],
              title:const Text("Meus Dados"),
            ),
            body:Column(
        children: [
        Text("Nome:${userdados["nome"]}"),
        Text("Email:${userdados["email"]!}"),
        Text("Idade:${userdados["idade"].toString()}")
        ],
        ));
  }
}