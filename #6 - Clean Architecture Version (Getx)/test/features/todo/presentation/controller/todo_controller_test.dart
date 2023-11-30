import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'todo_controller_test.mocks.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../test_utils/data/test_data.dart';
import 'package:clean_architecture_getx/common/controller/base_controller.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/create_todo_usecase.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:clean_architecture_getx/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:clean_architecture_getx/features/todo/presentation/controller/todo_controller.dart';

@GenerateMocks([
  CreateTodoUseCase,
  UpdateTodoUseCase,
  DeleteTodoUseCase,
  GetTodoUseCase,
])
void main() {
  late ToDoController toDoController;
  late MockCreateTodoUseCase mockCreateTodoUseCase;
  late MockUpdateTodoUseCase mockUpdateTodoUseCase;
  late MockDeleteTodoUseCase mockDeleteTodoUseCase;
  late MockGetTodoUseCase mockGetTodoUseCase;

  setUp(
    () {
      mockGetTodoUseCase = MockGetTodoUseCase();
      mockCreateTodoUseCase = MockCreateTodoUseCase();
      mockUpdateTodoUseCase = MockUpdateTodoUseCase();
      mockDeleteTodoUseCase = MockDeleteTodoUseCase();

      toDoController = ToDoController(
        createTodoUseCase: mockCreateTodoUseCase,
        updateTodoUseCase: mockUpdateTodoUseCase,
        deleteTodoUseCase: mockDeleteTodoUseCase,
        getTodoUseCase: mockGetTodoUseCase,
      );
    },
  );

  group(
    'All test cases related to the createTodo',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(toDoController.apiStatus.value, ApiState.loading);

          when(mockCreateTodoUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await toDoController.createTodo(tTodoDummyObject);

          expect(toDoController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(toDoController.apiStatus.value, ApiState.loading);

          when(mockCreateTodoUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await toDoController.createTodo(tTodoDummyObject);

          expect(toDoController.apiStatus.value, ApiState.failure);

          expect(toDoController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the update todo',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(toDoController.apiStatus.value, ApiState.loading);

          when(mockUpdateTodoUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await toDoController.updateTodo(tTodoDummyObject);

          expect(toDoController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(toDoController.apiStatus.value, ApiState.loading);

          when(mockUpdateTodoUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await toDoController.updateTodo(tTodoDummyObject);

          expect(toDoController.apiStatus.value, ApiState.failure);

          expect(toDoController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the delete todo',
    () {
      test(
        'should emit [success] when data is gotten successfully',
        () async {
          expect(toDoController.apiStatus.value, ApiState.loading);

          when(mockDeleteTodoUseCase.call(any)).thenAnswer((_) async => const Right(true));

          await toDoController.deleteTodo(tTodoDummyObject);

          expect(toDoController.apiStatus.value, ApiState.success);
        },
      );

      test(
        'should emit [failure] when data is not gotten successfully',
        () async {
          expect(toDoController.apiStatus.value, ApiState.loading);

          when(mockDeleteTodoUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await toDoController.deleteTodo(tTodoDummyObject);

          expect(toDoController.apiStatus.value, ApiState.failure);

          expect(toDoController.errorMessage.value, tDummyExceptionMsg);
        },
      );
    },
  );

  group(
    'All test cases related to the getTodos',
    () {
      test(
        'should get list of todos when data is gotten successfully',
        () async {
          expect(toDoController.apiStatus.value, ApiState.loading);

          when(mockGetTodoUseCase.call(any)).thenAnswer((_) async => Right([tTodoDummyObject]));

          await toDoController.getTodos(tDummyId);

          expect(
            toDoController.todoList,
            allOf(
              hasLength(1),
              [tTodoDummyObject],
            ),
          );
          expect(toDoController.todosCount.value, equals(1));
        },
      );

      test(
        'todosCount should be zero when data is not gotten successfully',
        () async {
          when(mockGetTodoUseCase.call(any)).thenAnswer((_) async => const Left(tDummyExceptionMsg));

          await toDoController.getTodos(tDummyId);

          expect(toDoController.todosCount.value, isZero);
        },
      );
    },
  );
}
