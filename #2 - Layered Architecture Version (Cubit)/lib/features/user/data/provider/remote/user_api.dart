import '../../../../../common/network/api_base.dart';
import '../../../../../common/network/api_result.dart';
import '../../../../../core/api_config.dart';
import '../../model/user.dart';

class UserApi extends ApiBase<User> {

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

    Future<ApiResult<List<User>>> result = getData(
      dioClient.dio!.get(ApiConfig.users, queryParameters: queryParameters),
      User.fromJson,
    );

    return result;
  }

  //Create new user
  Future<ApiResult> createUser(User user) async {
    return await requestMethodTemplate(
      dioClient.dio!.post(ApiConfig.users, data: user),
    );
  }

  //Delete single suer
  Future<ApiResult> deleteUser(User user) async {
    return await requestMethodTemplate(
      dioClient.dio!.delete("${ApiConfig.users}/${user.id}"),
    );
  }

  //Update single suer
  Future<ApiResult> updateUser(User user) async {
    return await requestMethodTemplate(
      dioClient.dio!.put("${ApiConfig.users}/${user.id}", data: user),
    );
  }
}
