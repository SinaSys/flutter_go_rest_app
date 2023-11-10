import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layered_architecture_cubit/core/app_style.dart';
import 'package:layered_architecture_cubit/core/app_extension.dart';
import 'package:layered_architecture_cubit/common/widget/drop_down.dart';
import 'package:layered_architecture_cubit/common/widget/popup_menu.dart';
import 'package:layered_architecture_cubit/common/widget/text_input.dart';
import 'package:layered_architecture_cubit/common/cubit/generic_cubit.dart';
import 'package:layered_architecture_cubit/common/dialog/retry_dialog.dart';
import 'package:layered_architecture_cubit/common/widget/empty_widget.dart';
import 'package:layered_architecture_cubit/features/user/data/model/user.dart';
import 'package:layered_architecture_cubit/features/todo/data/model/todo.dart';
import 'package:layered_architecture_cubit/common/dialog/progress_dialog.dart';
import 'package:layered_architecture_cubit/features/todo/cubit/todo_cubit.dart';
import 'package:layered_architecture_cubit/common/widget/date_time_picker.dart';
import 'package:layered_architecture_cubit/common/widget/spinkit_indicator.dart';
import 'package:layered_architecture_cubit/common/cubit/generic_cubit_state.dart';
import 'package:layered_architecture_cubit/features/todo/view/widget/todo_list_item.dart';

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
              final todoCubit = context.watch<TodoCubit>();
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  todoCubit.getTodoCount,
                  style: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          const Spacer(),
          PopupMenu<TodoStatus>(
            items: TodoStatus.values,
            onChanged: (TodoStatus status) {
              context
                  .read<TodoCubit>()
                  .getTodos(widget.user.id!, status: status);
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
      context.read<TodoCubit>().createTodo(todo);
    } else {
      context.read<TodoCubit>().updateTodo(todo);
    }
    Navigator.pop(context);

    showDialog(
      context: context,
      builder: (_) {
        return BlocBuilder<TodoCubit, GenericCubitState<List<ToDo>>>(
          builder: (BuildContext context, GenericCubitState<List<ToDo>> state) {
            return switch (state.status) {
              Status.empty => const SizedBox(),
              Status.loading => ProgressDialog(
                  title: "${mode.name}ing task...",
                  isProgressed: true,
                ),
              Status.failure => RetryDialog(
                  title: state.error ?? "Error",
                  onRetryPressed: () {
                    if (mode == Mode.create) {
                      context.read<TodoCubit>().createTodo(todo);
                    } else {
                      context.read<TodoCubit>().updateTodo(todo);
                    }
                  },
                ),
              Status.success => ProgressDialog(
                  title: "Successfully ${mode.name}ed",
                  onPressed: () {
                    context.read<TodoCubit>().getTodos(widget.user.id!);
                    Navigator.pop(context);
                  },
                  isProgressed: false,
                ),
            };
          },
        );
      },
    );
  }

  void todoBottomSheet(BuildContext context,
      {Mode mode = Mode.create,
      //required for edit mode
      int? todoId,
      TodoStatus todoStatus = TodoStatus.pending,
      required DateTime currentDateTime,
      String? taskTitle}) {
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
                            bool isValid =
                                formKey.currentState?.validate() ?? false;
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
        context.read<TodoCubit>().deleteTodo(todo);
        showDialog(
          context: context,
          builder: (_) {
            return BlocBuilder<TodoCubit, GenericCubitState<List<ToDo>>>(
              builder:
                  (BuildContext context, GenericCubitState<List<ToDo>> state) {
                return switch (state.status) {
                  Status.empty => const SizedBox(),
                  Status.loading => const ProgressDialog(
                      title: "Deleting task...",
                      isProgressed: true,
                    ),
                  Status.failure => RetryDialog(
                      title: state.error ?? "Error",
                      onRetryPressed: () =>
                          context.read<TodoCubit>().deleteTodo(todo),
                    ),
                  Status.success => ProgressDialog(
                      title: "Successfully deleted",
                      onPressed: () {
                        context.read<TodoCubit>().getTodos(widget.user.id!);
                        Navigator.pop(context);
                      },
                      isProgressed: false,
                    ),
                };
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
    context.read<TodoCubit>().getTodos(widget.user.id!);
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
            BlocBuilder<TodoCubit, GenericCubitState<List<ToDo>>>(
              buildWhen: (prevState, curState) {
                return context.read<TodoCubit>().operation ==
                        ApiOperation.select
                    ? true
                    : false;
              },
              builder:
                  (BuildContext context, GenericCubitState<List<ToDo>> state) {
                return switch (state.status) {
                  Status.empty => const EmptyWidget(message: "No Todos"),
                  Status.loading => const SpinKitIndicator(),
                  Status.failure => RetryDialog(
                      title: state.error ?? "Error",
                      onRetryPressed: () =>
                          context.read<TodoCubit>().getTodos(widget.user.id!),
                    ),
                  Status.success => taskList(state.data ?? []),
                };
              },
            )
          ],
        ),
      )),
    );
  }
}
