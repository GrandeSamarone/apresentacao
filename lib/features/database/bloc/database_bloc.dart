
import 'package:apresentacao/features/database/bloc/database_event.dart';
import 'package:apresentacao/features/database/bloc/database_state.dart';
import 'package:apresentacao/features/database/database_repository_impl.dart';
import 'package:apresentacao/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseRepository _databaseRepository;


  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseFetched>(_fetchUserData);
  }

  ///recebe a lista de usuarios e emit um sucesso com os dados
  _fetchUserData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
      List<UserModel> listofUserData = await _databaseRepository.retrieveUserData();
      emit(DatabaseSuccess(listofUserData,event.dados));
  }
}
