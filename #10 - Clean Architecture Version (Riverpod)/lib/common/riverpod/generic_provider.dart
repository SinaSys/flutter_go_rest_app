import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../network/api_result.dart';
import 'generic_state.dart';

enum ApiOperation { select, create, update, delete }

//enum Status { empty, loading, failure, success }

abstract class GenericStateNotifier<T> extends StateNotifier<GenericState<T>> {
  GenericStateNotifier() : super(GenericState.loading());
  ApiOperation apiOperation = ApiOperation.select;

 // HttpMethod get getHttpMethod => state.httpMethod!;

  _checkFailureOrSuccess(ApiResult failureOrSuccess) {
    failureOrSuccess.when(
      failure: (String failure) {
        state = GenericState.failure(failure);
      },
      success: (_) {
        state = GenericState.success(null);
      },
    );
  }

  Future<void> getItems(Future<ApiResult<List<T>>> apiCallback) async {
    apiOperation = ApiOperation.select;
    state = state.copyWith(status:Status.loading );
  //  state = const GenericState(status: Status.loading);
    ApiResult<List<T>> failureOrSuccess = await apiCallback;

    failureOrSuccess.when(
      failure: (String failure) {
        //state = GenericState.failure(failure);
        state = state.copyWith(status:Status.failure );

      },
      success: (List<T> items) {
        if (items.isEmpty) {
          state = GenericState.empty();
        } else {
         // state = GenericState.success(items);
          state = state.copyWith(status:Status.success,data: items );
        }
      },
    );
  }

  Future<void> createItem(Future<ApiResult> apiCallback) async {

    state = GenericState.loading();
    ApiResult failureOrSuccess = await apiCallback;
    _checkFailureOrSuccess(failureOrSuccess);
  }

  Future<void> updateItem(Future<ApiResult> apiCallback) async {
    state = GenericState.loading();
    ApiResult failureOrSuccess = await apiCallback;
    _checkFailureOrSuccess(failureOrSuccess);
  }

  Future<void> deleteItem(Future<ApiResult> apiCallback) async {
   apiOperation = ApiOperation.delete;
    state = const GenericState(status: Status.loading);

  //  state = GenericState.loading();
    ApiResult failureOrSuccess = await apiCallback;
    _checkFailureOrSuccess(failureOrSuccess);
  }
}
