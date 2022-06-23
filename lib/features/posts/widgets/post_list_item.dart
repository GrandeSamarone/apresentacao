import 'package:apresentacao/models/post.dart';
import 'package:flutter/material.dart';


class PostListItem extends StatelessWidget {
  const PostListItem({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading:  Container(
          width: 80,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              placeholder: 'imagens/loading-carregando.gif',
              image:post.thumbnailUrl,
            ),
          ),
        ),

        title: Text(post.title),
        dense: true,
      ),
    );
  }
}