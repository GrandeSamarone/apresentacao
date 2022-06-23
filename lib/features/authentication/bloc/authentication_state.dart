
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  List<Object?> get props => [];
  Map<String,dynamic> get get_Dados => <String,dynamic>{};
}

///estado inicial da auth
class AuthenticationInitial extends AuthenticationState {
      @override
  List<Object?> get props => [];
      Map<String,dynamic> get get_Dados => <String,dynamic>{};
}
///estado de sucesso da auth
class AuthenticationSuccess extends AuthenticationState {
  Map<String,dynamic> dados;
   AuthenticationSuccess({required this.dados});

    @override
  List<Object?> get props => [dados];

    @override
    Map<String,dynamic> get get_Dados => dados;
}
///estado de error da auth
class AuthenticationFailure extends AuthenticationState {
      @override
  List<Object?> get props => [];
}
