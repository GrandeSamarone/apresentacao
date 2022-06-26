part of 'form_bloc.dart';

enum Status { signIn, signUp }

abstract class FormEvent extends Equatable {
  const FormEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends FormEvent {
  final String email;
  const EmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends FormEvent {
  final String senha;
  const PasswordChanged(this.senha);

  @override
  List<Object> get props => [senha];
}

class NameChanged extends FormEvent {
  final String nome;
  const NameChanged(this.nome);

  @override
  List<Object> get props => [nome];
}

class FotoChanged extends FormEvent {
  final String link;
  const FotoChanged(this.link);

  @override
  List<Object> get props => [link];
}

class AgeChanged extends FormEvent {
  final int idade;
  const AgeChanged(this.idade);

  @override
  List<Object> get props => [idade];
}

class FormSubmitted extends FormEvent {
  final Status value;
  const FormSubmitted({required this.value});

  @override
  List<Object> get props => [value];
}

class FormSucceeded extends FormEvent {
  const FormSucceeded();

  @override
  List<Object> get props => [];
}
