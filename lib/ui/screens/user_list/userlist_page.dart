import 'package:bloc_sample/ui/screens/user_details/user_details_page.dart';
import 'package:bloc_sample/ui/screens/user_list/bloc/userlist_bloc.dart';
import 'package:bloc_sample/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});
  static const String route = "/";

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  var searchController = TextEditingController();
  late UserListBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<UserListBloc>(context);
    homeBloc.add(UserListInit());
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User List",
          style: TextStyle(color: Colors.white),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onTap:() {
            Navigator.pop(context);
          },
        ),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: BlocConsumer<UserListBloc, UserListState>(
        listener: (context, state) {
          if (state is ApiError) {
            String msg = state.errorMsg;
            var snackBar = SnackBar(
              content: Text("Error:$msg"),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            const Center(
              child: Column(
                children: [
                  CircularProgressIndicator(color: Colors.purple,),
                  Text(
                    "Loading...",
                    style: TextStyle(fontSize: 32),
                  ),
                ],
              ),
            );
          }

          if (state is ApiSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                var item = state.data[index];
                return ListTile(
                  onTap: () {
                    onItemclick(item.id.toString());
                  },
                  leading: Image.network(item.avatar ?? ""),
                  title: Text(item.firstName ?? " ${item.lastName}"),
                  subtitle: Text(item.email.toString()),
                );
              },
            );
          }

          return const Center(child: Column(children: [Text("Welcome")],));
        },
      ),
    );
  }

  void onItemclick(String id) {
    Navigator.pushNamed(context, UserDetailsPage.route, arguments: {NavigationKey.id: id});
  }
}
