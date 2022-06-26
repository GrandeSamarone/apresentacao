
import 'package:apresentacao/models/movie_model.dart';
import 'package:apresentacao/models/user_model.dart';
import 'package:apresentacao/view/details_films_view.dart';
import 'package:flutter/material.dart';


class ItemNews extends StatelessWidget {
  const ItemNews({Key? key, required this.user}) : super(key: key);

  final UserModel user;

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
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            title: Text(user.nome!,
              style: const TextStyle(color: Colors.white,fontSize: 18),),
            dense: true,
          ),
        ),
      ),
    );
  }
}