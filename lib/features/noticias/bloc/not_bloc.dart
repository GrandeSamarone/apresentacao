import 'package:apresentacao/features/database/database_service.dart';
import 'package:apresentacao/models/news.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part'not_event.dart';
part'not_state.dart';

class NotBloc extends Bloc<NotEvent, FormsNotValidate> {

  final DatabaseService _databaseRepository;
  NotBloc( this._databaseRepository)
      : super(const FormsNotValidate(
      titulo: "example@gmail.com",
      descricao: "",
      foto: "",
      isTituloValid: true,
      isDescricaoValid: true,
      isFormNotValid: false,
      isLoadingNot: false,
      isFormNotValidateFailed: false)) {

    on<TituloChanged>(_onTituloChanged);
    on<DescChanged>(_onDescricaoChanged);
    on<FotoNewChanged>(_onFotoChanged);
    on<FormNotSubmitted>(_onFormNotSubmitted);
    on<FormNotSucceeded>(_onFormNotSucceeded);
  }
  final RegExp _tituloRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _descRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  ///verificando se nao tem dados invalido no email
  bool _isTituloValid(String titulo) {
    return _tituloRegExp.hasMatch(titulo);
  }

  ///verificando se nao tem dados invalido na senha
  bool _isDescValid(String descricao) {
    return _descRegExp.hasMatch(descricao);
  }

  ///verificando se o link da imagem é vazio
  bool _isFotoValid(String? link) {
    return link!.isNotEmpty;
  }

  ///recebendo o email
  _onTituloChanged(TituloChanged event, Emitter<FormsNotValidate> emit) {
    emit(state.copyWith(
      isFormNotSuccessful: false,
      isFormNotValid: false,
      isFormNotValidateFailed: false,
      errorMessageNot: "",
      titulo: event.titulo,
      isTituloValid: _isTituloValid(event.titulo),
    ));
  }

  ///recebendo desc
  _onDescricaoChanged(DescChanged event, Emitter<FormsNotValidate> emit) {
    emit(state.copyWith(
      isFormNotSuccessful: false,
      isFormNotValid: false,
      isFormNotValidateFailed: false,
      errorMessageNot: "",
      descricao: event.descricao,
      isDescricaoValid: _isDescValid(event.descricao),
    ));
  }


  ///recebendo o link
  _onFotoChanged(FotoNewChanged event, Emitter<FormsNotValidate> emit) {
    emit(state.copyWith(
      isFormNotSuccessful: false,
      isFormNotValidateFailed: false,
      errorMessageNot: "",
      foto: event.link,
      isFotoValid: _isFotoValid(event.link),
    ));
  }


  ///recebe os dados e verifica se é um login ou um cadastro
  _onFormNotSubmitted(FormNotSubmitted event, Emitter<FormsNotValidate> emit) async {
    News user = News(
        titulo: state.titulo,
        desc: state.descricao,
        foto: state.foto
    );

    if (event.value == StatusNew.cadastro) {
      await _updateUIAndSignUp(event, emit, user);
    }
  }

  ///cadastro
  _updateUIAndSignUp(FormNotSubmitted event, Emitter<FormsNotValidate> emit, News noticias) async {
    emit(state.copyWith(errorMessageNot: "",
        isFormNotValid:
            _isTituloValid(state.titulo) &&
            _isDescValid(state.descricao) &&
            _isFotoValid(state.foto),
        isLoadingNot: true));
    if (state.isFormNotValid) {
        await _databaseRepository.addNewsData(noticias);
        emit(state.copyWith(isLoadingNot: false, errorMessageNot: ""));

    } else {
      emit(state.copyWith(
          isLoadingNot: false, isFormNotValid: false, isFormNotValidateFailed: true));
    }
  }


  ///emitiando um estado dizendo que foi sucesso
  _onFormNotSucceeded(FormNotSucceeded event, Emitter<FormsNotValidate> emit) {
    emit(state.copyWith(isFormNotSuccessful: true));
  }
}
