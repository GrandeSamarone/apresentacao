
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:apresentacao/view/home_view.dart';
import 'package:apresentacao/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

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

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

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
