 import 'package:apresentacao/models/news.dart';
import 'package:apresentacao/models/user_model.dart';
import 'package:equatable/equatable.dart';

class DatabaseState extends Equatable {
  const DatabaseState();
  
  @override
  List<Object?> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseSuccess extends DatabaseState {
  final List<News> listOfNew;

  ///emitindo com sucesso
  const DatabaseSuccess(this.listOfNew);

    @override
  List<Object?> get props => [listOfNew];
}

///error
class DatabaseError extends DatabaseState {
      @override
  List<Object?> get props => [];
}
