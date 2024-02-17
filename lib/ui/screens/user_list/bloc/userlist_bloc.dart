import 'package:bloc/bloc.dart';
import 'package:bloc_sample/api/dio_api_client.dart';
import 'package:bloc_sample/domain/repository/user_repository.dart';
import 'package:bloc_sample/domain/response/userlist_response.dart';

part 'userlist_event.dart';
part 'userlist_state.dart';

class UserListBloc extends Bloc<UserListEvent, UserListState> {
  var userRepository = UserRepository(DioApiClient());

  UserListBloc() : super(Initial()) {
    on<UserListEvent>((event, emit) async {
      if (event is UserListInit) {
        emit(Loading());
        try {
          var response = await userRepository.getUserList();
          var list =
              UserListResponse.fromJson(response.data).data ?? List.empty();
          emit(ApiSuccess(list));
        } catch (exception) {
          emit(ApiError(exception.toString()));
        }
        
      } else {}
    });
  }
}
