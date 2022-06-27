import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/database/bloc/database_bloc.dart';
import 'package:apresentacao/features/database/bloc/database_event.dart';
import 'package:apresentacao/features/database/bloc/database_state.dart';
import 'package:apresentacao/features/widget/itensNews.dart';
import 'package:apresentacao/view/NovaNewsView.dart';
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
                if (state is DatabaseInitial) {
                  ///começa carregando os dados
                  context.read<DatabaseBloc>().add(DatabaseFetched());
                  return const Center(child: CircularProgressIndicator());
                } else
                  if (state is DatabaseSuccess) {
                  if (state.listOfNew.isEmpty) {
                    return const Center(
                      child: Text("Nenhum dado disponível!"),
                    );
                  } else {
                    ///mostra na tela
                    return Center(
                      child: ListView.builder(
                        itemCount: state.listOfNew.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemNews(news:state.listOfNew[index]);
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
          onPressed:()async{
          var resultado=await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>NovaNewsView()));
          if(resultado==null)
            context.read<DatabaseBloc>().add(DatabaseFetched());
        },
          child: const Icon(Icons.add),
        ),
        );
  }
  }

