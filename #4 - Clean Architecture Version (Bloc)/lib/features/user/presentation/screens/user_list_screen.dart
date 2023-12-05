import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_bloc/core/app_style.dart';
import 'package:clean_architecture_bloc/core/app_extension.dart';
import 'package:clean_architecture_bloc/common/bloc/bloc_helper.dart';
import 'package:clean_architecture_bloc/common/widget/popup_menu.dart';
import 'package:clean_architecture_bloc/common/widget/empty_widget.dart';
import 'package:clean_architecture_bloc/common/dialog/delete_dialog.dart';
import 'package:clean_architecture_bloc/common/dialog/create_dialog.dart';
import 'package:clean_architecture_bloc/features/user/data/models/user.dart';
import 'package:clean_architecture_bloc/common/bloc/generic_bloc_builder.dart';
import 'package:clean_architecture_bloc/features/user/presentation/bloc/user_bloc.dart';
import 'package:clean_architecture_bloc/features/user/domain/entities/user_entity.dart';
import 'package:clean_architecture_bloc/features/user/presentation/bloc/user_event.dart';
import 'package:clean_architecture_bloc/features/post/presentation/screens/post_list_screen.dart';
import 'package:clean_architecture_bloc/features/todo/presentation/screens/todo_list_screen.dart';
import 'package:clean_architecture_bloc/features/user/presentation/widgets/status_container.dart';

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
        onPressed: () => context.read<UserBloc>().add(UsersFetched()),
        icon: const Icon(Icons.refresh),
      ),
      actions: [
        PopupMenu<UserStatus>(
          icon: Icons.filter_list_outlined,
          items: UserStatus.values,
          onChanged: (UserStatus value) {
            context.read<UserBloc>().add(UsersFetched(status: value));
          },
        ),
        PopupMenu<Gender>(
          icon: Icons.filter_alt_outlined,
          items: Gender.values,
          onChanged: (Gender value) {
            context.read<UserBloc>().add(UsersFetched(gender: value));
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
          context.read<UserBloc>().add(UserCreated(user));
          showDialog(
            context: context,
            builder: (_) {
              return GenericBlocBuilder<UserBloc, User>(
                successStatusTitle: 'Successfully created',
                progressStatusTitle: "Creating user...",
                onRetryPressed: () {
                  context.read<UserBloc>().add(UserCreated(user));
                },
                onSuccessPressed: () {
                  context.read<UserBloc>().add(UsersFetched());
                  Navigator.pop(context);
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
      context.read<UserBloc>().add(UserDeleted(user));
      showDialog(
        context: context,
        builder: (_) {
          return GenericBlocBuilder<UserBloc, User>(
            successStatusTitle: 'Successfully deleted',
            progressStatusTitle: "Deleting user...",
            onRetryPressed: () {
              context.read<UserBloc>().add(UserDeleted(user));
            },
            onSuccessPressed: () {
              context.read<UserBloc>().add(UsersFetched());
              Navigator.pop(context);
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
      context.read<UserBloc>().add(UserUpdated(userObj));
      showDialog(
        context: context,
        builder: (_) {
          return GenericBlocBuilder<UserBloc, User>(
            successStatusTitle: 'Successfully updated',
            progressStatusTitle: "Updating user...",
            onRetryPressed: () {
              context.read<UserBloc>().add(UserUpdated(userObj));
            },
            onSuccessPressed: () {
              context.read<UserBloc>().add(UsersFetched());
              Navigator.pop(context);
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
    BlocProvider.of<UserBloc>(context).add(UsersFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: _appBar,
      body: GenericBlocBuilder<UserBloc, User>(
        buildWhen: (_, __) {
          return context.read<UserBloc>().operation == ApiOperation.select ? true : false;
        },
        emptyWidget: const EmptyWidget(message: "No user!"),
        onRetryPressed: () {
          context.read<UserBloc>().add(UsersFetched());
        },
        successWidget: (state) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.data?.length ?? 0,
            itemBuilder: (_, index) {
              User user = state.data![index];
              return userListItem(user);
            },
          );
        },
      ),
    );
  }
}
