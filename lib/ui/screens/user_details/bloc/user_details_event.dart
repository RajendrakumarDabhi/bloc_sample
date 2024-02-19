part of 'user_details_bloc.dart';


sealed class UserDetailsEvent {}

final class UserDetailsInitial extends UserDetailsEvent {
  String userId;
  UserDetailsInitial(this.userId);
}

final class UserDetailsLoading extends UserDetailsEvent {}

final class UserDetailsApiSuccess extends UserDetailsEvent {
  Data data;
  UserDetailsApiSuccess(this.data);
}

final class UserDetailsApiError extends UserDetailsEvent {
  final String errorMsg;
  UserDetailsApiError(this.errorMsg);
}