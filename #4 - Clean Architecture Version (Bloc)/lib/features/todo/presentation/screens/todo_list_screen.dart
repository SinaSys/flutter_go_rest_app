import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_bloc/core/app_style.dart';
import 'package:clean_architecture_bloc/core/app_extension.dart';
import 'package:clean_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:clean_architecture_bloc/common/widget/drop_down.dart';
import 'package:clean_architecture_bloc/common/widget/popup_menu.dart';
import 'package:clean_architecture_bloc/common/widget/text_input.dart';
import 'package:clean_architecture_bloc/common/widget/empty_widget.dart';
import 'package:clean_architecture_bloc/features/user/data/models/user.dart';
import 'package:clean_architecture_bloc/common/widget/date_time_picker.dart';
import 'package:clean_architecture_bloc/features/todo/data/models/todo.dart';
import 'package:clean_architecture_bloc/common/bloc/generic_bloc_builder.dart';
import 'package:clean_architecture_bloc/features/todo/domain/entities/todo_entity.dart';
import 'package:clean_architecture_bloc/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:clean_architecture_bloc/features/todo/presentation/bloc/todo_event.dart';
import 'package:clean_architecture_bloc/features/todo/presentation/widgets/todo_list_item.dart';

enum Mode { create, update }

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({
    super.key,
    required this.user,
  });

  final User user;

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      centerTitle: true,
      title: const Text("Todos"),
    );
  }

  Widget header() {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Text("Todo", style: headLine2),
          const SizedBox(width: 10),
          const Icon(Icons.archive_outlined, color: Color(0xFFF4511E)),
          Builder(
            builder: (context) {
              final todoBloc = context.watch<TodoBloc>();
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  todoBloc.getTodoCount,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const Spacer(),
          PopupMenu<TodoStatus>(
            items: TodoStatus.values,
            onChanged: (TodoStatus status) {
              context.read<TodoBloc>().add(TodoFetched(widget.user.id!, status: status));
            },
          )
        ],
      ),
    );
  }

  Widget createTodo() {
    return Card(
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFFF4511E)),
          borderRadius: BorderRadius.circular(5),
        ),
        onTap: () {
          todoBottomSheet(
            context,
            currentDateTime: DateTime.now(),
            taskTitle: '',
          );
        },
        leading: const Icon(Icons.add, color: Color(0xFFF4511E)),
        title: const Text(
          "Add task",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  createOrUpdateTodo(ToDo todo, Mode mode) {
    if (mode == Mode.create) {
      context.read<TodoBloc>().add(TodoCreated(todo));
    } else {
      context.read<TodoBloc>().add(TodoUpdated(todo));
    }
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (_) {
        return GenericBlocBuilder<TodoBloc, ToDo>(
          successStatusTitle: "Successfully ${mode.name}d",
          progressStatusTitle: "${mode.name}ing task...",
          onRetryPressed: () {
            if (mode == Mode.create) {
              context.read<TodoBloc>().add(TodoCreated(todo));
            } else {
              context.read<TodoBloc>().add(TodoUpdated(todo));
            }
          },
          onSuccessPressed: () {
            context.read<TodoBloc>().add(TodoFetched(widget.user.id!));
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void todoBottomSheet(
    BuildContext context, {
    Mode mode = Mode.create,
    //required for edit mode
    int? todoId,
    TodoStatus todoStatus = TodoStatus.pending,
    required DateTime currentDateTime,
    String? taskTitle,
  }) {
    final formKey = GlobalKey<FormState>();
    String title = taskTitle ?? "";
    DateTime dateTime = currentDateTime;
    TodoStatus status = todoStatus;

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.white,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextInput(
                        initialValue: title,
                        hint: "Enter title",
                        onChanged: (String value) {
                          title = value;
                        },
                        validator: (String? input) {
                          if (input!.length > 3) return null;
                          return "Title must be at least 4 characters";
                        },
                      ),
                      const SizedBox(height: 15),
                      DropDown<TodoStatus>(
                        initialItem: todoStatus,
                        items: const [TodoStatus.pending, TodoStatus.completed],
                        onChanged: (TodoStatus value) {
                          status = value;
                        },
                      ),
                      const SizedBox(height: 15),
                      DateTimePicker(
                        dateTime: mode == Mode.update ? currentDateTime : null,
                        selectedDateTime: (DateTime date) {
                          dateTime = date;
                        },
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            bool isValid = formKey.currentState?.validate() ?? false;
                            if (isValid) {
                              ToDo todo = ToDo(
                                id: todoId,
                                userId: widget.user.id!,
                                title: title,
                                dueOn: dateTime,
                                status: status,
                              );
                              createOrUpdateTodo(todo, mode);
                            }
                          },
                          child: Text(mode.name.toCapital),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }

  Widget taskList(List<ToDo> todos) {
    return TodoListItem(
      items: todos,
      onDeletePressed: (ToDo todo) {
        context.read<TodoBloc>().add(TodoDeleted(todo));
        showDialog(
          context: context,
          builder: (_) {
            return GenericBlocBuilder<TodoBloc, ToDo>(
              successStatusTitle: "Successfully deleted",
              progressStatusTitle: "Deleting task...",
              onRetryPressed: () {
                context.read<TodoBloc>().add(TodoDeleted(todo));
              },
              onSuccessPressed: () {
                context.read<TodoBloc>().add(TodoFetched(widget.user.id!));
                Navigator.pop(context);
              },
            );
          },
        );
      },
      onEditPressed: (ToDo todo) {
        todoBottomSheet(
          context,
          todoId: todo.id,
          mode: Mode.update,
          taskTitle: todo.title,
          todoStatus: todo.status,
          currentDateTime: todo.dueOn,
        );
      },
    );
  }

  @override
  void initState() {
    context.read<TodoBloc>().add(TodoFetched(widget.user.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              header(),
              createTodo(),
              GenericBlocBuilder<TodoBloc, ToDo>(
                buildWhen: (_, __) {
                  return context.read<TodoBloc>().operation == ApiOperation.select ? true : false;
                },
                emptyWidget: const EmptyWidget(message: "No Todos!"),
                successWidget: (state) => taskList(state.data ?? []),
                onRetryPressed: () {
                  context.read<TodoBloc>().add(TodoFetched(widget.user.id!));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
