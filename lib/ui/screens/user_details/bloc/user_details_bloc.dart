import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_sample/api/dio_api_client.dart';
import 'package:bloc_sample/domain/repository/user_repository.dart';
import 'package:bloc_sample/domain/response/user_details_response.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  var userRepository = UserRepository(DioApiClient());
  
  UserDetailsBloc() : super(UserDetailsInitialState()) {
    on<UserDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<UserDetailsInitial>(_getUserDetails);
  }

  Future<void> _getUserDetails(UserDetailsInitial event, Emitter<UserDetailsState> emit) async{
  emit(UserDetailsLoadingState());
    try {
      print("Api Calling");
      var response = await userRepository.getUserDetailsById(event.userId);
      var data = UserDetailsResponse.fromJson(response.data).data;
      print("Received Data" + data!.toString());
      emit(UserDetailsApiSuccessState(data));
    } catch (exception) {
      emit(UserDetailsApiErrorState(exception.toString()));
    }
  }
}
