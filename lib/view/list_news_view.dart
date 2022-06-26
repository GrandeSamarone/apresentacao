import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/database/bloc/database_bloc.dart';
import 'package:apresentacao/features/database/bloc/database_event.dart';
import 'package:apresentacao/features/database/bloc/database_state.dart';
import 'package:apresentacao/features/widget/itensNews.dart';
import 'package:apresentacao/view/nova_news_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class listnewsview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              title:const Center(child:Text("Notícias")),
            ),
            body: BlocBuilder<DatabaseBloc, DatabaseState>(
              builder: (context, state) {
                Map<String,dynamic> displayDados = (context.read<AuthenticationBloc>().state as AuthenticationSuccess).dados!;
                if (state is DatabaseSuccess &&
                    displayDados !=
                        (context.read<DatabaseBloc>().state as DatabaseSuccess)
                            .dados) {
                  context.read<DatabaseBloc>().add(DatabaseFetched(displayDados));
                }
                if (state is DatabaseInitial) {
                  context.read<DatabaseBloc>().add(DatabaseFetched(displayDados));
                  return const Center(child: CircularProgressIndicator());
                } else
                  if (state is DatabaseSuccess) {
                  if (state.listOfUserData.isEmpty) {
                    return const Center(
                      child: Text("Nenhum dado disponível!"),
                    );
                  } else {
                    return Center(
                      child: ListView.builder(
                        itemCount: state.listOfUserData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemNews(user:state.listOfUserData[index]);
                        },
                      ),
                    );
                  }
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          floatingActionButton: FloatingActionButton(
          onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>NovaNewsView()),
            );

          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        );
  }
}