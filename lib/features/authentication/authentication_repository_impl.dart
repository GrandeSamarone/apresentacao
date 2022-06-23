import 'package:apresentacao/features/authentication/authenticate_service.dart';
import 'package:apresentacao/features/database/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:apresentacao/models/user_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationService service = AuthenticationService();
  DatabaseService dbService = DatabaseService();

  ///Dados Atuais
  @override
  Stream<UserModel> getCurrentUser() {
    return service.retrieveCurrentUser();
  }

  ///Login
  @override
  Future<UserCredential?> signUp(UserModel user) {
    try {
      return service.signUp(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  ///Cadastro
  @override
  Future<UserCredential?> signIn(UserModel user) {
    try {
      return service.signIn(user);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  ///sair
  @override
  Future<void> signOut() {
    return service.signOut();
  }

  @override
  Future<Map<String,dynamic>> retrieveUser(UserModel user) {
    return dbService.retrieveUser(user);
  }
}

abstract class AuthenticationRepository {
  Stream<UserModel> getCurrentUser();
  Future<UserCredential?> signUp(UserModel user);
  Future<UserCredential?> signIn(UserModel user);
  Future<void> signOut();
  Future<Map<String,dynamic>> retrieveUser(UserModel user);
}
