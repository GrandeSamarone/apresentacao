
import 'package:equatable/equatable.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object?> get props => [];
}

class DatabaseFetched extends DatabaseEvent {
  final String? nome;
  const DatabaseFetched(this.nome);
  @override
  List<Object?> get props => [nome];
}
