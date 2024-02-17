part of 'userlist_bloc.dart';

sealed class UserListState {}

final class Initial extends UserListState {}

final class Loading extends UserListState {}

final class ApiSuccess extends UserListState {
  List<Data> data;
  ApiSuccess(this.data);
}

final class ApiError extends UserListState {
  final String errorMsg;
  ApiError(this.errorMsg);
}
