
import 'dart:convert';

import 'package:apresentacao/models/movie_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  const MovieRepository(this.client);

  final Dio client;

  Future<List<MovieModel>> getMovies() async {
    try {
      final  url =
          'https://api.themoviedb.org/3/trending/movie/week?api_key=060e7c76aff06a20ca4a875981216f3f';

      final response = await client.get(url);
      final movies = List<MovieModel>.of(
        response.data['results'].map<MovieModel>(
          (json) => MovieModel(
            title: json['title'],
            description: json['original_title'],
            original_language: json['original_language'],
            popularity: json['popularity'],
           date: json['release_date'],
            vote_average:json['vote_average'],
            vote_count:json['vote_count'],
            urlImage: 'https://image.tmdb.org/t/p/w185${json['poster_path']}',
          ),
        ),
      );

      return movies;
    } catch (e) {
      throw e;
    }
  }
}
