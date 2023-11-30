import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_todo_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/update_todo_usecase.dart';

void main() {
  late UpdateTodoUseCase updateTodoUseCase;
  late MockTodoRepository mockTodoRepository;

  setUp(
    () {
      mockTodoRepository = MockTodoRepository();
      updateTodoUseCase = UpdateTodoUseCase(mockTodoRepository);
    },
  );

  test(
    'Should call updateTodo from Todo repository',
    () async {
      when(mockTodoRepository.updateTodo(tTodoDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await updateTodoUseCase.call(UpdateTodoParams(tTodoDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockTodoRepository.updateTodo(tTodoDummyObject));

      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
