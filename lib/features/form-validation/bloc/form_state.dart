part of 'form_bloc.dart';

abstract class FormState extends Equatable {
  const FormState();
}

class FormInitial extends FormState {
  @override
  List<Object?> get props => [];
}

class FormsValidate extends FormState {
  const FormsValidate(
      {required this.email,
      required this.senha,
      required this.isEmailValid,
      required this.isPasswordValid,
      required this.isFormValid,
      required this.isLoading,
      this.errorMessage = "",
      required this.isNameValid,
      required this.isAgeValid,
      required this.isFormValidateFailed,
        required this.nome,
      required this.idade,
      this.isFormSuccessful = false});

  final String email;
  final String nome;
  final int idade;
  final String senha;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isFormValid;
  final bool isNameValid;
  final bool isAgeValid;
  final bool isFormValidateFailed;
  final bool isLoading;
  final String errorMessage;
  final bool isFormSuccessful;

  FormsValidate copyWith(
      {String? email,
      String? senha,
      String? nome,
      bool? isEmailValid,
      bool? isPasswordValid,
      bool? isFormValid,
      bool? isLoading,
      int? idade,
      String? errorMessage,
      bool? isNameValid,
      bool? isAgeValid,
      bool? isFormValidateFailed,
      bool? isFormSuccessful}) {
    return FormsValidate(
        email: email ?? this.email,
        senha: senha ?? this.senha,
        nome: nome ?? this.nome,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isFormValid: isFormValid ?? this.isFormValid,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        isNameValid: isNameValid ?? this.isNameValid,
        idade: idade ?? this.idade,
        isAgeValid: isAgeValid ?? this.isAgeValid,
        isFormValidateFailed: isFormValidateFailed ?? this.isFormValidateFailed,
        isFormSuccessful: isFormSuccessful ?? this.isFormSuccessful);
  }

  @override
  List<Object?> get props => [
        email,
        senha,
         nome,
         idade,
        isEmailValid,
        isPasswordValid,
        isFormValid,
        isLoading,
        errorMessage,
        isNameValid,
        isFormValidateFailed,
        isFormSuccessful
      ];
}
