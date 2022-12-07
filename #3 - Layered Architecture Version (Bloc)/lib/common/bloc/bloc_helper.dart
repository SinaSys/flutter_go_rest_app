import 'package:flutter_bloc/flutter_bloc.dart';
import '../network/api_result.dart';
import 'generic_bloc_state.dart';

enum ApiOperation { select, create, update, delete }

typedef Emit<T> = Emitter<GenericBlocState<T>>;

mixin BlocHelper<T> {
  ApiOperation operation = ApiOperation.select;

  _checkFailureOrSuccess(ApiResult failureOrSuccess, Emit<T> emit) {
    failureOrSuccess.when(
      failure: (String failure) {
        emit(GenericBlocState.failure(failure));
      },
      success: (_) {
        emit(GenericBlocState.success(null));
      },
    );
  }

  _apiOperationTemplate(Future<ApiResult> apiCallback, Emit<T> emit) async {
    emit(GenericBlocState.loading());
    ApiResult failureOrSuccess = await apiCallback;
    _checkFailureOrSuccess(failureOrSuccess, emit);
  }

  Future<void> getItems(
      Future<ApiResult<List<T>>> apiCallback, Emit<T> emit) async {
    emit(GenericBlocState.loading());
    ApiResult<List<T>> failureOrSuccess = await apiCallback;

    failureOrSuccess.when(
      failure: (String failure) async {
        emit(GenericBlocState.failure(failure));
      },
      success: (List<T> items) async {
        if (items.isEmpty) {
          emit(GenericBlocState.empty());
        } else {
          emit(GenericBlocState.success(items));
        }
      },
    );
  }

  Future<void> createItem(Future<ApiResult> apiCallback, Emit<T> emit) async {
    await _apiOperationTemplate(apiCallback, emit);
  }

  Future<void> updateItem(Future<ApiResult> apiCallback, Emit<T> emit) async {
    await _apiOperationTemplate(apiCallback, emit);
  }

  Future<void> deleteItem(Future<ApiResult> apiCallback, Emit<T> emit) async {
    await _apiOperationTemplate(apiCallback, emit);
  }
}
