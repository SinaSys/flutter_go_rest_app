import 'package:clean_architecture_riverpod/core/app/app_extension.dart';
import 'package:clean_architecture_riverpod/features/user/presentation/provider/user_provider.dart';
import 'package:flutter/material.dart';

//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_riverpod/common/cubit/generic_cubit_state.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/dialog/create_dialog.dart';
import '../../../../common/dialog/delete_dialog.dart';
import '../../../../common/dialog/progress_dialog.dart';
import '../../../../common/dialog/retry_dialog.dart';
import '../../../../common/riverpod/generic_provider.dart';
import '../../../../common/riverpod/generic_state.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/popup_menu.dart';
import '../../../../common/widget/spinkit_indicator.dart';
import '../../../../core/app/app_style.dart';
import '../../../post/presentation/screens/post_list_screen.dart';
import '../../../todo/presentation/screens/todo_list_screen.dart';
import '../../data/models/user.dart';
import '../../domain/entities/user_entity.dart';

//import '../cubit/user_cubit.dart';
import '../widgets/status_container.dart';

enum Operation { edit, delete, post, todo }

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  PreferredSizeWidget get _appBar {
    return AppBar(
      leading: IconButton(
        //  onPressed: () => context.read<UserCubit>().getUserList(),
        onPressed: () => ref.read(userProvider.notifier).getUserList(),
        icon: const Icon(Icons.refresh),
      ),
      actions: [
        PopupMenu<UserStatus>(
          icon: Icons.filter_list_outlined,
          items: UserStatus.values,
          onChanged: (UserStatus value) {
            // context.read<UserCubit>().getUserList(status: value);
            ref.read(userProvider.notifier).getUserList(status: value);
          },
        ),
        PopupMenu<Gender>(
          icon: Icons.filter_alt_outlined,
          items: Gender.values,
          onChanged: (Gender value) {
            //context.read<UserCubit>().getUserList(gender: value);
            ref.read(userProvider.notifier).getUserList(gender: value);
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
          //  context.read<UserCubit>().createUser(user);
          ref.read(userProvider.notifier).createUser(user);

          showDialog(
            context: context,
            builder: (_) {
              return SizedBox();
              // return Consumer(
              //   builder: (_, __, ___) {
              //     final state = ref.watch(userProvider);
              //     switch (state.status) {
              //       case Status.empty:
              //         return const SizedBox();
              //       case Status.loading:
              //         return const ProgressDialog(
              //           title: "Creating user...",
              //           isProgressed: true,
              //         );
              //       case Status.failure:
              //         return RetryDialog(
              //             title: state.error ?? "Error",
              //             onRetryPressed: () =>
              //                 // context.read<UserCubit>().createUser(user),
              //                 ref.read(userProvider.notifier).createUser(user));
              //       case Status.success:
              //         return ProgressDialog(
              //           title: "Successfully created",
              //           onPressed: () {
              //             ref.read(userProvider.notifier).getUserList();
              //             // context.read<UserCubit>().getUserList();
              //             Navigator.pop(context);
              //           },
              //           isProgressed: false,
              //         );
              //     }
              //   },
              // );
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
                    navigateTo(TodoListScreen(user: user));
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
      // context.read<UserCubit>().deleteUser(user);
      ref.read(userProvider.notifier).deleteUser(user);

      showDialog(
        context: context,
        builder: (_) {
          return Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final state = ref.watch(userProvider);
            //  if(ref.read(userProvider.notifier).apiOperation==ApiOperation.delete){
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
                        //  context.read<UserCubit>().deleteUser(user),
                        ref.read(userProvider.notifier).deleteUser(user));
                  case Status.success:
                    return ProgressDialog(
                      title: "Successfully deleted",
                      onPressed: () {
                        //  context.read<UserCubit>().getUserList();
                        ref.read(userProvider.notifier).getUserList();

                        Navigator.pop(context);
                      },
                      isProgressed: false,
                    );
                }
            //  }
              return const SizedBox();
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
      // context.read<UserCubit>().updateUser(userObj);
      ref.read(userProvider.notifier).updateUser(userObj);

      showDialog(
        context: context,
        builder: (_) {
          return SizedBox();
          // return Consumer(
          //     builder: (BuildContext context, WidgetRef ref, Widget? child) {
          //   final state = ref.watch(userProvider);
          //   switch (state.status) {
          //     case Status.empty:
          //       return const SizedBox();
          //     case Status.loading:
          //       return const ProgressDialog(
          //         title: "Updating user...",
          //         isProgressed: true,
          //       );
          //     case Status.failure:
          //       return RetryDialog(
          //           title: state.error ?? "Error",
          //           onRetryPressed: () =>
          //               //  context.read<UserCubit>().updateUser(userObj),
          //               ref.read(userProvider.notifier).updateUser(userObj));
          //     case Status.success:
          //       return ProgressDialog(
          //         title: "Successfully updated",
          //         onPressed: () {
          //           //  context.read<UserCubit>().getUserList();
          //           ref.read(userProvider.notifier).getUserList();
          //
          //           Navigator.pop(context);
          //         },
          //         isProgressed: false,
          //       );
          //   }
          // });
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
    super.initState();
    // BlocProvider.of<UserCubit>(context).getUserList();
     ref.read(userProvider.notifier).getUserList();
    // context.read<UserNotifier>().getUserList();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userProvider);
    // bool name = ref.watch(userProvider.select((user) => user.httpMethod==HttpMethod.get));

   // final state = ref.watch(stateProvider);
    final bool test = ref.watch(stateProvider);

    //   print("state sssssssss is ${state.data}");



    return Scaffold(
      floatingActionButton: floatingActionButton,
      appBar: _appBar,
      body: Consumer(
        builder: (_,  __,___) {
          final bool test = ref.watch(stateProvider);

          //    final state = ref.watch(userProvider);
       //   if(ref.read(userProvider.notifier).apiOperation==ApiOperation.select) {
          final state = ref.watch(userProvider);
         // Status state = ref.watch(userProvider.select((user) => user.status));

          ref.read(userProvider.notifier.select((value) => value.apiOperation));


       //  if(ref.read(userProvider.notifier).apiOperation==ApiOperation.select) {
            switch (state.status) {
            case Status.empty:
              return const EmptyWidget(message: "No user!");
            case Status.loading:
              return const SpinKitIndicator(type: SpinKitType.circle);
            case Status.failure:
              return RetryDialog(
                title: state.error ?? "Error",
                // onRetryPressed: () => context.read<UserCubit>().getUserList(),
                onRetryPressed: () =>
                    ref.read(userProvider.notifier).getUserList(),
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
       // }
       //   }
     //  return Text("da00000000000ta");
        },
      ),
    );
  }
}
