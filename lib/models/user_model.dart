import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  bool? isVerified;
  final String? email;
  String? senha;
  final String? nome;
  final int? idade;
  UserModel({this.uid, this.email, this.senha, this.nome, this.idade,this.isVerified});

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
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
        senha: senha ?? this.senha,
        nome: nome ?? this.nome,
        idade: idade ?? this.idade,
      isVerified: isVerified ?? this.isVerified
    );
  }
}


