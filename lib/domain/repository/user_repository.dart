import 'package:bloc_sample/api/dio_api_client.dart';
import 'package:bloc_sample/utils/constant.dart';
import 'package:dio/dio.dart';

class UserRepository {
  late DioApiClient apiClient;

  UserRepository(DioApiClient client) {
    apiClient = client;
  }

  Future<Response> getUserList() async {
    return await apiClient.get(Constants.userListApi);
  }
  
}
