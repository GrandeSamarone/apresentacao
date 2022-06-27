
import 'dart:ui';

import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:apresentacao/view/home_view.dart';
import 'package:apresentacao/view/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

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
              ///authenticando o usuario
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
            ///se o usuario autenticar ele envia para a splash screen
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
          body: Center(
              child: SingleChildScrollView(
            child:
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              Image.asset("imagens/iconlogin.png",width:100,),

                   const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0,
                        )),

                      const SizedBox(height:30),

              const Text("+ de 2 Milhões de usuário!",
                style: TextStyle(color:Colors.grey),),

              const   Padding(padding: EdgeInsets.only(bottom:8)),
              const _EmailField(),
             const SizedBox(height:8),
              const _PasswordField(),
                      const SizedBox(height: 8),
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
                icon:const Icon(Icons.person,color: Colors.white,),
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
        return Container(
          width:280,
          child: TextFormField(
            style:const TextStyle(
              color:Colors.white,
              fontSize: 14.0,
              fontFamily: "Brand-Regular",),
            obscureText: true,
            decoration: InputDecoration(
              icon:const Icon(Icons.password,color: Colors.white,),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              enabledBorder: const OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 0.0),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color:Colors.white, width: 3.0)),
              helperText: '''A senha deve ter pelo menos 8 caracteres com pelo menos uma letra e um número''',
              helperStyle: const TextStyle(color: Colors.grey),
              helperMaxLines: 2,
              labelText: 'Senha',
              labelStyle:const TextStyle(color: Colors.grey),
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''A senha deve ter pelo menos 8 caracteres com pelo menos uma letra e um número'''
                  : null,
              errorStyle: const TextStyle(color: Colors.red),
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
            ? const Center(child: CircularProgressIndicator())
            : Container(
                    width:280,
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
                  color: Colors.white,
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
