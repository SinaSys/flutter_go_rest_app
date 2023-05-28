import 'package:flutter/material.dart';
import 'package:layered_architecture_bloc/common/widget/drop_down.dart';
import 'package:layered_architecture_bloc/common/widget/text_input.dart';
import 'package:layered_architecture_bloc/features/user/data/model/user.dart';

enum Type { create, update }

Future<dynamic> createDialog({
  User? user,
  required BuildContext context,
  required void Function(User) userData,
  Type type = Type.create,
}) {
  //if user is not null we have update operation, otherwise we have Create
  // operation. For create operation we don't need to initialize values for our
  // fields, but for Update we should fill our fields with previous values.
  // For create operation we don't need id, and server generate id
  // automatically, But for update we have to pass user id.

  String userName = user?.name ?? "";
  String email = user?.email ?? "";
  Gender gender = user?.gender ?? Gender.male;
  UserStatus userStatus = user?.status ?? UserStatus.inactive;
  int? id = user?.id;
  final formKey = GlobalKey<FormState>();

  var dialog = showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: Text(
          type == Type.create ? "Create new user" : "Update user",
          textAlign: TextAlign.center,
        ),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextInput(
                  initialValue: userName,
                  hint: "Enter Username",
                  onChanged: (String value) {
                    userName = value;
                  },
                  validator: (String? value) {
                    if (value!.isNotEmpty) return null;
                    return "Username cannot be empty";
                  },
                ),
                const SizedBox(height: 15),
                TextInput(
                  hint: "Enter email",
                  initialValue: email,
                  onChanged: (String value) {
                    email = value;
                  },
                  validator: (String? value) {
                    if (value!.contains(RegExp(r'@[a-zA-Z_]'))) return null;
                    return "Email is invalid";
                  },
                ),
                const SizedBox(height: 15),
                DropDown<Gender>(
                  initialItem: gender,
                  items: Gender.values.sublist(0, 2),
                  onChanged: (Gender value) {
                    gender = value;
                  },
                ),
                const SizedBox(height: 15),
                DropDown<UserStatus>(
                  initialItem: userStatus,
                  items: UserStatus.values.sublist(0, 2),
                  onChanged: (UserStatus value) {
                    userStatus = value;
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      bool isValid = formKey.currentState?.validate() ?? false;
                      if (isValid) {
                        userData(
                          User(
                            id: id,
                            email: email,
                            status: userStatus,
                            name: userName,
                            gender: gender,
                          ),
                        );
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text(type == Type.create ? "Create" : "Update"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text("Cancel"),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );

  return dialog.then((res) => res ?? false);
}
