
import 'dart:ui';

import 'package:apresentacao/models/movie_model.dart';
import 'package:apresentacao/models/news.dart';
import 'package:apresentacao/models/user_model.dart';
import 'package:apresentacao/view/details_films_view.dart';
import 'package:flutter/material.dart';


class ItemNews extends StatelessWidget {
  const ItemNews({Key? key, required this.news}) : super(key: key);

  final News news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) =>Details(film_details: films,)),
        // );
      },
      child: Material(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'imagens/loading-carregando.gif',
                    image:news.foto!,
                  ),
                ),
              ),

               Text(news.titulo!,
                style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            ],
          )
        ),
      ),
    );
  }
}