import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:short_uuids/short_uuids.dart';
import 'package:stream_transform/stream_transform.dart';

import 'UploadImgNewsState.dart';


class UploadBlocNew{
  var short = ShortUuid();
  var file;
  String ?url;
  final newSteamController =StreamController<XFile>.broadcast();
  Sink<XFile> get newsink => newSteamController.sink;
  Stream<UploadImgNewsState> get newStream => newSteamController.stream.switchMap(_carregarImgNew);


  Stream<UploadImgNewsState> _carregarImgNew(XFile imgcaminho) async*{

    yield  upload_Loadingnew();
    try{
      var _imagem = File(imgcaminho.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference pastaRaiz = storage.ref();
      Reference arquivo =
      pastaRaiz.child("News").child(short.generate()+ ".jpg");

      //Upload da imagem
      final tt =await arquivo.putFile(_imagem);
      url=await arquivo.getDownloadURL();
      yield  upload_sucessnew(url!);

    }catch(e){
      yield upload_Errornew("Deu Ruim!");
    }
  }
}