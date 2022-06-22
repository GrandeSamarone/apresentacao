
import 'package:apresentacao/features/authentication/authentication_repository_impl.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthenticationStarted) {
        UserModel user = await _authenticationRepository.getCurrentUser().first;
        if (user.uid != "uid") {
          Map<String,dynamic> displayDados = await _authenticationRepository.retrieveUser(user);
          emit(AuthenticationSuccess(dados:displayDados));
        } else {
          emit(AuthenticationFailure());
        }
      }
      else if(event is AuthenticationSignedOut){
        await _authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }
}
