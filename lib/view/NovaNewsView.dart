import 'dart:ui';

import 'package:apresentacao/features/noticias/UploadImg/UploadImgNewsState.dart';
import 'package:apresentacao/features/noticias/bloc/not_bloc.dart';
import 'package:apresentacao/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../features/noticias/UploadImg/Upload_Img_news.dart';

class NovaNewsView extends StatelessWidget {
  const NovaNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return BlocListener<NotBloc, FormsNotValidate>(
       listener: (context, state) {
     if (state.errorMessageNot.isNotEmpty) {
       ///exibindo o dialog do erro
       showDialog(
           context: context,
           builder: (context) =>
               ErrorDialog(errorMessage: state.errorMessageNot));

     } else if (state.isFormNotValid && !state.isLoadingNot) {
       context.read<NotBloc>().add(const FormNotSucceeded());
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text("Publicado com Sucesso!",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green));
     } else if (state.isFormNotValidateFailed) {
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(content: Text("Por favor, preencha os dados corretamente!")));
     }
   },
     child:Scaffold(
       appBar: AppBar(
         title:const Text("Publicar"),
       ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      _ImgField(),
                      SizedBox(height:16),
                      _TituloField(),
                      SizedBox(height:8),
                      _DescField(),
                      SizedBox(height:8),
                      _SubmitButton()
                    ]),
              ),
            )
    ));
  }
}

class _ImgField extends StatefulWidget {


  const _ImgField({Key? key}) : super(key: key);

  @override
  State<_ImgField> createState() => _ImgFieldState();
}

class _ImgFieldState extends State<_ImgField> {

  final uploadBLoc=UploadBlocNew();

  String urlImg='https://firebasestorage.googleapis.com/v0/b/apresentacao-a6686.appspot.com/o/News%2Fadd-photo.png?alt=media&token=86e92526-ad23-4214-a65d-1db42c5b6e55';
  ///imagem padrao para mostrar quando nao tiver nemhuma carregada
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UploadImgNewsState>(
        stream: uploadBLoc.newStream,
        builder: (context, snapshot) {
          final state = snapshot.data;
          if(!snapshot.hasData){
            return InkWell(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: ClipRRect(
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                      placeholder: 'imagens/loading-carregando.gif',
                      image:urlImg,
                    ),
                  ),
                ),
                onTap: () {
                  ClickImg();
                }
            );
          }
          if (state is upload_Errornew) {
            ///Error
            return Text("Error",style: TextStyle(color: Colors.red,fontSize: 20),);
          }
          if (state is upload_Loadingnew) {
            ///carregando
            return  CircularProgressIndicator();
          }
          final linkdata=state as upload_sucessnew;
          ///aqui ele ja manda o link e verifica se tem alguma irregularidade
          context.read<NotBloc>().add(FotoNewChanged(linkdata.link));
          return InkWell(
              child: Container(
                width: double.infinity,
                height: 200,
                child: ClipRRect(
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    placeholder: 'imagens/loading-carregando.gif',
                    image:linkdata.link,
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
    ///carrega a imagem
    final image_picker = ImagePicker();
    await Permission.photos.request();

    var CheckValidPermission = await Permission.photos.status;
    if(CheckValidPermission.isGranted){
      var file=(await image_picker.pickImage(
          source: ImageSource.gallery, imageQuality: 100, maxWidth: 400));
      if(file!=null){
        uploadBLoc.newsink.add(file);
      }
    }
  }
}
class _TituloField extends StatelessWidget {
  const _TituloField({Key? key}) : super(key: key);

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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.white, width: 0.0),
                ),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFEFEFEF), width: 3.0)),
                labelText: 'Titulo',
                labelStyle:const TextStyle(color: Colors.grey),
                helperText: 'seja criativo',
                helperStyle: const TextStyle(color: Colors.grey),
                errorText: !state.isTituloValid
                    ? 'Por favor inserir um texto valido'
                    : null,
                errorStyle: const TextStyle(color: Colors.red),
                hintText: 'Titulo',
                hintStyle: const TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),

              )),
        );
      },
    );
  }
}

class _DescField extends StatelessWidget {
  const _DescField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotBloc, FormsNotValidate>(
      builder: (context, state) {
        return SizedBox(
          width: 280,
          child: TextFormField(
            maxLines: 4,
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
              helperText: '''a descrição deve ser válido!''',
              helperMaxLines: 2,
              labelText: 'Descrição',
              errorMaxLines: 2,
              errorText:
              !state.isDescricaoValid ? '''a Descrição não pode ficar vazio!''' : null,
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
            child: const Text("Publicar"),
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
