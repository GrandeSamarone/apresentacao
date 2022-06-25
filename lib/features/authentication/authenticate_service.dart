

import 'package:apresentacao/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  ///altera o estado do usuario se for diferente de null ele retorna os dados, senão ele
  ///preenche o uid com  a string uid;
  Stream<UserModel> retrieveCurrentUser() {
    return auth.authStateChanges().map((User? user) {
      if (user != null) {
        return UserModel(uid: user.uid, email: user.email);
      } else {
        return  UserModel(uid:"uid");
      }
    });
  }

///cadastrando firebase
  Future<UserCredential?> signUp(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user.email!,password: user.senha!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  ///Login firebase
  Future<UserCredential?> signIn(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user.email!, password: user.senha!);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }


  ///sair
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
