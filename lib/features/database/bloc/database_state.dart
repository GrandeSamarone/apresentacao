 import 'package:apresentacao/models/user_model.dart';
import 'package:equatable/equatable.dart';

class DatabaseState extends Equatable {
  const DatabaseState();
  
  @override
  List<Object?> get props => [];
}

class DatabaseInitial extends DatabaseState {}

class DatabaseSuccess extends DatabaseState {
  final List<UserModel> listOfUserData;
 // final String? nome;
  final  Map<String,dynamic> dados;
  const DatabaseSuccess(this.listOfUserData,this.dados);
 // const DatabaseSuccess(this.listOfUserData,this.nome);

    @override
  List<Object?> get props => [listOfUserData,dados];
}

class DatabaseError extends DatabaseState {
      @override
  List<Object?> get props => [];
}
