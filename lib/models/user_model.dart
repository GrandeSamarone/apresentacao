import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  final String? email;
  String? senha;
  final String? nome;
  final String? foto;
  final int? idade;
  UserModel({this.uid, this.email, this.senha, this.nome,this.foto, this.idade});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'nome': foto,
      'idade': idade,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        idade = doc.data()!["idade"],
        nome = doc.data()!["nome"],
         foto = doc.data()!["foto"];


  UserModel copyWith({
    String? uid,
    String? email,
    String? senha,
    String? nome,
    String? foto,
    int? idade,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
        senha: senha ?? this.senha,
        nome: nome ?? this.nome,
         foto: foto ?? this.foto,
        idade: idade ?? this.idade,
    );
  }
}


