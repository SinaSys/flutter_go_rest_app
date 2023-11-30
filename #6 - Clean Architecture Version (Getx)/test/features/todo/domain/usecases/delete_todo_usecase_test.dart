import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_todo_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/delete_todo_usecase.dart';

void main() {
  late DeleteTodoUseCase deleteTodoUseCase;
  late MockTodoRepository mockTodoRepository;

  setUp(
    () {
      mockTodoRepository = MockTodoRepository();
      deleteTodoUseCase = DeleteTodoUseCase(mockTodoRepository);
    },
  );

  test(
    'Should call deleteTodo from Todo repository',
    () async {
      when(mockTodoRepository.deleteTodo(tTodoDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await deleteTodoUseCase.call(DeleteTodoParams(tTodoDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockTodoRepository.deleteTodo(tTodoDummyObject));

      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
