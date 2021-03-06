
import 'package:apresentacao/models/movie_model.dart';
import 'package:apresentacao/view/details_films_view.dart';
import 'package:flutter/material.dart';


class ItemFilms extends StatelessWidget {
  const ItemFilms({Key? key, required this.films}) : super(key: key);

  final MovieModel films;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>Details(film_details: films,)),
        );
      },
      child: Material(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            leading:  Container(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'imagens/loading-carregando.gif',
                  image:films.urlImage,
                ),
              ),
            ),

            title: Text(films.title.toString(),
              style: const TextStyle(color: Colors.white,fontSize: 18),),
            dense: true,
          ),
        ),
      ),
    );
  }
}