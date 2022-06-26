import 'dart:async';

import 'package:apresentacao/models/news.dart';
import 'package:apresentacao/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

   ///adicionando no firebase
    addUdserData(UserModel userData) async {
    await _db.collection("Users").doc(userData.uid).set(userData.toMap());
  }
  ///adicionando no firebase
    addNewsData(News newData) async {
    await _db.collection("News").doc(newData.uid).set(newData.toMap());
  }

  ///resgatando a list de noticias do firestore
    Future<List<News>> retrieveUserData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection("News").get();
    return snapshot.docs.map((docSnapshot) => News.fromDocumentSnapshot(docSnapshot)).toList();
    }

    ///resgatando os dados do usuario atual logado
        Future<Map<String, dynamic>> retrieveUser(UserModel user) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await _db.collection("Users").doc(user.uid).get();
    return snapshot.data()!;
    }
}
