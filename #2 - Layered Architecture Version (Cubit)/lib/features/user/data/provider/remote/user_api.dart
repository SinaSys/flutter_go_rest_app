import 'package:layered_architecture_cubit/features/user/data/model/user.dart';
import 'package:layered_architecture_cubit/common/network/api_result.dart';
import 'package:layered_architecture_cubit/common/network/api_base.dart';
import 'package:layered_architecture_cubit/core/api_config.dart';

class UserApi extends ApiBase {
  //Create new user
  Future<ApiResult> createUser(User user) async {
    return await makePostRequest(dioClient.dio!.post(ApiConfig.users, data: user));
  }

  //Update single suer
  Future<ApiResult> updateUser(User user) async {
    return await makePutRequest(dioClient.dio!.put("${ApiConfig.users}/${user.id}", data: user));
  }

  //Delete single suer
  Future<ApiResult> deleteUser(User user) async {
    return await makeDeleteRequest(dioClient.dio!.delete("${ApiConfig.users}/${user.id}"));
  }

  //Get user list | Filter user list by gender or status
  Future<ApiResult<List<User>>> getUserList({
    Gender? gender,
    UserStatus? status,
  }) async {
    Map<String, String> queryParameters = <String, String>{};

    if (gender != null && gender != Gender.all) {
      queryParameters.addAll({'gender': gender.name});
    }

    if (status != null && status != UserStatus.all) {
      queryParameters.addAll({'status': status.name});
    }

    Future<ApiResult<List<User>>> result = makeGetRequest(
      dioClient.dio!.get(ApiConfig.users, queryParameters: queryParameters),
      User.fromJson,
    );

    return result;
  }
}
