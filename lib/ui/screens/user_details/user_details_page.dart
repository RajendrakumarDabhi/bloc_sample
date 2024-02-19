import 'package:bloc_sample/domain/response/user_details_response.dart';
import 'package:bloc_sample/ui/screens/user_details/bloc/user_details_bloc.dart';
import 'package:bloc_sample/ui/screens/utils.dart';
import 'package:bloc_sample/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class UserDetailsPage extends StatefulWidget {
  static const String route = "user_details";
  Map<String, String> arguments;
  UserDetailsPage(this.arguments, {super.key}) {
    print("Arguemnt" + arguments.entries.first.toString());
  }

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState(arguments);
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  late UserDetailsBloc detailsBloc;
  Map<String, String> args;
  _UserDetailsPageState(this.args);

  @override
  void initState() {
    super.initState();
    detailsBloc = BlocProvider.of<UserDetailsBloc>(context);
    detailsBloc.add(UserDetailsInitial(args[NavigationKey.id]!));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<UserDetailsBloc, UserDetailsState>(
      listener: (context, state) {
        print("State" + state.toString());
      },
      builder: (context, state) {
        if (state is UserDetailsApiSuccessState) {
          return Scaffold(
            appBar: AppBar(
              title:  Text(
                state.data.firstName ?? "User",
                style: TextStyle(color: Colors.white),
              ),
              leading: GestureDetector(
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              backgroundColor: theme.colorScheme.primary,
            ),
            body: getUserUi(state.data),
          );
        } else if (state is UserDetailsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        } else {
          return const Center(child: CircularProgressIndicator(color: Colors.amber),);
        }
      },
    );
  }

  Widget getUserUi(Data user) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            spaceHeight(32),
             CircleAvatar(
                radius: 56,
                child: Padding(
                  padding: EdgeInsets.all(8), // Border radius
                   child: ClipOval(child:Image.network(user.avatar.toString())),
                )),
            Text(
              "${user.firstName} ${user.lastName}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              "${user.email}",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            )
          ],),
      ],
    );
  }
}
