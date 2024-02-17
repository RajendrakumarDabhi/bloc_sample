import 'package:bloc_sample/ui/screens/user_list/bloc/userlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    homeBloc.add(UserListInit());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User List",
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(
          Icons.arrow_back,
          color: Colors.white,
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
              child: Text(
                "Loading...",
                style: TextStyle(fontSize: 32),
              ),
            );
          }

          if (state is ApiSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                var item = state.data[index];
                return ListTile(
                  leading: Image.network(item.avatar ?? ""),
                  title: Text(item.firstName ?? " ${item.lastName}"),
                  subtitle: Text(item.email.toString()),
                );
              },
            );
          }

          return Column();
        },
      ),
    );
  }
}
