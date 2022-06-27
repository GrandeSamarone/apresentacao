import 'dart:ui';
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../features/form-validation/upload_img/UploadImgBloc.dart';

class userview extends StatefulWidget {

  @override
  State<userview> createState() => _userviewState();
}

class _userviewState extends State<userview> {

  String ?imgUrl;
  String urlImg='https://firebasestorage.googleapis.com/v0/b/apresentacao-a6686.appspot.com/o/user_icon.png?alt=media&token=7a3642be-350e-4b52-b833-7c59c0254297';

  var upload_bloc=UploadBloc();
  
  @override
  Widget build(BuildContext context) {

   /// recebendo os dados do usuario atual
    final userdados =
    context.select((AuthenticationBloc bloc) => bloc.state.get_Dados);

        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions:[
                ///fazerndo logout
                IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationSignedOut());
                    })
              ],
              title:const Center(child:Text("Meus Dados")),
            ),
            body:Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
        children: [
           CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey,
                      backgroundImage:(userdados["foto"]!=null)? NetworkImage(userdados["foto"]):NetworkImage(urlImg),
                    ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text("${userdados["nome"]}",style:const TextStyle(color: Colors.white,fontSize: 20),),
          Text(",${userdados["idade"].toString()} Anos",style:const TextStyle(color: Colors.white,fontSize: 20),)
          ],
        ),
        Text("${userdados["email"]}",style: TextStyle(color: Colors.white,fontSize: 20),),

        ],
        ),
            ));
  }
}