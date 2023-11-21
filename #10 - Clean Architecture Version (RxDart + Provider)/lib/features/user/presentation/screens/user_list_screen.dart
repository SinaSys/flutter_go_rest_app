import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_architecture_rxdart/core/app_style.dart';
import 'package:clean_architecture_rxdart/core/app_extension.dart';
import 'package:clean_architecture_rxdart/common/widget/popup_menu.dart';
import 'package:clean_architecture_rxdart/common/widget/empty_widget.dart';
import 'package:clean_architecture_rxdart/common/dialog/retry_dialog.dart';
import 'package:clean_architecture_rxdart/common/dialog/create_dialog.dart';
import 'package:clean_architecture_rxdart/common/dialog/delete_dialog.dart';
import 'package:clean_architecture_rxdart/common/dialog/progress_dialog.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_rxdart/common/widget/spinkit_indicator.dart';
import 'package:clean_architecture_rxdart/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_rxdart/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture_rxdart/features/user/presentation/bloc/user_event.dart';
import 'package:clean_architecture_rxdart/features/todo/presentation/screens/todo_list_screen.dart';
import 'package:clean_architecture_rxdart/features/user/presentation/widgets/status_container.dart';
import 'package:clean_architecture_rxdart/features/post/presentation/screens/post_list_screen.dart';

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
        onPressed: () {
          context.read<UserBloc>().refreshUserList.add(const UsersFetched());
        },
        icon: const Icon(Icons.refresh),
      ),
      actions: [
        PopupMenu<UserStatus>(
          icon: Icons.filter_list_outlined,
          items: UserStatus.values,
          onChanged: (UserStatus value) {
            context
                .read<UserBloc>()
                .refreshUserList
                .add(UsersFetched(status: value));
          },
        ),
        PopupMenu<Gender>(
          icon: Icons.filter_alt_outlined,
          items: Gender.values,
          onChanged: (Gender value) {
            context
                .read<UserBloc>()
                .refreshUserList
                .add(UsersFetched(gender: value));
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
          context.read<UserBloc>().createUser.add(user);
          showDialog(
            context: context,
            builder: (_) {
              return StreamBuilder<GenericBlocState<bool>>(
                stream: context.read<UserBloc>().isUserCreated,
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    final userState = snapshot.requireData;
                    switch (userState.status) {
                      case Status.empty:
                        return const SizedBox();
                      case Status.loading:
                        return const SpinKitIndicator(
                          type: SpinKitType.circle,
                        );
                      case Status.failure:
                        return RetryDialog(
                          title: userState.error ?? "Error",
                          onRetryPressed: () {
                            context.read<UserBloc>().createUser.add(user);
                          },
                        );
                      case Status.success:
                        return ProgressDialog(
                          title: "Successfully created",
                          onPressed: () => Navigator.pop(context),
                          isProgressed: false,
                        );
                    }
                  }
                  else if (snapshot.hasError) {
                    return RetryDialog(
                      title: snapshot.error.toString(),
                      onRetryPressed: () {
                        context.read<UserBloc>().createUser.add(user);
                      },
                    );
                  }
                  else {
                    return const SpinKitIndicator(type: SpinKitType.circle);
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
      context.read<UserBloc>().deleteUser.add(user);
      showDialog(
        context: context,
        builder: (_) {
          return StreamBuilder<GenericBlocState<bool>>(
            stream: context.read<UserBloc>().isUserDeleted,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final userState = snapshot.requireData;
                switch (userState.status) {
                  case Status.empty:
                    return const SizedBox();
                  case Status.loading:
                    return const SpinKitIndicator(type: SpinKitType.circle);
                  case Status.failure:
                    return RetryDialog(
                      title: userState.error ?? "Error",
                      onRetryPressed: () {
                        context.read<UserBloc>().deleteUser.add(user);
                      },
                    );
                  case Status.success:
                    return ProgressDialog(
                      title: "Successfully deleted",
                      onPressed: () => Navigator.pop(context),
                      isProgressed: false,
                    );
                }
              }
              else if (snapshot.hasError) {
                return RetryDialog(
                  title: snapshot.error.toString(),
                  onRetryPressed: () {
                    context.read<UserBloc>().deleteUser.add(user);
                  },
                );
              }
              else {
                return const SpinKitIndicator(type: SpinKitType.circle);
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
      context.read<UserBloc>().updateUser.add(userObj);
      showDialog(
        context: context,
        builder: (_) {
          return StreamBuilder<GenericBlocState<bool>>(
            stream: context.read<UserBloc>().isUserUpdated,
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final userState = snapshot.requireData;
                switch (userState.status) {
                  case Status.empty:
                    return const SizedBox();
                  case Status.loading:
                    return const SpinKitIndicator(type: SpinKitType.circle);
                  case Status.failure:
                    return RetryDialog(
                      title: userState.error ?? "Error",
                      onRetryPressed: () {
                        context.read<UserBloc>().updateUser.add(userObj);
                      },
                    );
                  case Status.success:
                    return ProgressDialog(
                      title: "Successfully updated",
                      onPressed: () => Navigator.pop(context),
                      isProgressed: false,
                    );
                }
              }
              else if (snapshot.hasError) {
                return RetryDialog(
                  title: snapshot.error.toString(),
                  onRetryPressed: () {
                    context.read<UserBloc>().updateUser.add(userObj);
                  },
                );
              }
              else {
                return const SpinKitIndicator(type: SpinKitType.circle);
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
    context.read<UserBloc>().refreshUserList.add(const UsersFetched());
    super.initState();
  }

  @override
  void dispose() {
    context.read<UserBloc>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: _appBar,
      body: StreamBuilder<GenericBlocState<User>>(
        stream: context.read<UserBloc>().userList,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final userState = snapshot.requireData;
            switch (userState.status) {
              case Status.empty:
                return const EmptyWidget(message: "No user!");
              case Status.loading:
                return const SpinKitIndicator(type: SpinKitType.circle);
              case Status.failure:
                return RetryDialog(
                  title: userState.error ?? "Error",
                  onRetryPressed: () {
                    context
                        .read<UserBloc>()
                        .refreshUserList
                        .add(const UsersFetched());
                  },
                );
              case Status.success:
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: userState.data?.length ?? 0,
                  itemBuilder: (_, index) {
                    User user = userState.data![index];
                    return userListItem(user);
                  },
                );
            }
          } else if (snapshot.hasError) {
            return RetryDialog(
              title: snapshot.error.toString(),
              onRetryPressed: () {
                context.read<UserBloc>().refreshUserList.add(const UsersFetched());
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitIndicator(type: SpinKitType.circle);
          } else {
            return const Text("Unknown state");
          }
        },
      ),
    );
  }
}
