import 'package:clean_architecture_getx/common/network/api_base.dart';
import 'package:clean_architecture_getx/common/network/api_config.dart';
import 'package:clean_architecture_getx/common/network/dio_client.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/user/domain/entities/user_entity.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> getUsers({Gender? gender, UserStatus? status});

  Future<bool> createUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> deleteUser(User user);
}

class UserRemoteDataSourceImpl with ApiBase implements UserRemoteDataSource {
  final DioClient dioClient;

  const UserRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<bool> createUser(User user) async {
    return await makePostRequest(
      dioClient.post(
        ApiConfig.users,
        data: user,
      ),
    );
  }

  @override
  Future<bool> updateUser(User user) async {
    return await makePutRequest(
      dioClient.put(
        "${ApiConfig.users}/${user.id}",
        data: user,
      ),
    );
  }

  @override
  Future<bool> deleteUser(User user) async {
    return await makeDeleteRequest(
      dioClient.delete(
        "${ApiConfig.users}/${user.id}",
      ),
    );
  }

  @override
  Future<List<User>> getUsers({Gender? gender, UserStatus? status}) async {
    Map<String, String> queryParameters = <String, String>{};

    if (gender != null && gender != Gender.all) {
      queryParameters.addAll({'gender': gender.name});
    }

    if (status != null && status != UserStatus.all) {
      queryParameters.addAll({'status': status.name});
    }

    return await makeGetRequest(
      dioClient.get(ApiConfig.users, queryParameters: queryParameters),
      User.fromJson,
    );
  }
}
