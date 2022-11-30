import 'package:layered_architecture/common/widget/text_input.dart';
import 'package:layered_architecture/features/comment/data/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/controller/api_operation.dart';
import '../../../../common/dialog/progress_dialog.dart';
import '../../../../common/dialog/retry_dialog.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/spinkit_indicator.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_extension.dart';
import '../../../../core/app_style.dart';
import '../../../comment/controller/comment_controller.dart';
import '../../../user/data/model/user.dart';
import '../../controller/post_controller.dart';
import '../../data/model/post.dart';
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
  final CommentController commentController = Get.put(CommentController());
  final PostController postController = Get.put(PostController());
  final formKey = GlobalKey<FormState>();
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController commentBodyEditingController = TextEditingController();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await commentController.getUserComments(widget.post.id);
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
    return commentController.obx(
      (state) => ListView.builder(
        shrinkWrap: true,
        itemCount: state?.length,
        itemBuilder: (_, index) {
          Comment comment = state![index];
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
      ),
      onLoading: const SpinKitIndicator(),
      onEmpty: const EmptyWidget(message: "No comment"),
      onError: (error) => RetryDialog(
        title: "$error",
        onRetryPressed: () => commentController.getUserComments(widget.post.id),
      ),
    );
  }

  void deletePost(Post post) {
    postController.deletePost(post);
    showDialog(
      context: context,
      builder: (_) {
        return Obx(
          () {
            switch (postController.apiStatus.value) {
              case ApiState.loading:
                return const ProgressDialog(
                  title: "Deleting post...",
                  isProgressed: true,
                );
              case ApiState.success:
                return ProgressDialog(
                  title: "Successfully deleted",
                  onPressed: () => pop(context, 2),
                  isProgressed: false,
                );
              case ApiState.failure:
                return RetryDialog(
                  title: postController.errorMessage.value,
                  onRetryPressed: () => postController.deletePost(post),
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
    commentController.deleteComment(comment);
    showDialog(
      context: context,
      builder: (_) {
        return Obx(
          () {
            switch (commentController.apiStatus.value) {
              case ApiState.loading:
                return const ProgressDialog(
                  title: "Deleting comment...",
                  isProgressed: true,
                );
              case ApiState.success:
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    commentController.getUserComments(widget.post.id);
                    Navigator.pop(context);
                    snackBar("Successfully deleted");
                  },
                );
                break;
              case ApiState.failure:
                return RetryDialog(
                  title: commentController.errorMessage.value,
                  onRetryPressed: () =>
                      commentController.deleteComment(comment),
                );
            }
            return const SizedBox();
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
                    if (isValid) {
                      Comment comment = Comment(
                        id: 0,
                        postId: widget.post.id,
                        name: name,
                        email: "user@testUser",
                        body: commentBody,
                      );

                      commentController.createComment(comment);

                      showDialog(
                        context: context,
                        builder: (_) {
                          return Obx(
                            () {
                              switch (commentController.apiStatus.value) {
                                case ApiState.loading:
                                  return const ProgressDialog(
                                    title: "",
                                    isProgressed: true,
                                  );
                                case ApiState.success:
                                  WidgetsBinding.instance.addPostFrameCallback(
                                    (_) {
                                      nameEditingController.clear();
                                      commentBodyEditingController.clear();
                                      snackBar("Successfully created");
                                      Navigator.pop(context);
                                      commentController
                                          .getUserComments(widget.post.id);
                                    },
                                  );
                                  break;
                                case ApiState.failure:
                                  return RetryDialog(
                                    title: commentController.errorMessage.value,
                                    onRetryPressed: () {
                                      commentController.createComment(comment);
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
  void dispose() {
    nameEditingController.dispose();
    commentBodyEditingController.dispose();
    super.dispose();
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
