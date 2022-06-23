
import 'package:apresentacao/models/user_model.dart';

import 'database_service.dart';

class DatabaseRepositoryImpl implements DatabaseRepository {
  DatabaseService service = DatabaseService();

  ///salvando no firebase
  @override
  Future<void> saveUserData(UserModel user) {
    return service.addUserData(user);
  }

  ///resgatando dados do firebase
  @override
  Future<List<UserModel>> retrieveUserData() {
    return service.retrieveUserData();
  }
}

abstract class DatabaseRepository {
  Future<void> saveUserData(UserModel user);
  Future<List<UserModel>> retrieveUserData();
}
