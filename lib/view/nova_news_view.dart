
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:apresentacao/view/home_view.dart';
import 'package:apresentacao/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NovaNewsView extends StatelessWidget {
  const NovaNewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<FormBloc, FormsValidate>(
            listener: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ErrorDialog(errorMessage: state.errorMessage));
              } else if (state.isFormValid && !state.isLoading) {
                context.read<AuthenticationBloc>().add(AuthenticationStarted());
                context.read<FormBloc>().add(const FormSucceeded());
              } else if (state.isFormValidateFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Por favor, preencha os dados corretamente!")));
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeView()),
                        (Route<dynamic> route) => false);
              }
            },
          ),
        ],
        child: Scaffold(
            appBar: AppBar(
              title:const Center(child:Text("Nova Notícia")),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      Padding(padding: EdgeInsets.only(bottom:8)),
                      _ImgField(),
                      SizedBox(height:18),
                      _TituloField(),
                      SizedBox(height:8),
                      _DescField(),
                      SizedBox(height:8),
                      _SubmitButton()
                    ]),
              ),
            )));
  }
}

class _ImgField extends StatelessWidget {
  const _ImgField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return  InkWell(
              child: ClipRRect(
               // radius: 100,
              //  backgroundColor: Colors.grey,
               // backgroundImage:(userdados["foto"]!=null)? NetworkImage(userdados["foto"]):NetworkImage(urlImg),
                child: Container(
                  alignment: Alignment.center,
                  width: 280,
                  height: 190,
                  decoration: BoxDecoration(
                      color: Colors.grey
                          .withOpacity(0.4),
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
            //  onTap: (){upload_bloc.inputEvent.add(BlocEvent.UploadEvent);}
          );
      },
    );
  }
}

class _TituloField extends StatelessWidget {
  const _TituloField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width:280,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              style:const TextStyle(
                color:Colors.white,
                fontSize: 14.0,
                fontFamily: "Brand-Regular",),
              keyboardType: TextInputType.emailAddress,
              decoration:const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.grey),
                helperStyle: TextStyle(color: Colors.grey),
                errorStyle:  TextStyle(color: Colors.red),
                hintStyle:  TextStyle(color: Colors.grey),
                contentPadding:  EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                enabledBorder:  OutlineInputBorder(
                  borderSide:  BorderSide(color: Colors.white, width: 0.0),
                ),
                border:  OutlineInputBorder(
                    borderSide: BorderSide(color:  Colors.white, width: 3.0))
                ,
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
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: 280,
          child: TextFormField(
            style:const TextStyle(
              color:Colors.white,
              fontSize: 14.0,
              fontFamily: "Brand-Regular",),
              maxLines: 4,
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
              helperText:
              '''Detalhes''',
              helperMaxLines: 2,
              labelText: 'Descrição',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''A senha deve ter pelo menos 8 caracteres e conter pelo menos uma letra e um número'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(value));
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
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ?  Center(child: CircularProgressIndicator())
            : SizedBox(
          width:280,
          child: ElevatedButton(
            onPressed: !state.isFormValid
                ? () => context
                .read<FormBloc>().add(const FormSubmitted(value: Status.signUp))
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
