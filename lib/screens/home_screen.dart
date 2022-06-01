import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import '../blocs/orders_bloc.dart';

import '../blocs/user_bloc.dart';
import '../tabs/orders_tab.dart';
import '../tabs/users_tab.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;

  int _page = 0;

  UserBloc _userBloc;

  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    _userBloc = UserBloc();
    _ordersBloc= OrdersBloc();
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.pinkAccent,
            primaryColor: Colors.white,
            textTheme: Theme.of(context).textTheme.copyWith(
              caption: TextStyle(
                color: Colors.white54
              )
            )
          ),
          child: BottomNavigationBar(
            currentIndex:_page,
            onTap: (p){
              _pageController.animateToPage(
                  p,
                  duration: Duration(microseconds: 500),
                  curve: Curves.ease
              );
            },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: "Clientes"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart),
                    label: "Pedidos"
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: "Produtos"
                )
              ]),
        ),
         body: Container(
           child: BlocProvider(
             blocs: [Bloc((i) => _userBloc)],
             dependencies: [],
             child: BlocProvider(
               blocs: [Bloc((i) => _ordersBloc)],
               dependencies: [],
               child: PageView(
                 controller: _pageController,
                 onPageChanged: (p){
                   setState(() {
                     _page = p;
                   });
                 },
                 children: [
                   UserTabs(),
                   OrdersTab(),
                   Container(color: Colors.purple,),
                 ],
               ),
             ),
           ),
         ),
      ),
    );
  }
}
