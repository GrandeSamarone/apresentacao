
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
      @override
  List<Object?> get props => [];
}

class AuthenticationSuccess extends AuthenticationState {
  Map<String,dynamic> dados;
   AuthenticationSuccess({required this.dados});

    @override
  List<Object?> get props => [dados];
}

class AuthenticationFailure extends AuthenticationState {
      @override
  List<Object?> get props => [];
}
