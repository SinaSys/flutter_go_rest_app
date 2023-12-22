import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture_getx/di.dart';
import 'package:clean_architecture_getx/core/app_extension.dart';
import 'package:clean_architecture_getx/common/widget/text_input.dart';
import 'package:clean_architecture_getx/common/widget/async_widget.dart';
import 'package:clean_architecture_getx/features/user/data/models/user.dart';
import 'package:clean_architecture_getx/features/post/data/models/post.dart';
import 'package:clean_architecture_getx/features/post/presentation/controller/post_controller.dart';

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
                      Post post = Post(id: postId, body: postBody, title: postTitle, userId: widget.user.id!);

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
                              return AsyncWidget(
                                apiState: postController.apiStatus.value,
                                progressStatusTitle: "${widget.mode.name}ing post...",
                                failureStatusTitle: postController.errorMessage.value,
                                successStatusTitle: "Successfully ${widget.mode.name}d",
                                onSuccessPressed: () {
                                  if (widget.mode == PostMode.update) {
                                    pop(context, 3);
                                  } else {
                                    pop(context, 2);
                                  }
                                },
                                onRetryPressed: () {
                                  if (widget.mode == PostMode.create) {
                                    postController.createPost(post);
                                  } else {
                                    postController.updatePost(post);
                                  }
                                },
                              );
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
