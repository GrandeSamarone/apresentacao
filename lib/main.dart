import 'package:apresentacao/features/posts/bloc/post_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:apresentacao/AppBlocObserver.dart';
import 'package:apresentacao/features/authentication/authentication_repository_impl.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_event.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/features/database/bloc/database_bloc.dart';
import 'package:apresentacao/features/database/database_repository_impl.dart';
import 'package:apresentacao/features/form-validation/bloc/form_bloc.dart';
import 'package:apresentacao/features/posts/bloc/post_event.dart';
import 'package:apresentacao/utils/NavigationService.dart';
import 'package:apresentacao/view/home_view.dart';
import 'package:apresentacao/welcome_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
        () => runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          AuthenticationBloc(AuthenticationRepositoryImpl())
            ..add(AuthenticationStarted()),
        ),BlocProvider(
          create: (_) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        ),
        BlocProvider(
          create: (context) => FormBloc(
              AuthenticationRepositoryImpl(), DatabaseRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => DatabaseBloc(DatabaseRepositoryImpl()),
        )
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
        home: const BlocNavigate(),
        title:"Trabalho",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}

class BlocNavigate extends StatelessWidget {
  const BlocNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return  HomeView();
        } else {
          return const Welcome_view();
        }
      },
    );
  }
}
