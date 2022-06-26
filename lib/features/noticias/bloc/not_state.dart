part of 'not_bloc.dart';

abstract class NotState extends Equatable {
  const NotState();
}

class FormInitial extends NotState {
  @override
  List<Object?> get props => [];
}

class FormsNotValidate extends NotState {
  const FormsNotValidate(
      {required this.titulo,
        required this.descricao,
        required this.foto,
        required this.isTituloValid,
        required this.isDescricaoValid,
        required this.isFormNotValid,
        required this.isLoadingNot,
        this.errorMessageNot = "",
        required this.isFormNotValidateFailed,
        this.isFormNotSuccessful = false});

  final String titulo;
  final String descricao;
  final String foto;
  final bool isTituloValid;
  final bool isDescricaoValid;
  final bool isFormNotValid;
  final bool isFormNotValidateFailed;
  final bool isLoadingNot;
  final String errorMessageNot;
  final bool isFormNotSuccessful;

  FormsNotValidate copyWith(
      {String? titulo,
        String? descricao,
        String? foto,
        bool? isTituloValid,
        bool? isDescricaoValid,
        bool? isFormNotValid,
        bool? isLoadingNot,
        String? errorMessageNot,
        bool? isFotoValid,
        bool? isFormNotValidateFailed,
        bool? isFormNotSuccessful}) {
    return FormsNotValidate(
        titulo: titulo ?? this.titulo,
        descricao: descricao ?? this.descricao,
        foto: foto ?? this.foto,
        isTituloValid: isTituloValid ?? this.isTituloValid,
        isDescricaoValid: isDescricaoValid ?? this.isDescricaoValid,
        isFormNotValid: isFormNotValid ?? this.isFormNotValid,
        isLoadingNot: isLoadingNot ?? this.isLoadingNot,
        errorMessageNot: errorMessageNot ?? this.errorMessageNot,
        isFormNotValidateFailed: isFormNotValidateFailed ?? this.isFormNotValidateFailed,
        isFormNotSuccessful: isFormNotSuccessful ?? this.isFormNotSuccessful);
  }

  @override
  List<Object?> get props => [
    titulo,
    descricao,
    foto,
    isTituloValid,
    isDescricaoValid,
    isFormNotValid,
    isLoadingNot,
    errorMessageNot,
    isFormNotValidateFailed,
    isFormNotSuccessful
  ];
}
