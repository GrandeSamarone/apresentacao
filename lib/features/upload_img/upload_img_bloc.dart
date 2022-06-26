
import 'dart:io';

import 'package:apresentacao/features/upload_img/upload_img_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class UploadImgBloc extends Bloc<String,UploadState>{

  UploadImgBloc() : super(const UploadSucess({}));


  @override
  Stream<UploadState> mapEventToState()async*{

    yield const UploadLoading();

    final image_picker = ImagePicker();

    var file;

    await Permission.photos.request();

    var CheckValidPermission = await Permission.photos.status;

    if(CheckValidPermission.isGranted){
      file=(await image_picker.pickImage(
          source: ImageSource.gallery, imageQuality: 100, maxWidth: 400));

    try{
      if (file != null) {
        var _imagem = File(file.path);

        FirebaseStorage storage = FirebaseStorage.instance;
        Reference pastaRaiz = storage.ref();
        Reference arquivo =
        pastaRaiz.child("perfil").child("4TLQ7bAa3aMGEzweXDRlbFfMH6U2" + ".jpg");

        //Upload da imagem
        UploadTask task = arquivo.putFile(_imagem);

        task.snapshotEvents.listen((TaskSnapshot storageEvent) {
          if (storageEvent.state == TaskState.running) {
            print("resultado:: Carregando...");
          } else if (storageEvent.state == TaskState.success) {
            print("resultado:: Sucesso...");
          }
        });

        //Recuperar URL da imagem
        task.then((TaskSnapshot taskSnapshot) async* {
          String url = await taskSnapshot.ref.getDownloadURL();
          Map<String, dynamic> dadosAtualizar = {"foto": url};


          FirebaseFirestore.instance
              .collection("Users")
              .doc("4TLQ7bAa3aMGEzweXDRlbFfMH6U2")
              .update(dadosAtualizar);

          yield UploadSucess(dadosAtualizar);
        });
      }

    }catch(e){
      yield const UploadError("Erro na Pesquisa");
    }
    }
  }
}
