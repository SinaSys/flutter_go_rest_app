import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:clean_architecture_rxdart/core/app_extension.dart';
import 'package:clean_architecture_rxdart/common/widget/text_input.dart';
import 'package:clean_architecture_rxdart/common/dialog/retry_dialog.dart';
import 'package:clean_architecture_rxdart/common/dialog/progress_dialog.dart';
import 'package:clean_architecture_rxdart/features/user/data/models/user.dart';
import 'package:clean_architecture_rxdart/features/post/data/models/post.dart';
import 'package:clean_architecture_rxdart/common/bloc/generic_bloc_state.dart';
import 'package:clean_architecture_rxdart/features/post/presentation/bloc/post_bloc.dart';

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
                      Post post = Post(
                        id: postId,
                        body: postBody,
                        title: postTitle,
                        userId: widget.user.id!,
                      );

                      if (widget.mode == PostMode.create) {
                        context.read<PostBloc>().createPost.add(post);
                      } else {
                        context.read<PostBloc>().updatePost.add(post);
                      }

                      showDialog(
                        context: context,
                        builder: (_) {
                          return StreamBuilder<GenericBlocState<bool>>(
                            stream: widget.mode == PostMode.create
                                ? context.read<PostBloc>().isPostCreated
                                : context.read<PostBloc>().isPostUpdated,
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                final state = snapshot.requireData;
                                switch (state.status) {
                                  case Status.empty:
                                    return const SizedBox();
                                  case Status.loading:
                                    return ProgressDialog(
                                      title: "${widget.mode.name}ing post...",
                                      isProgressed: true,
                                    );
                                  case Status.failure:
                                    return RetryDialog(
                                      title: state.error ?? "Error",
                                      onRetryPressed: () {
                                        if (widget.mode == PostMode.create) {
                                          context
                                              .read<PostBloc>()
                                              .createPost
                                              .add(post);
                                        } else {
                                          context
                                              .read<PostBloc>()
                                              .updatePost
                                              .add(post);
                                        }
                                      },
                                    );
                                  case Status.success:
                                    return ProgressDialog(
                                      title:
                                          "Successfully ${widget.mode.name}ed",
                                      onPressed: () {
                                        if (widget.mode == PostMode.update) {
                                          pop(context, 3);
                                        } else {
                                          pop(context, 2);
                                        }
                                      },
                                      isProgressed: false,
                                    );
                                }
                              } else if (snapshot.hasError) {
                                return RetryDialog(
                                  title: snapshot.error.toString(),
                                  onRetryPressed: () {
                                    if (widget.mode == PostMode.create) {
                                      context
                                          .read<PostBloc>()
                                          .createPost
                                          .add(post);
                                    } else {
                                      context
                                          .read<PostBloc>()
                                          .updatePost
                                          .add(post);
                                    }
                                  },
                                );
                              } else {
                                return ProgressDialog(
                                  title: "${widget.mode.name}ing post...",
                                  isProgressed: true,
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
