import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  String? uid;
  final String? foto;
  String? titulo;
  final String? desc;
  News({this.uid, this.foto, this.titulo, this.desc});

  Map<String, dynamic> toMap() {
    return {
      'foto': foto,
      'titulo': titulo,
      'desc': desc,
    };
  }

  News.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        foto = doc.data()!["foto"],
        titulo = doc.data()!["titulo"],
        desc = doc.data()!["desc"];

        News copyWith({
    String? uid,
    String? foto,
    String? titulo,
    String? desc,
  }) {
    return News(
      uid: uid ?? this.uid,
      foto: foto ?? this.foto,
      titulo: titulo ?? this.titulo,
      desc: desc ?? this.desc,
    );
  }
}


