import 'package:clean_architecture_cubit/common/cubit/generic_cubit_state.dart';
import 'package:clean_architecture_cubit/common/network/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ApiOperation { select, create, update, delete }

class GenericCubit<T> extends Cubit<GenericCubitState<List<T>>> {
  GenericCubit() : super(GenericCubitState.loading());

  ApiOperation operation = ApiOperation.select;

  _checkFailureOrSuccess(ApiResult failureOrSuccess) {
    failureOrSuccess.when(
      failure: (String failure) {
        emit(GenericCubitState.failure(failure));
      },
      success: (_) {
        emit(GenericCubitState.success(null));
      },
    );
  }

  _apiOperationTemplate(Future<ApiResult> apiCallback) async {
    emit(GenericCubitState.loading());
    ApiResult failureOrSuccess = await apiCallback;
    _checkFailureOrSuccess(failureOrSuccess);
  }

  Future<void> createItem(Future<ApiResult> apiCallback) async {
    operation = ApiOperation.create;
    _apiOperationTemplate(apiCallback);
  }

  Future<void> updateItem(Future<ApiResult> apiCallback) async {
    operation = ApiOperation.update;
    _apiOperationTemplate(apiCallback);
  }

  Future<void> deleteItem(Future<ApiResult> apiCallback) async {
    operation = ApiOperation.delete;
    _apiOperationTemplate(apiCallback);
  }

  Future<void> getItems(Future<ApiResult<List<T>>> apiCallback) async {
    operation = ApiOperation.select;
    emit(GenericCubitState.loading());
    ApiResult<List<T>> failureOrSuccess = await apiCallback;

    failureOrSuccess.when(
      failure: (String failure) {
        emit(GenericCubitState.failure(failure));
      },
      success: (List<T> items) {
        if (items.isEmpty) {
          emit(GenericCubitState.empty());
        } else {
          emit(GenericCubitState.success(items));
        }
      },
    );
  }
}
