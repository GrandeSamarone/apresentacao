
import 'package:apresentacao/features/database/bloc/database_event.dart';
import 'package:apresentacao/features/database/bloc/database_state.dart';
import 'package:apresentacao/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/news.dart';
import '../database_service.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {
  final DatabaseService _databaseRepository;


  DatabaseBloc(this._databaseRepository) : super(DatabaseInitial()) {
    on<DatabaseFetched>(_fetchUserData);
  }

  ///recebe a lista de noticias e emit um sucesso com os dados
  _fetchUserData(DatabaseFetched event, Emitter<DatabaseState> emit) async {
    List<News>  listOfNew = await _databaseRepository.retrieveNewsData();
      emit(DatabaseSuccess(listOfNew));
  }
}
