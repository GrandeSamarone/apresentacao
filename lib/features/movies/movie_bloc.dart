import 'package:apresentacao/features/movies/movie_repository.dart';
import 'package:apresentacao/features/movies/movie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MoviesBloc extends Bloc<String,MoviesState> {
  MoviesBloc({required this.repository}) : super(InitialState()) {
    getTrendingMovies();
  }

  final MovieRepository repository;

  void getTrendingMovies() async {
    try {
      emit(LoadingState());
      final movies = await repository.getMovies();
      emit(LoadedState(movies));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
