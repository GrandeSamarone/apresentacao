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
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const WelcomeView()),
                  (Route<dynamic> route) => false);
        }
      },
      buildWhen: ((previous, current) {
        if (current is AuthenticationFailure) {
          return false;
        }
        return true;
      }),
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: <Widget>[
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
              title: Text((state as AuthenticationSuccess).dados["nome"]),
            ),
            body: BlocBuilder<DatabaseBloc, DatabaseState>(
              builder: (context, state) {
                Map<String,dynamic> displayName = (context.read<AuthenticationBloc>().state as AuthenticationSuccess).dados;
               // String? displayEmail = (context.read<AuthenticationBloc>().state as AuthenticationSuccess).displayName;
              //  String? displayIdade = (context.read<AuthenticationBloc>().state as AuthenticationSuccess).id;
                if (state is DatabaseSuccess &&
                    displayName !=
                        (context.read<DatabaseBloc>().state as DatabaseSuccess)
                            .nome) {
                  context.read<DatabaseBloc>().add(DatabaseFetched(displayName["nome"]));
                }
                if (state is DatabaseInitial) {
                  context.read<DatabaseBloc>().add(DatabaseFetched(displayName["nome"]));
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DatabaseSuccess) {
                  if (state.listOfUserData.isEmpty) {
                    return const Center(
                      child: Text("Nenhum dado disponível!"),
                    );
                  } else {
                    return Column(
                      children: [
                        Text(displayName["nome"]!)
                      ],
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ));
      },
    );
  }
}