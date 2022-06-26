
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:short_uuids/short_uuids.dart';

enum BlocEvent{
UploadEvent,
PickImg
}
abstract class Upload_img_state{}

class upload_sucess implements Upload_img_state{
  final String link;
  upload_sucess(this.link);

}
class upload_Loading implements Upload_img_state{}

class upload_Error implements Upload_img_state{
  final String message;

  upload_Error(this.message);

}
class UploadBloc{
  var short = ShortUuid();
  var file;
  String ?url;
  final userSteamController =StreamController<XFile>.broadcast();
  Sink<XFile> get usersink => userSteamController.sink;
  Stream<Upload_img_state> get userStream => userSteamController.stream.switchMap(_carregarImg);

 // final eventStreamController = StreamController<BlocEvent>();

 // StreamSink<BlocEvent> get inputEvent => eventStreamController.sink;
 // Stream<BlocEvent>  get outputEvent => eventStreamController.stream;


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

    //UploadTask task = arquivo.putFile(_imagem);

    // task.snapshotEvents.listen((TaskSnapshot storageEvent)async {
    //   if (storageEvent.state == TaskState.running) {
    //     print("resultado:: Carregando...");
    //   } else if (storageEvent.state == TaskState.success) {
    //     print("resultado:: Sucesso...");
    //     url = await storageEvent.ref.getDownloadURL();
    //     print("taskSnapshot");
    //     print(url);
    //   }
    // });

       // yield  upload_sucess(url!);

    }catch(e){
      yield upload_Error("Deu Ruim!");
    }
  }
  // UploadBloc(){
  //   outputEvent.listen((event)async {
  //     if(event == BlocEvent.UploadEvent){
  //         final image_picker = ImagePicker();
  //
  //
  //         await Permission.photos.request();
  //
  //         var CheckValidPermission = await Permission.photos.status;
  //         if(CheckValidPermission.isGranted){
  //           file=(await image_picker.pickImage(
  //               source: ImageSource.gallery, imageQuality: 100, maxWidth: 400));
  //       }
  //          if (file != null) {
  //            upload_Loading();
  //            var _imagem = File(file.path);
  //            FirebaseStorage storage = FirebaseStorage.instance;
  //            Reference pastaRaiz = storage.ref();
  //            Reference arquivo =
  //            pastaRaiz.child("perfil").child(short.generate()+ ".jpg");
  //
  //            //Upload da imagem
  //            UploadTask task = arquivo.putFile(_imagem);
  //
  //            task.snapshotEvents.listen((TaskSnapshot storageEvent) {
  //              if (storageEvent.state == TaskState.running) {
  //                print("resultado:: Carregando...");
  //              } else if (storageEvent.state == TaskState.success) {
  //                print("resultado:: Sucesso...");
  //              }
  //            });
  //
  //            //Recuperar URL da imagem
  //            task.then((TaskSnapshot taskSnapshot) async* {
  //              String url = await taskSnapshot.ref.getDownloadURL();
  //              Map<String, dynamic> dadosAtualizar = {"foto": url};
  //             // usersink.add(url);
  //            yield  upload_sucess(url);
  //
  //              // FirebaseFirestore.instance
  //              //     .collection("Users")
  //              //     .doc("4TLQ7bAa3aMGEzweXDRlbFfMH6U2")
  //              //     .update(dadosAtualizar);
  //
  //              yield "Carregada com sucesso!";
  //            });
  //          }
  //     }else{
  //
  //     }
  //   });
  // }
}