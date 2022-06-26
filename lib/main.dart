import 'package:apresentacao/NavigationService.dart';
import 'package:apresentacao/features/database/database_service.dart';
import 'package:apresentacao/features/movies/movie_cubit.dart';
import 'package:apresentacao/features/movies/movie_repository.dart';
import 'package:apresentacao/features/upload_img/upload_img_bloc.dart';
import 'package:apresentacao/view/Splash_view.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:apresentacao/AppBlocObserver.dart';
import 'package:apresentacao/features/authentication/authentication_repository_impl.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/database/bloc/database_bloc.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
        () => runApp(
            MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          AuthenticationBloc(AuthenticationRepositoryImpl())
            ..add(AuthenticationStarted()),
        ),
        BlocProvider(
          create: (context) => FormBloc(
              AuthenticationRepositoryImpl(), DatabaseService()),
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
        BlocProvider(create: (context)=>UploadImgBloc())
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
      navigatorKey: NavigationService.navigatorKeyGlobal,
        home: Splash_View(),
        theme: ThemeData(
          primarySwatch: Colors.red,
          scaffoldBackgroundColor: const Color(0xFF403939),
          cardColor:const Color(0xFF403939),
          canvasColor:const Color(0xFF403939),
        ),
        title:"Mega Flix",);
  }
}
