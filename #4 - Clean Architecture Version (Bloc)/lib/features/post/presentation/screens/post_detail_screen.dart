import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../common/bloc/generic_bloc_state.dart';
import '../../../../common/dialog/progress_dialog.dart';
import '../../../../common/dialog/retry_dialog.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/spinkit_indicator.dart';
import '../../../../common/widget/text_input.dart';
import '../../../../core/app/app_asset.dart';
import '../../../../core/app/app_extension.dart';
import '../../../../core/app/app_style.dart';
import '../../../comment/data/models/comment.dart';
import '../../../comment/presentation/bloc/comment_bloc.dart';
import '../../../comment/presentation/bloc/comment_event.dart';
import '../../../user/data/models/user.dart';
import '../../data/models/post.dart';
import '../bloc/post_bloc.dart';
import '../bloc/post_event.dart';
import 'create_post_screen.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key? key, required this.post, this.user})
      : super(key: key);

  final Post post;
  final User? user;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController commentBodyEditingController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode commentBodyFocusNode = FocusNode();

  @override
  void dispose() {
    nameEditingController.dispose();
    commentBodyEditingController.dispose();
    userNameFocusNode.dispose();
    commentBodyFocusNode.dispose();
    super.dispose();
  }

  getUserComments() async {
    context.read<CommentBloc>().add(CommentFetched(widget.post.id));
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_outlined),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          onPressed: () => deletePost(widget.post),
          icon: const Icon(Icons.delete),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return CreatePostScreen(
                    user: widget.user!,
                    post: widget.post,
                    mode: PostMode.update,
                  );
                },
              ),
            );
          },
          icon: const Icon(Icons.edit),
        )
      ],
    );
  }

  Widget get postItem {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.post.title,
            style: headLine1.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          Text(widget.post.body, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget get commentItem {
    getUserComments();
    return BlocBuilder<CommentBloc, GenericBlocState<Comment>>(
      builder: (BuildContext context, GenericBlocState<Comment> state) {
        switch (state.status) {
          case Status.empty:
            return const EmptyWidget(message: "No comment");
          case Status.loading:
            return const SpinKitIndicator();
          case Status.failure:
            return RetryDialog(
                title: state.error ?? "Error",
                onRetryPressed: () => getUserComments());
          case Status.success:
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.data?.length ?? 0,
              itemBuilder: (_, index) {
                Comment comment = state.data![index];
                return Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFFcad1e2),
                      backgroundImage: AssetImage(AppAsset.user),
                    ),
                    Expanded(
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(comment.name, style: headLine5),
                                  IconButton(
                                    splashRadius: 25,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () => deleteComment(comment),
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.redAccent,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(comment.body)
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
        }
      },
    );
  }

  void deletePost(Post post) {
    context.read<PostBloc>().add(PostDeleted(post));
    showDialog(
      context: context,
      builder: (_) {
        return BlocBuilder<PostBloc, GenericBlocState<Post>>(
          builder: (BuildContext context, GenericBlocState<Post> state) {
            switch (state.status) {
              case Status.empty:
                return const SizedBox();
              case Status.loading:
                return const ProgressDialog(
                  title: "Deleting post...",
                  isProgressed: true,
                );
              case Status.failure:
                return RetryDialog(
                  title: state.error ?? "Error",
                  onRetryPressed: () =>
                      context.read<PostBloc>().add(PostDeleted(post)),
                );
              case Status.success:
                return ProgressDialog(
                  title: "Successfully deleted",
                  onPressed: () => pop(context, 2),
                  isProgressed: false,
                );
            }
          },
        );
      },
    );
  }

  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF556080),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Row(
          children: [
            const Icon(Icons.info, color: Color(0xFF2f87e8)),
            const SizedBox(width: 10),
            Text(message, style: const TextStyle(color: Colors.white))
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void deleteComment(Comment comment) {
    context.read<CommentBloc>().add(CommentDeleted(comment));
    showDialog(
      context: context,
      builder: (_) {
        return BlocBuilder<CommentBloc, GenericBlocState<Comment>>(
          builder: (BuildContext context, GenericBlocState<Comment> state) {
            switch (state.status) {
              case Status.empty:
                return const SizedBox();
              case Status.loading:
                return const ProgressDialog(
                  title: "Deleting comment...",
                  isProgressed: true,
                );
              case Status.failure:
                return RetryDialog(
                  title: state.error ?? "Error",
                  onRetryPressed: () =>
                      context.read<CommentBloc>().add(CommentDeleted(comment)),
                );
              case Status.success:
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    getUserComments();
                    Navigator.pop(context);
                    snackBar("Successfully deleted");
                  },
                );
                return const SizedBox();
            }
          },
        );
      },
    );
  }

  Widget get createComment {
    String name = "";
    String commentBody = "";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 25,
          backgroundColor: Color(0xFFcad1e2),
          backgroundImage: AssetImage(AppAsset.user),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextInput(
                  focusNode: userNameFocusNode,
                  hint: "Write a comment",
                  maxLine: 3,
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: commentBodyEditingController,
                  validator: (String? value) {
                    if (value!.isNotEmpty) return null;
                    return "Cannot be empty";
                  },
                  onChanged: (String value) {
                    commentBody = value;
                  },
                ),
                const SizedBox(height: 10),
                TextInput(
                  focusNode: commentBodyFocusNode,
                  icon: const Icon(Icons.person, color: Color(0xFF556080)),
                  hint: "Name",
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: nameEditingController,
                  validator: (String? value) {
                    if (value!.isNotEmpty) return null;
                    return "Cannot be empty";
                  },
                  onChanged: (String value) {
                    name = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    bool isValid = formKey.currentState?.validate() ?? false;
                    userNameFocusNode.unfocus();
                    commentBodyFocusNode.unfocus();
                    if (isValid) {
                      Comment comment = Comment(
                        id: 0,
                        postId: widget.post.id,
                        name: name,
                        email: "user@testUser",
                        body: commentBody,
                      );

                      context.read<CommentBloc>().add(CommentCreated(comment));
                      showDialog(
                        context: context,
                        builder: (_) {
                          return BlocBuilder<CommentBloc,
                              GenericBlocState<Comment>>(
                            builder: (BuildContext context,
                                GenericBlocState<Comment> state) {
                              switch (state.status) {
                                case Status.empty:
                                  return const EmptyWidget(
                                      message: "No comment");
                                case Status.loading:
                                  return const ProgressDialog(
                                    title: "",
                                    isProgressed: true,
                                  );
                                case Status.failure:
                                  return RetryDialog(
                                    title: state.error ?? "Error",
                                    onRetryPressed: () {
                                      context
                                          .read<CommentBloc>()
                                          .add(CommentCreated(comment));
                                    },
                                  );
                                case Status.success:
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) {
                                      nameEditingController.clear();
                                      commentBodyEditingController.clear();
                                      snackBar("Successfully created");
                                      Navigator.pop(context);
                                      getUserComments();
                                    },
                                  );
                              }
                              return const SizedBox();
                            },
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF556080),
                  ),
                  child: const Text("Post comment"),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            postItem,
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text("Comments", style: headLine2),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 2),
            ),
            createComment,
            commentItem,
          ],
        ),
      ),
    );
  }
}
