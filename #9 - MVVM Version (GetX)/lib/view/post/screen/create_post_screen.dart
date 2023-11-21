import 'package:mvvm_getx/viewmodel/post/controller/post_controller.dart';
import 'package:mvvm_getx/common/controller/base_controller.dart';
import 'package:mvvm_getx/common/dialog/progress_dialog.dart';
import 'package:mvvm_getx/common/dialog/retry_dialog.dart';
import 'package:mvvm_getx/common/widget/text_input.dart';
import 'package:mvvm_getx/core/app_extension.dart';
import 'package:mvvm_getx/data/model/post/post.dart';
import 'package:mvvm_getx/data/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_getx/di.dart';
import 'package:get/get.dart';

enum PostMode { create, update }

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({
    super.key,
    required this.user,
    this.mode = PostMode.create,
    this.post,
  });

  final User user;
  final Post? post;
  final PostMode mode;

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final PostController postController = getIt<PostController>();

  String postTitle = "";
  String postBody = "";
  int postId = 0;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    //  postController = Get.put(PostController());
    initializeValues();
    super.initState();
  }

  initializeValues() {
    //Update
    if (widget.post != null && widget.mode == PostMode.update) {
      postTitle = widget.post?.title ?? "";
      postBody = widget.post?.body ?? "";
      postId = widget.post?.id ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("${widget.mode.name.toCapital} post")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextInput(
                initialValue: postTitle,
                hint: "Title",
                validator: (String? value) {
                  if (value!.isNotEmpty) return null;
                  return "Title cannot be empty";
                },
                onChanged: (String input) {
                  postTitle = input;
                },
              ),
              const SizedBox(height: 15),
              TextInput(
                initialValue: postBody,
                hint: "body",
                maxLine: 6,
                validator: (String? value) {
                  if (value!.isNotEmpty) return null;
                  return "Body cannot be empty";
                },
                onChanged: (String input) {
                  postBody = input;
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    bool isValid = formKey.currentState?.validate() ?? false;
                    if (isValid) {
                      Post post = Post(
                          id: postId,
                          body: postBody,
                          title: postTitle,
                          userId: widget.user.id!);

                      if (widget.mode == PostMode.create) {
                        postController.createPost(post);
                      } else {
                        postController.updatePost(post);
                      }

                      showDialog(
                        context: context,
                        builder: (_) {
                          return Obx(
                            () {
                              switch (postController.apiStatus.value) {
                                case ApiState.loading:
                                  return ProgressDialog(
                                    title: "${widget.mode.name}ing post...",
                                    isProgressed: true,
                                  );
                                case ApiState.success:
                                  return ProgressDialog(
                                    title: "Successfully ${widget.mode.name}ed",
                                    onPressed: () {
                                      if (widget.mode == PostMode.update) {
                                        pop(context, 3);
                                      } else {
                                        pop(context, 2);
                                      }
                                    },
                                    isProgressed: false,
                                  );
                                case ApiState.failure:
                                  return RetryDialog(
                                    title: postController.errorMessage.value,
                                    onRetryPressed: () {
                                      if (widget.mode == PostMode.create) {
                                        postController.createPost(post);
                                      } else {
                                        postController.updatePost(post);
                                      }
                                    },
                                  );
                              }
                            },
                          );
                        },
                      );
                    }
                  },
                  child: Text(widget.mode.name.toCapital),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
