import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'create_todo_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:clean_architecture_getx/features/todo/domain/repositories/todo_repository.dart';

@GenerateMocks([TodoRepository])
void main() {
  late CreateTodoUseCase createTodoUseCase;
  late MockTodoRepository mockTodoRepository;

  setUp(
    () {
      mockTodoRepository = MockTodoRepository();
      createTodoUseCase = CreateTodoUseCase(mockTodoRepository);
    },
  );

  test(
    'Should call createTodo from Todo repository',
    () async {
      when(mockTodoRepository.createTodo(tTodoDummyObject)).thenAnswer(
        (_) async => const Right<String, bool>(true),
      );

      final result = await createTodoUseCase.call(CreateTodoParams(tTodoDummyObject));

      expect(result, const Right<String, bool>(true));

      verify(mockTodoRepository.createTodo(tTodoDummyObject));

      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
