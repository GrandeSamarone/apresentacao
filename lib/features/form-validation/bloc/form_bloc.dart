import 'package:apresentacao/features/authentication/authentication_repository_impl.dart';

import 'package:apresentacao/features/database/database_repository_impl.dart';
import 'package:apresentacao/models/user_model.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormsValidate> {
  final AuthenticationRepository _authenticationRepository;
  final DatabaseRepository _databaseRepository;
  FormBloc(this._authenticationRepository, this._databaseRepository)
      : super(const FormsValidate(
            email: "example@gmail.com",
            senha: "",
            isEmailValid: true,
            isPasswordValid: true,
            isFormValid: false,
            isLoading: false,
            isNameValid: true,
            idade: 0,
            isAgeValid: true,
            isFormValidateFailed: false)) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<NameChanged>(_onNameChanged);
    on<AgeChanged>(_onAgeChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<FormSucceeded>(_onFormSucceeded);
  }
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  ///verificando se nao tem dados invalido no email
  bool _isEmailValid(String email) {
    return _emailRegExp.hasMatch(email);
  }

  ///verificando se nao tem dados invalido na senha
  bool _isPasswordValid(String password) {
    return _passwordRegExp.hasMatch(password);
  }


  ///verificando se o nome é vazio
  bool _isNameValid(String? displayName) {
    return displayName!.isNotEmpty;
  }

  ///verificando se a idade não é -1
  bool _isAgeValid(int age) {
    return age >= 1 && age <= 120 ? true : false;
  }

  ///recebendo o email
  _onEmailChanged(EmailChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValid: false,
      isFormValidateFailed: false,
      errorMessage: "",
      email: event.email,
      isEmailValid: _isEmailValid(event.email),
    ));
  }

  ///recebendo o senha
  _onPasswordChanged(PasswordChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      senha: event.senha,
      isPasswordValid: _isPasswordValid(event.senha),
    ));
  }

  ///recebendo o nome
  _onNameChanged(NameChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      nome: event.nome,
      isNameValid: _isNameValid(event.nome),
    ));
  }

  ///recebendo o idade
  _onAgeChanged(AgeChanged event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(
      isFormSuccessful: false,
      isFormValidateFailed: false,
      errorMessage: "",
      idade: event.idade,
      isAgeValid: _isAgeValid(event.idade),
    ));
  }


  ///recebe os dados e verifica se é um login ou um cadastro
  _onFormSubmitted(FormSubmitted event, Emitter<FormsValidate> emit) async {
    UserModel user = UserModel(
        email: state.email,
        senha: state.senha,
        idade: state.idade,
        nome: state.nome);

    if (event.value == Status.signUp) {
      await _updateUIAndSignUp(event, emit, user);
    } else if (event.value == Status.signIn) {
      await _authenticateUser(event, emit, user);
    }
  }

  ///cadastro
  _updateUIAndSignUp(
      FormSubmitted event, Emitter<FormsValidate> emit, UserModel user) async {
    emit(
      state.copyWith(errorMessage: "",
        isFormValid: _isPasswordValid(state.senha) &&
            _isEmailValid(state.email) &&
            _isAgeValid(state.idade) &&
            _isNameValid(state.nome),
        isLoading: true));
    if (state.isFormValid) {
      try {

        UserCredential? authUser = await _authenticationRepository.signUp(user);
        UserModel updatedUser = user.copyWith(uid: authUser!.user!.uid,);
        await _databaseRepository.saveUserData(updatedUser);
          emit(state.copyWith(isLoading: false, errorMessage: ""));

      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(
            isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  ///login
  _authenticateUser(
      FormSubmitted event, Emitter<FormsValidate> emit, UserModel user) async {
    emit(state.copyWith(errorMessage: "", isFormValid: _isPasswordValid(state.senha) && _isEmailValid(state.email),
        isLoading: true));
    if (state.isFormValid) {
      try {
        UserCredential? authUser = await _authenticationRepository.signIn(user);
        emit(state.copyWith(isLoading: false, errorMessage: ""));
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: e.message, isFormValid: false));
      }
    } else {
      emit(state.copyWith(
          isLoading: false, isFormValid: false, isFormValidateFailed: true));
    }
  }

  ///emitiando um estado dizendo que foi sucesso
  _onFormSucceeded(FormSucceeded event, Emitter<FormsValidate> emit) {
    emit(state.copyWith(isFormSuccessful: true));
  }
}
