
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:apresentacao/screens/home_view.dart';
import 'package:apresentacao/utils/WIBusy.dart';
import 'package:apresentacao/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFEFEFEF), width: 3.0));

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    MaterialPageRoute(builder: (context) => const HomeView()),
                    (Route<dynamic> route) => false);
              }
            },
          ),
        ],
        child: Scaffold(
            backgroundColor: Color(0xFFFFFFFF),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // InkWell(
                      //   child:WIBusy(
                      //       busy:false,
                      //       child: CircleAvatar(
                      //         radius: 50,
                      //         backgroundColor: Colors.grey,
                      //         //  backgroundImage: NetworkImage(userController.motoboy!.icon_foto),
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           height: 110,
                      //           decoration: BoxDecoration(
                      //               color: Colors.grey.withOpacity(0.4),
                      //               borderRadius: const BorderRadius.all(
                      //                   Radius.circular(50))
                      //           ),
                      //           child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children:  const [
                      //                 Text(
                      //                   "alterar",
                      //                   style:
                      //                   TextStyle(
                      //                       fontFamily: "Brand-Regular",
                      //                       color: Colors.white,
                      //                       fontSize: 16
                      //                   ),
                      //                 ),
                      //                 Icon(Icons.camera_alt
                      //                   , color: Colors.white,)
                      //               ]
                      //           ),
                      //         ),
                      //       )
                      //   ),
                      //
                      //   onTap: () {
                      //     //   userController.pickerImage();
                      //   },
                      // ),
                      const Text("Cadastre-se abaixo!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          )),
                      Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.02)),
                      const _EmailField(),
                      SizedBox(height: size.height * 0.01),
                      const _PasswordField(),
                      SizedBox(height: size.height * 0.01),
                      const _DisplayNameField(),
                      SizedBox(height: size.height * 0.01),
                      const _AgeField(),
                      SizedBox(height: size.height * 0.01),
                      const _SubmitButton()
                    ]),
              ),
            )));
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'Um e-mail completo e válido, por exemplo joe@gmail.com',
                errorText: !state.isEmailValid
                    ? 'Verifique se o e-mail inserido é válido'
                    : null,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
                border: border,
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
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
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
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText: '''O nome deve ser válido!''',
              helperMaxLines: 2,
              labelText: 'Nome',
              errorMaxLines: 2,
              errorText:
                  !state.isNameValid ? '''O nome não pode ficar vazio!''' : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(NameChanged(value));
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
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
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
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ?  Center(child: CircularProgressIndicator())
            : SizedBox(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: !state.isFormValid
                      ? () => context
                      .read<FormBloc>().add(const FormSubmitted(value: Status.signUp))
                      : null,
                  child: const Text("Increver-se"),
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
                  MaterialPageRoute(builder: (context) => const WelcomeView()),
                  (Route<dynamic> route) => false)
              : Navigator.of(context).pop(),
        )
      ],
    );
  }
}
