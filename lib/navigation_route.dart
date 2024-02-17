import 'package:bloc_sample/ui/screens/user_list/bloc/userlist_bloc.dart';
import 'package:bloc_sample/ui/screens/user_list/userlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationRoutes {
  final UserListBloc _homePageBloc = UserListBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _homePageBloc,
                  child: const UserListPage(),
                ));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
