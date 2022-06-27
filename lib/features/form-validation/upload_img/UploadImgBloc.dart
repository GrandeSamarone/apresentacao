import 'dart:async';
import 'dart:io';
import 'package:apresentacao/features/form-validation/upload_img/Upload_img_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:short_uuids/short_uuids.dart';
import 'package:stream_transform/stream_transform.dart';


class UploadBloc{
  var short = ShortUuid();
  var file;
  String ?url;
  final userSteamController =StreamController<XFile>.broadcast();
  Sink<XFile> get usersink => userSteamController.sink;
  Stream<Upload_img_state> get userStream => userSteamController.stream.switchMap(_carregarImg);


  Stream<Upload_img_state> _carregarImg(XFile imgcaminho) async*{

    yield  upload_Loading();
    try{
      var _imagem = File(imgcaminho.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference pastaRaiz = storage.ref();
      Reference arquivo =
      pastaRaiz.child("perfil").child(short.generate()+ ".jpg");

      //Upload da imagem
      final tt =await arquivo.putFile(_imagem);
      url=await arquivo.getDownloadURL();
      yield  upload_sucess(url!);

    }catch(e){
      yield upload_Error("Deu Ruim!");
    }
  }
}