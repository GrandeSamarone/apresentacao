
import 'package:apresentacao/features/authentication/authenticate_service.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/models/user_model.dart';
import 'package:bloc/bloc.dart';



class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial()) {
    on<AuthenticationEvent>((event, emit) async {

      ///se o evento do usuarior for fazer o login
      if (event is AuthenticationStarted) {
        UserModel user = await _authenticationRepository.retrieveCurrentUser().first;

       /// verificando se realmente autenticou
        if (user.uid != "uid") {
          Map<String,dynamic> displayDados = await _authenticationRepository.retrieveUser(user);
          emit(AuthenticationSuccess(dados:displayDados));
        } else {
          emit(AuthenticationFailure());
        }
      } else if(event is AuthenticationSignedOut){
         ///quando o usuario clica pra sair
        await _authenticationRepository.signOut();
        emit(AuthenticationFailure());
      }
    });
  }
}
