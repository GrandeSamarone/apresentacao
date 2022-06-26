part of 'not_bloc.dart';

enum StatusNew { cadastro }

abstract class NotEvent extends Equatable {
  const NotEvent();

  @override
  List<Object> get props => [];
}

class TituloChanged extends NotEvent {
  final String titulo;
  const TituloChanged(this.titulo);

  @override
  List<Object> get props => [titulo];
}
class DescChanged extends NotEvent {
  final String descricao;
  const DescChanged(this.descricao);

  @override
  List<Object> get props => [descricao];
}

class FotoNewChanged extends NotEvent {
  final String link;
  const FotoNewChanged(this.link);

  @override
  List<Object> get props => [link];
}

class FormNotSubmitted extends NotEvent {
  final StatusNew value;
  const FormNotSubmitted({required this.value});

  @override
  List<Object> get props => [value];
}

class FormNotSucceeded extends NotEvent {
  const FormNotSucceeded();

  @override
  List<Object> get props => [];
}
