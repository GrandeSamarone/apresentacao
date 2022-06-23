import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  final String? email;
  String? senha;
  final String? nome;
  final int? idade;
  UserModel({this.uid, this.email, this.senha, this.nome, this.idade});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'nome': nome,
      'idade': idade,
    };
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        idade = doc.data()!["idade"],
        nome = doc.data()!["nome"];
 

  UserModel copyWith({
    String? uid,
    String? email,
    String? senha,
    String? nome,
    int? idade,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
        senha: senha ?? this.senha,
        nome: nome ?? this.nome,
        idade: idade ?? this.idade,
    );
  }
}


