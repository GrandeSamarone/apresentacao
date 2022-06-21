part of 'database_bloc.dart';

abstract class DatabaseState extends Equatable {
  const DatabaseState();
  
  @override
  List<Object?> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseSuccess extends DatabaseState {
  final List<UserModel> listOfUserData;
  final String? nome;
  const DatabaseSuccess(this.listOfUserData,this.nome);

    @override
  List<Object?> get props => [listOfUserData,nome];
}

class DatabaseError extends DatabaseState {
      @override
  List<Object?> get props => [];
}