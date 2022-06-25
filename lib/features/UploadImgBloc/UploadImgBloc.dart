
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

enum BlocEvent{
UploadEvent
}

class UploadBloc{

  final userSteamController =StreamController<String>();

  StreamSink<String> get usersink => userSteamController.sink;
  Stream<String> get userStream => userSteamController.stream;
  
  final eventStreamController = StreamController<BlocEvent>();

  StreamSink<BlocEvent> get inputEvent => eventStreamController.sink;
  Stream<BlocEvent> get outputEvent => eventStreamController.stream;

  UploadBloc(){
    outputEvent.listen((event)async {
      if(event == BlocEvent.UploadEvent){
       final image_picker = ImagePicker();

       var file;

         await Permission.photos.request();

         var CheckValidPermission = await Permission.photos.status;

         if(CheckValidPermission.isGranted){
           file=(await image_picker.pickImage(
               source: ImageSource.gallery, imageQuality: 100, maxWidth: 400));


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
             task.then((TaskSnapshot taskSnapshot) async {
               String url = await taskSnapshot.ref.getDownloadURL();
               Map<String, dynamic> dadosAtualizar = {"foto": url};
               usersink.add(url);

               FirebaseFirestore.instance
                   .collection("Users")
                   .doc("4TLQ7bAa3aMGEzweXDRlbFfMH6U2")
                   .update(dadosAtualizar);

               return "Carregada com sucesso!";
             });
           }

         }else{

         }
      }else{

      }
    });
  }
}