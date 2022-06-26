import 'package:apresentacao/features/authentication/bloc/authentication_bloc.dart';
import 'package:apresentacao/features/authentication/bloc/authentication_state.dart';
import 'package:apresentacao/view/Splash_view.dart';
import 'package:apresentacao/view/list_view_films.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'list_news_view.dart';
import 'userview.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var pageController = PageController(initialPage: 0);

  var currentPage =0;

  @override
  Widget build(BuildContext context) {

    ///Verificando se o usuario está logado
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) =>Splash_View()),
              (Route<dynamic> route) => false);
        }
      },
      buildWhen: ((previous, current) {
        if (current is AuthenticationFailure) {
          return false;
        }
        return true;
      }),
      builder: (context, state) {
        return  WillPopScope(
            onWillPop: () async => false,
          child: Scaffold(
            body: PageView(
              controller:pageController,
              onPageChanged: (page) {
                currentPage=page;
              },
              children: [
                listviewfilms(),
                listnewsview(),
                userview(),
              ],),
          ///Navegação inferior
            bottomNavigationBar: BottomNavigationBar(
                    unselectedItemColor: Colors.grey,
                    currentIndex:currentPage,
                    showUnselectedLabels: true,
                    selectedItemColor: Colors.red,
                    selectedLabelStyle:const TextStyle(fontSize: 12.0),
                    onTap: (index) {
                      pageController.jumpToPage(index);
                      setState(() {});
                    },
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(Icons.favorite_outline),
                          label: "Filmes"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.book),
                          label: "Notícias"),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.perm_identity_rounded),
                          label: "Meus Dados"),
                    ],
                  )

          ),
        );

      },
    );
  }
}
