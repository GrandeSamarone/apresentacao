
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}


///evento usuario esta logando
class AuthenticationStarted extends AuthenticationEvent {
      @override
  List<Object> get props => [];
}

///usuario esta saindo
class AuthenticationSignedOut extends AuthenticationEvent {
      @override
  List<Object> get props => [];
}