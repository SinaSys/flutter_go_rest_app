import 'package:clean_architecture_bloc/common/network/api_result.dart';

abstract class UseCase<Type, Params> {
  Future<ApiResult<Type>> call(Params params);
}
