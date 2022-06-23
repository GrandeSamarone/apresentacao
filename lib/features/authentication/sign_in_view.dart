
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:apresentacao/features/form-validation/sign_up_view.dart';
import 'package:apresentacao/view/home_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(color:  Color(0xFFEFEFEF), width: 3.0));

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

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
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          backgroundColor: const Color(0xFFFFFFFF),
          body: Center(
              child: SingleChildScrollView(
            child:
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Image.asset("imagens/sign.png",width: size.width*0.4,),
                   const Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),

              SizedBox(height: size.height * 0.01),

              const Text("+ de 2 Milhões de usuário!",
                style: TextStyle(color:Colors.black54),),

              Padding(padding: EdgeInsets.only(bottom: size.height * 0.02)),
              const _EmailField(),
              SizedBox(height: size.height * 0.01),
              const _PasswordField(),
              SizedBox(height: size.height * 0.01),
              const _SubmitButton(),
              const _SignInNavigate(),
            ]),
          ))),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return Container(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'complete o email ex:joe@gmail.com',
                errorText: !state.isEmailValid
                    ? 'Por favor inserir um email valido'
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
        return Container(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              border: border,
              helperText: '''A senha deve ter pelo menos 8 caracteres com pelo menos uma letra e um número''',
              helperMaxLines: 2,
              labelText: 'Senha',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''A senha deve ter pelo menos 8 caracteres com pelo menos uma letra e um número'''
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
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                width: size.width * 0.8,
                child: ElevatedButton(
                  onPressed: !state.isFormValid
                      ? () => context
                          .read<FormBloc>()
                          .add(const FormSubmitted(value: Status.signIn))
                      : null,
                  child: const Text("Login"),
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

class _SignInNavigate extends StatelessWidget {
  const _SignInNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Não tem uma conta?",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Brand-Regular",
                  fontWeight: FontWeight.w100,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => const SignUpView()),
                  );
                },
                child: const Text(
                  "Cadastre-se!",
                  style: TextStyle(
                      color: Color(0xffc83535),
                      fontFamily: "Brand-Regular",
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          );
  }
}

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Informação:"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}
