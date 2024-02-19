import 'package:bloc/bloc.dart';
import 'package:bloc_sample/api/dio_api_client.dart';
import 'package:bloc_sample/domain/repository/user_repository.dart';
import 'package:bloc_sample/domain/response/userlist_response.dart';

part 'userlist_event.dart';
part 'userlist_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  var userRepository = UserRepository(DioApiClient());

  UserListBloc() : super(Initial()) {
    on<UserListEvent>((event, emit) async {});
    on<UserListInit>(_getUserList);
  }

  Future<void> _getUserList(
      UserListInit event, Emitter<UserListState> emit) async {
    emit(Loading());
    try {
      var response = await userRepository.getUserList();
      var list = UserListResponse.fromJson(response.data).data ?? List.empty();
      Future.delayed(const Duration(seconds: 15));
      emit(ApiSuccess(list));
    } catch (exception) {
      emit(ApiError(exception.toString()));
    }
  }
}
