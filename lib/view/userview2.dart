import 'dart:ui';
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/upload_img/upload_img_bloc.dart';
import 'package:apresentacao/features/upload_img/upload_img_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../features/UploadImgBloc/UploadImgBloc.dart';

class userview2 extends StatefulWidget {

  @override
  State<userview2> createState() => _userviewState();
}

class _userviewState extends State<userview2> {

  String ?imgUrl;
  String urlImg='https://firebasestorage.googleapis.com/v0/b/apresentacao-a6686.appspot.com/o/user_icon.png?alt=media&token=7a3642be-350e-4b52-b833-7c59c0254297';

  var upload_bloc=UploadBloc();

  @override
  Widget build(BuildContext context) {

    /// recebendo os dados do usuario atual
    final userdados = context.select((AuthenticationBloc bloc) => bloc.state.get_Dados);

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
              BlocBuilder<UploadImgBloc,UploadState>(
                  builder:(context,state){
                    if(state is UploadError){
                      return Text("${state.message}",style: const TextStyle(color: Colors.red));
                    }
                    if(state is UploadLoading){
                      return const Expanded(child: Center(child: CircularProgressIndicator()));
                    }
                    // if(snapshot.connectionState== ConnectionState.waiting){
                    //   return const Expanded(child: Center(child: CircularProgressIndicator()));
                    // }

                    state = state as UploadSucess;

                    if(state.data.isEmpty){
                      return TextButton(
                        child: Text("click aqui",style: TextStyle(color: Colors.white),),
                        onPressed: () {  //context.read<UploadImgBloc>().add();
                          },);
                    }
                    return InkWell(
                        child: CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.grey,
                          backgroundImage:(state.data["foto"]!=null)? NetworkImage(state.data["foto"]):NetworkImage(urlImg),
                          child: Container(
                            alignment: Alignment.center,
                            height: 190,
                            decoration: BoxDecoration(
                                color: Colors.grey
                                    .withOpacity(0.4),
                                borderRadius: const BorderRadius
                                    .all(Radius.circular(100))
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "alterar"
                                    , style:
                                  TextStyle(
                                      fontFamily: "Brand-Regular",
                                      color: Colors.white,
                                      fontSize: 16
                                  ),
                                  ),
                                  Icon(Icons.camera_alt
                                    , color: Colors.white,)
                                ]
                            ),
                          ),
                        ),


                        onTap: (){context.read<UploadImgBloc>().add("4TLQ7bAa3aMGEzweXDRlbFfMH6U2");}

                    );
                  }
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