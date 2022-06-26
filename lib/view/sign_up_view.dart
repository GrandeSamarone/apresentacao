
import 'package:apresentacao/features/UploadImgBloc/UploadImgBloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:apresentacao/features/upload_img/upload_img_bloc.dart';
import 'package:apresentacao/view/home_view.dart';
import 'package:apresentacao/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FormBloc, FormsValidate>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          ///exibindo o dialog do erro
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
        child: Scaffold(
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
                       _PasswordField(),
                       SizedBox(height:8),
                       _DisplayNameField(),
                       SizedBox(height:8),
                       _AgeField(),
                       SizedBox(height:8),
                       _SubmitButton()
                    ]),
              ),
            )));
  }
}

class _ImgField extends StatefulWidget {


  const _ImgField({Key? key}) : super(key: key);

  @override
  State<_ImgField> createState() => _ImgFieldState();
}

class _ImgFieldState extends State<_ImgField> {
  var uploadBLoc=UploadBloc();

  String urlImg='https://firebasestorage.googleapis.com/v0/b/apresentacao-a6686.appspot.com/o/user_icon.png?alt=media&token=7a3642be-350e-4b52-b833-7c59c0254297';

  @override
  Widget build(BuildContext context) {
        return StreamBuilder<String>(
          stream: uploadBLoc.userStream,
          builder: (context, snapshot) {
            print("OASKDSODKSODKSODK:::");
            print(snapshot.data);
            return InkWell(
                child: CircleAvatar(
                  radius:40,
                  backgroundColor: Colors.grey,
                  backgroundImage:(snapshot.data!=null)? NetworkImage(snapshot.data!):NetworkImage(urlImg),
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
                onTap: (){
                  uploadBLoc.inputEvent.add(BlocEvent.UploadEvent);
                }
            );
          }
        );

  }
}
class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return Container(
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
                errorText: !state.isEmailValid
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
class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

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
            obscureText: true,
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
                  '''A senha deve ter pelo menos 8 caracteres com pelo menos uma letra e um número''',
              helperMaxLines: 2,
              labelText: 'Senha',
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

class _DisplayNameField extends StatelessWidget {
  const _DisplayNameField({Key? key}) : super(key: key);

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
                  !state.isNameValid ? '''O nome não pode ficar vazio!''' : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(NameChanged(value));
              print("ONCHANGEDNAME");
              print(value);
            },
          ),
        );
      },
    );
  }
}

class _AgeField extends StatelessWidget {
  const _AgeField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width:280,
          child: TextFormField(
            style:const TextStyle(
              color:Colors.white,
              fontSize: 14.0,
              fontFamily: "Brand-Regular",),
            keyboardType: TextInputType.number,
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
              helperText: 'A idade deve ser válida, por exemplo. entre 1 - 120',
              helperMaxLines: 1,
              labelText: 'Idade',
              errorMaxLines: 1,
              errorText: !state.isAgeValid
                  ? 'A idade deve ser válida, por ex. entre 1 - 120'
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(AgeChanged(int.parse(value)));
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
