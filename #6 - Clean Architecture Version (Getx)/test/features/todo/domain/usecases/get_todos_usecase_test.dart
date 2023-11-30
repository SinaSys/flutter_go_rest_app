import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'create_todo_usecase_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/features/todo/data/models/todo.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/get_todos_usecase.dart';

void main() {
  late GetTodoUseCase getTodoUseCase;
  late MockTodoRepository mockTodoRepository;

  setUp(
    () {
      mockTodoRepository = MockTodoRepository();
      getTodoUseCase = GetTodoUseCase(mockTodoRepository);
    },
  );

  test(
    'Should call getTodos from Todo repository',
    () async {
      when(mockTodoRepository.getTodos(any)).thenAnswer(
        (_) async => Right<String, List<ToDo>>([tTodoDummyObject]),
      );

      final result = await getTodoUseCase.call(
        const GetTodoParams(userId: tDummyId),
      );

      result.fold(
        (_) {},
        (List<ToDo> todos) => expect(todos, [tTodoDummyObject]),
      );

      verify(mockTodoRepository.getTodos(any));

      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
