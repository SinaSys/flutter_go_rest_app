import 'package:mvvm_cubit/common/cubit/generic_cubit_state.dart';
import 'package:mvvm_cubit/view/post/screen/post_list_screen.dart';
import 'package:mvvm_cubit/view/todo/screen/todo_list_screen.dart';
import 'package:mvvm_cubit/view/user/widget/status_container.dart';
import 'package:mvvm_cubit/viewmodel/user/cubit/user_cubit.dart';
import 'package:mvvm_cubit/common/widget/spinkit_indicator.dart';
import 'package:mvvm_cubit/common/dialog/progress_dialog.dart';
import 'package:mvvm_cubit/common/cubit/generic_cubit.dart';
import 'package:mvvm_cubit/common/dialog/create_dialog.dart';
import 'package:mvvm_cubit/common/dialog/retry_dialog.dart';
import 'package:mvvm_cubit/common/dialog/delete_dialog.dart';
import 'package:mvvm_cubit/common/widget/empty_widget.dart';
import 'package:mvvm_cubit/common/widget/popup_menu.dart';
import 'package:mvvm_cubit/data/model/user/user.dart';
import 'package:mvvm_cubit/core/app_extension.dart';
import 'package:mvvm_cubit/core/app_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

enum Operation { edit, delete, post, todo }

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  PreferredSizeWidget get _appBar {
    return AppBar(
      leading: IconButton(
        onPressed: () => context.read<UserCubit>().getUserList(),
        icon: const Icon(Icons.refresh),
      ),
      actions: [
        PopupMenu<UserStatus>(
          icon: Icons.filter_list_outlined,
          items: UserStatus.values,
          onChanged: (UserStatus value) {
            context.read<UserCubit>().getUserList(status: value);
          },
        ),
        PopupMenu<Gender>(
          icon: Icons.filter_alt_outlined,
          items: Gender.values,
          onChanged: (Gender value) {
            context.read<UserCubit>().getUserList(gender: value);
          },
        )
      ],
      title: const Text("Users"),
    );
  }

  Widget get floatingActionButton {
    return FloatingActionButton(
      onPressed: () async {
        late User user;
        bool isCreate = await createDialog(
          context: context,
          userData: (User userValue) => user = userValue,
        );

        if (isCreate) {
          if (!mounted) return;
          context.read<UserCubit>().createUser(user);
          showDialog(
            context: context,
            builder: (_) {
              return BlocBuilder<UserCubit, GenericCubitState<List<User>>>(
                builder: (BuildContext context,
                    GenericCubitState<List<User>> state) {
                  switch (state.status) {
                    case Status.empty:
                      return const SizedBox();
                    case Status.loading:
                      return const ProgressDialog(
                        title: "Creating user...",
                        isProgressed: true,
                      );
                    case Status.failure:
                      return RetryDialog(
                        title: state.error ?? "Error",
                        onRetryPressed: () =>
                            context.read<UserCubit>().createUser(user),
                      );
                    case Status.success:
                      return ProgressDialog(
                        title: "Successfully created",
                        onPressed: () {
                          context.read<UserCubit>().getUserList();
                          Navigator.pop(context);
                        },
                        isProgressed: false,
                      );
                  }
                },
              );
            },
          );
        }
      },
      child: const Icon(Icons.add),
    );
  }

  Widget userListItem(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Row(
          children: [
            Image.asset(user.gender.name.getGenderWidget, height: 75),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: headLine4),
                  const SizedBox(height: 10),
                  Text(user.email, style: headLine6)
                ],
              ),
            ),
            const SizedBox(width: 15),
            StatusContainer(status: user.status),
            PopupMenu<Operation>(
              items: Operation.values,
              onChanged: (Operation value) async {
                switch (value) {
                  case Operation.post:
                    navigateTo(PostListScreen(user: user));
                    break;
                  case Operation.todo:
                    navigateTo(ToDoListScreen(user: user));
                    break;
                  case Operation.delete:
                    deleteUser(user);
                    break;
                  case Operation.edit:
                    editUser(user);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void deleteUser(User user) async {
    bool isAccepted = await deleteDialog(context);
    if (isAccepted) {
      if (!mounted) return;
      context.read<UserCubit>().deleteUser(user);
      showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<UserCubit, GenericCubitState<List<User>>>(
            builder:
                (BuildContext context, GenericCubitState<List<User>> state) {
              switch (state.status) {
                case Status.empty:
                  return const SizedBox();
                case Status.loading:
                  return const ProgressDialog(
                    title: "Deleting user...",
                    isProgressed: true,
                  );
                case Status.failure:
                  return RetryDialog(
                    title: state.error ?? "Error",
                    onRetryPressed: () =>
                        context.read<UserCubit>().deleteUser(user),
                  );
                case Status.success:
                  return ProgressDialog(
                    title: "Successfully deleted",
                    onPressed: () {
                      context.read<UserCubit>().getUserList();
                      Navigator.pop(context);
                    },
                    isProgressed: false,
                  );
              }
            },
          );
        },
      );
    }
  }

  void editUser(User user) async {
    late User userObj;
    bool isUpdate = await createDialog(
      user: user,
      type: Type.update,
      context: context,
      userData: (User userValue) {
        userObj = userValue;
      },
    );

    if (isUpdate) {
      if (!mounted) return;
      context.read<UserCubit>().updateUser(userObj);
      showDialog(
        context: context,
        builder: (_) {
          return BlocBuilder<UserCubit, GenericCubitState<List<User>>>(
            builder:
                (BuildContext context, GenericCubitState<List<User>> state) {
              switch (state.status) {
                case Status.empty:
                  return const SizedBox();
                case Status.loading:
                  return const ProgressDialog(
                    title: "Updating user...",
                    isProgressed: true,
                  );
                case Status.failure:
                  return RetryDialog(
                    title: state.error ?? "Error",
                    onRetryPressed: () =>
                        context.read<UserCubit>().updateUser(userObj),
                  );
                case Status.success:
                  return ProgressDialog(
                    title: "Successfully updated",
                    onPressed: () {
                      context.read<UserCubit>().getUserList();
                      Navigator.pop(context);
                    },
                    isProgressed: false,
                  );
              }
            },
          );
        },
      );
    }
  }

  void navigateTo(Widget screen) {
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: _appBar,
      body: BlocBuilder<UserCubit, GenericCubitState<List<User>>>(
        buildWhen: (prevState, curState) {
          return context.read<UserCubit>().operation == ApiOperation.select
              ? true
              : false;
        },
        builder: (BuildContext context, GenericCubitState<List<User>> state) {
          switch (state.status) {
            case Status.empty:
              return const EmptyWidget(message: "No user!");
            case Status.loading:
              return const SpinKitIndicator(type: SpinKitType.circle);
            case Status.failure:
              return RetryDialog(
                title: state.error ?? "Error",
                onRetryPressed: () => context.read<UserCubit>().getUserList(),
              );
            case Status.success:
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.data?.length ?? 0,
                itemBuilder: (_, index) {
                  User user = state.data![index];
                  return userListItem(user);
                },
              );
          }
        },
      ),
    );
  }
}
