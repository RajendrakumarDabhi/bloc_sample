part of 'user_details_bloc.dart';

sealed class UserDetailsState {}

final class UserDetailsInitialState extends UserDetailsState {}

final class UserDetailsLoadingState extends UserDetailsState {}

final class UserDetailsApiSuccessState extends UserDetailsState {
   Data data;
  UserDetailsApiSuccessState(this.data);
}

final class UserDetailsApiErrorState extends UserDetailsState {
   String msg;
  UserDetailsApiErrorState(this.msg);
}