


import 'package:apresentacao/features/UploadImgBloc/UploadImgBloc.dart';
import 'package:apresentacao/features/UploadImgBloc/Upload_img_state.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:apresentacao/features/noticias/bloc/not_bloc.dart';
import 'package:apresentacao/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class NovaNewsView extends StatelessWidget {
  const NovaNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      Text("Cadastre-se abaixo!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                      Padding(padding: EdgeInsets.only(bottom:8)),
                      _ImgField(),
                      SizedBox(height:16),
                      _EmailField(),
                      SizedBox(height:8),
                      _DisplayNameField(),
                      SizedBox(height:8),
                      _SubmitButton()
                    ]),
              ),
            )
    );
  }
}

class _ImgField extends StatefulWidget {


  const _ImgField({Key? key}) : super(key: key);

  @override
  State<_ImgField> createState() => _ImgFieldState();
}

class _ImgFieldState extends State<_ImgField> {

  final uploadBLoc=UploadBloc();

  String urlImg='https://firebasestorage.googleapis.com/v0/b/apresentacao-a6686.appspot.com/o/user_icon.png?alt=media&token=7a3642be-350e-4b52-b833-7c59c0254297';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Upload_img_state>(
        stream: uploadBLoc.userStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          print("OASKDSODKSODKSODK:::");
          print(snapshot.data);
          print(state);
          if(!snapshot.hasData){
            return InkWell(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  backgroundImage:  NetworkImage(urlImg),
                  child: Container(
                    alignment: Alignment.center,
                    height: 90,
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
                onTap: () {
                  ClickImg();
                }
            );
          }
          if (state is upload_Error) {
            return Text("Error",style: TextStyle(color: Colors.red,fontSize: 20),);
            // return const Expanded(
            //   child: Center(child: CircularProgressIndicator(),),);
          }
          if (state is upload_Loading) {
            return  CircularProgressIndicator();
          }
          final linkdata=state as upload_sucess;
          context.read<NotBloc>().add(FotoNewChanged(linkdata.link));
          return InkWell(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage: (snapshot.data != null) ? NetworkImage(
                    linkdata.link) : NetworkImage(urlImg),
                child: Container(
                  alignment: Alignment.center,
                  height: 90,
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
              onTap: () {
                ClickImg();
              }
          );
        }
    );

  }

  ClickImg()async{
    final image_picker = ImagePicker();
    await Permission.photos.request();

    var CheckValidPermission = await Permission.photos.status;
    if(CheckValidPermission.isGranted){
      var file=(await image_picker.pickImage(
          source: ImageSource.gallery, imageQuality: 100, maxWidth: 400));
      if(file!=null){
        uploadBLoc.usersink.add(file);
      }
    }
  }
}
class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotBloc, FormsNotValidate>(
      builder: (context, state) {
        return Container(
          width:280,
          child: TextFormField(
              onChanged: (value) {
                context.read<NotBloc>().add(TituloChanged(value));
              },
              style:const TextStyle(
                color:Colors.white,
                fontSize: 14.0,
                fontFamily: "Brand-Regular",),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.white, width: 0.0),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEFEFEF), width: 3.0)),
                labelText: 'Email',
                labelStyle:const TextStyle(color: Colors.grey),
                helperText: 'complete o email ex:joe@gmail.com',
                helperStyle: const TextStyle(color: Colors.grey),
                errorText: !state.isTituloValid
                    ? 'Por favor inserir um email valido'
                    : null,
                errorStyle: const TextStyle(color: Colors.red),
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),

              )),
        );
      },
    );
  }
}

class _DisplayNameField extends StatelessWidget {
  const _DisplayNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotBloc, FormsNotValidate>(
      builder: (context, state) {
        return SizedBox(
          width: 280,
          child: TextFormField(
            style:const TextStyle(
              color:Colors.white,
              fontSize: 14.0,
              fontFamily: "Brand-Regular",),
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              enabledBorder: const OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 0.0),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color:  Colors.white, width: 3.0)),
              labelStyle:const TextStyle(color: Colors.grey),
              errorStyle: const TextStyle(color: Colors.red),
              hintStyle: const TextStyle(color: Colors.grey),
              helperStyle: const TextStyle(color: Colors.grey),
              helperText: '''O nome deve ser válido!''',
              helperMaxLines: 2,
              labelText: 'Nome',
              errorMaxLines: 2,
              errorText:
              !state.isDescricaoValid ? '''O nome não pode ficar vazio!''' : null,
            ),
            onChanged: (value) {
              context.read<NotBloc>().add(DescChanged(value));
              print("ONCHANGEDNAME");
              print(value);
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotBloc, FormsNotValidate>(
      builder: (context, state) {
        return state.isLoadingNot
            ?  Center(child: CircularProgressIndicator())
            : SizedBox(
          width:280,
          child: ElevatedButton(
            onPressed: !state.isFormNotValid
                ? () => context
                .read<NotBloc>().add(FormNotSubmitted(value: StatusNew.cadastro))
                : null,
            child: const Text("Inscrevar-se"),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              shadowColor: Colors.transparent,
              textStyle:const TextStyle(
                  color: Colors.white54,
                  fontSize: 23,
                  fontFamily: "Brand Bold"
                  , fontWeight: FontWeight.bold
              ),
            ),
          ),
        );
      },
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => errorMessage!.contains("Por favor, verifique seu e-mail")
              ? Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInView()),
                  (Route<dynamic> route) => false)
              : Navigator.of(context).pop(),
        )
      ],
    );
  }
}
