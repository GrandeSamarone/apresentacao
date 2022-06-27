import 'package:apresentacao/features/NavigationService.dart';
import 'package:apresentacao/features/authentication/authenticate_service.dart';
import 'package:apresentacao/features/database/database_service.dart';
import 'package:apresentacao/features/movies/movie_cubit.dart';
import 'package:apresentacao/features/movies/movie_repository.dart';
import 'package:apresentacao/view/home_view.dart';
import 'package:apresentacao/view/sign_in_view.dart';
import 'package:dio/dio.dart';
import 'package:apresentacao/AppBlocObserver.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/database/bloc/database_bloc.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/noticias/bloc/not_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
        () => runApp(
            MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          AuthenticationBloc(AuthenticationService())
            ..add(AuthenticationStarted()),
        ),
        BlocProvider(
          create: (context) => FormBloc(
              AuthenticationService(), DatabaseService()),
        ),
        BlocProvider(
          create: (context) => NotBloc(DatabaseService()),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseService()),
        ) ,
        BlocProvider(
          create: (context) => MoviesCubit(
            repository: MovieRepository(
              Dio(),
            ),
          ),
        ),
      ],
      child: const App(),
    )),
    blocObserver: AppBlocObserver(),
  );
}
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeView(),
        navigatorKey: NavigationService.navigatorKeyGlobal,
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: const Color(0xFF403939),
          cardColor:const Color(0xFF403939),
          canvasColor:const Color(0xFF403939),
        ),
        title:"Mega Flix",);
  }
}
