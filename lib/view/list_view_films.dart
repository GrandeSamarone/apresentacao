import 'package:apresentacao/features/movies/movie_bloc.dart';
import 'package:apresentacao/features/movies/movie_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/widget/ItemFilms.dart';

class listviewfilms extends StatefulWidget {
  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends State<listviewfilms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(child:  Text('FILMES DA SEMANA')),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is LoadingState) {
            ///estado inicial
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            ///estado error
            return const Center(
              child: Icon(Icons.close),
            );
          } else if (state is LoadedState) {
            final movies = state.movies;
            ///estado final carregando os itens
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index){
               return ItemFilms(films: movies[index]);
              }


            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
