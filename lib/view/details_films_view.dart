import 'dart:ui';

import 'package:apresentacao/models/movie_model.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {

  final MovieModel film_details;
  const Details({Key? key,required this.film_details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(child:  Text(film_details.title)),
      ),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: double.infinity,
            height: 300,
            child: ClipRRect(
              child: FadeInImage.assetNetwork(
                fit: BoxFit.fill,
                placeholder: 'imagens/loading-carregando.gif',
                image:film_details.urlImage!,
              ),
            ),
          ),
          const SizedBox(height: 10.0),

          Text("Descrição:${film_details.description}",
            style: const TextStyle(color: Colors.white,fontSize: 24),),
          const SizedBox(height: 10.0),
          Text("Popularidade:${film_details.popularity}"
            ,style: const TextStyle(color: Colors.white,fontSize: 18),),
          Text("Linguagem Disponível:${film_details.original_language}",
            style:const TextStyle(color: Colors.white,fontSize: 18),),
          Text("Média de Votos:${film_details.vote_average}",
            style:const TextStyle(color: Colors.white,fontSize: 18),),
          Text("Contagem de Votos:${film_details.vote_count}"
            ,style:const TextStyle(color: Colors.white,fontSize: 18),),
          Text("Data:${film_details.date}",
            style:const TextStyle(color: Colors.white,fontSize: 18),),
        ],

      ),
    );
  }
}
