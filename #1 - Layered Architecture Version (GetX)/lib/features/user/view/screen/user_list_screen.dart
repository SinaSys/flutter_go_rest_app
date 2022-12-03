import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/controller/api_operation.dart';
import '../../../../common/dialog/create_dialog.dart';
import '../../../../common/dialog/delete_dialog.dart';
import '../../../../common/dialog/progress_dialog.dart';
import '../../../../common/dialog/retry_dialog.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/popup_menu.dart';
import '../../../../common/widget/spinkit_indicator.dart';
import '../../../../core/app_extension.dart';
import '../../../../core/app_style.dart';
import '../../../post/view/screen/post_list_screen.dart';
import '../../../todo/view/screen/todo_list_screen.dart';
import '../../controller/user_controller.dart';
import '../../data/model/user.dart';
import '../widget/status_container.dart';

enum UserOperation { edit, delete, post, todo }

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserController _controller = Get.put(UserController());

  PreferredSizeWidget get _appBar {
    return AppBar(
      leading: IconButton(
        onPressed: _controller.getUserList,
        icon: const Icon(Icons.refresh),
      ),
      actions: [
        PopupMenu<UserStatus>(
          icon: Icons.filter_list_outlined,
          items: UserStatus.values,
          onChanged: (UserStatus value) {
            _controller.getUserList(status: value);
          },
        ),
        PopupMenu<Gender>(
          icon: Icons.filter_alt_outlined,
          items: Gender.values,
          onChanged: (Gender value) => _controller.getUserList(gender: value),
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
          _controller.createUser(user);
          showDialog(
            context: context,
            builder: (_) {
              return Obx(
                () {
                  switch (_controller.apiStatus.value) {
                    case ApiState.loading:
                      return const ProgressDialog(
                        title: "Creating user...",
                        isProgressed: true,
                      );
                    case ApiState.success:
                      return ProgressDialog(
                        title: "Successfully created",
                        onPressed: () {
                          _controller.getUserList();
                          Navigator.pop(context);
                        },
                        isProgressed: false,
                      );
                    case ApiState.failure:
                      return RetryDialog(
                        title: _controller.errorMessage.value,
                        onRetryPressed: () => _controller.createUser(user),
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
    return Card(
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
          PopupMenu<UserOperation>(
            items: UserOperation.values,
            onChanged: (UserOperation value) async {
              switch (value) {
                case UserOperation.post:
                  navigateTo(PostListScreen(user: user));
                  break;
                case UserOperation.todo:
                  navigateTo(ToDoListScreen(user: user));
                  break;
                case UserOperation.delete:
                  deleteUser(user);
                  break;
                case UserOperation.edit:
                  editUser(user);
              }
            },
          ),
        ],
      ),
    );
  }

  void deleteUser(User user) async {
    bool isAccepted = await deleteDialog(context);
    if (isAccepted) {
      _controller.deleteUser(user);
      showDialog(
        context: context,
        builder: (_) {
          return Obx(
            () {
              switch (_controller.apiStatus.value) {
                case ApiState.loading:
                  return const ProgressDialog(
                    title: "Deleting user...",
                    isProgressed: true,
                  );
                case ApiState.success:
                  return ProgressDialog(
                    title: "Successfully deleted",
                    onPressed: () {
                      _controller.getUserList();
                      Navigator.pop(context);
                    },
                    isProgressed: false,
                  );
                case ApiState.failure:
                  return RetryDialog(
                    title: _controller.errorMessage.value,
                    onRetryPressed: () => _controller.deleteUser(user),
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
      _controller.updateUser(userObj);
      showDialog(
        context: context,
        builder: (_) {
          return Obx(
            () {
              switch (_controller.apiStatus.value) {
                case ApiState.loading:
                  return const ProgressDialog(
                    title: "Updating user...",
                    isProgressed: true,
                  );
                case ApiState.success:
                  return ProgressDialog(
                    title: "Successfully updated",
                    onPressed: () {
                      _controller.getUserList();
                      Navigator.pop(context);
                    },
                    isProgressed: false,
                  );
                case ApiState.failure:
                  return RetryDialog(
                    title: _controller.errorMessage.value,
                    onRetryPressed: () => _controller.updateUser(userObj),
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: _appBar,
      body: _controller.obx(
        (state) => ListView.builder(
          shrinkWrap: true,
          itemCount: state?.length,
          itemBuilder: (_, index) {
            User user = state![index];
            return userListItem(user).marginSymmetric(horizontal: 10);
          },
        ),
        onLoading: const SpinKitIndicator(type: SpinKitType.circle),
        onError: (error) => RetryDialog(
          title: "$error",
          onRetryPressed: () => _controller.getUserList(),
        ),
        onEmpty: const EmptyWidget(message: "No user!"),
      ),
    );
  }
}
