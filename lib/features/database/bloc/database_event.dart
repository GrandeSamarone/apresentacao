
import 'package:equatable/equatable.dart';

abstract class DatabaseEvent extends Equatable {
  const DatabaseEvent();

  @override
  List<Object?> get props => [];
}

class DatabaseFetched extends DatabaseEvent {
  final Map<String,dynamic> dados;
  const DatabaseFetched(this.dados);
  @override
  List<Object?> get props => [dados];
}
