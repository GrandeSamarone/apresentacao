import 'dart:ui';

import 'package:apresentacao/models/movie_model.dart';
import 'package:flutter/material.dart';

import '../models/news.dart';

class DetailsNews extends StatelessWidget {

  final News news_details;
  ///recebendo os dados da noticia
  const DetailsNews({Key? key,required this.news_details}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Center(child:  Text(news_details.titulo!)),
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
                image:news_details.foto!,
              ),
            ),
          ),
          const SizedBox(height: 10.0),

          Text("Descrição:${news_details.desc}",
            style: const TextStyle(color: Colors.white,fontSize: 16),),
          const SizedBox(height: 10.0),
        ],

      ),
    );
  }
}
