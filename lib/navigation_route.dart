import 'package:bloc_sample/ui/screens/user_details/bloc/user_details_bloc.dart';
import 'package:bloc_sample/ui/screens/user_details/user_details_page.dart';
import 'package:bloc_sample/ui/screens/user_list/bloc/userlist_bloc.dart';
import 'package:bloc_sample/ui/screens/user_list/userlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationRoutes {
  final UserListBloc _userListBloc = UserListBloc();
  final UserDetailsBloc _userDetailsBloc = UserDetailsBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case UserListPage.route:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _userListBloc,
                  child: const UserListPage(),
                ));

      case UserDetailsPage.route:
        var map = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _userDetailsBloc,
                  child: UserDetailsPage(map),
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
