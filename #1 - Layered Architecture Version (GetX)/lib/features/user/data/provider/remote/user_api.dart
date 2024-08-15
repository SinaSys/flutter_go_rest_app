import 'package:layered_architecture/features/user/data/model/user.dart';
import 'package:layered_architecture/common/network/api_base.dart';
import 'package:layered_architecture/core/api_config.dart';
import 'package:dartz/dartz.dart';

class UserApi extends ApiBase {
  //Create new user
  Future<Either<String, bool>> createUser(User user) async {
    return await makePostRequest(dioClient.dio!.post(ApiConfig.users, data: user));
  }

  //Delete single suer
  Future<Either<String, bool>> deleteUser(User user) async {
    return await makeDeleteRequest(dioClient.dio!.delete("${ApiConfig.users}/${user.id}"));
  }

  //Update single suer
  Future<Either<String, bool>> updateUser(User user) async {
    return await makePutRequest(dioClient.dio!.put("${ApiConfig.users}/${user.id}", data: user));
  }

  //Get user list | Filter user list by gender or status
  Future<Either<String, List<User>>> getUserList({
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

    Future<Either<String, List<User>>> result = makeGetRequest(
      dioClient.dio!.get(ApiConfig.users, queryParameters: queryParameters),
      User.fromJson,
    );

    return result;
  }
}
