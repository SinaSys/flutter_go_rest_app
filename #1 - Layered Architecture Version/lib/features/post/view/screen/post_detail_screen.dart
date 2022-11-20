import 'package:layered_architecture/features/comment/data/model/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/dialog/retry_dialog.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/spinkit_indicator.dart';
import '../../../../core/app_asset.dart';
import '../../../comment/controller/comment_controller.dart';
import '../../data/model/post.dart';

class PostDetailScreen extends StatefulWidget {
  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  final Post post;

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final CommentController commentController = Get.put(CommentController());

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
    );
  }

  Widget postItem() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 15),
          Text(widget.post.body, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget guestComments() {
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
                        Text(
                          comment.name,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
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
        onRetryPressed: () {
          commentController.getUserComments(widget.post.id);
        },
      ),
    );
    // return Row(
    //   children: [
    //     const CircleAvatar(
    //       radius: 25,
    //       backgroundColor: Color(0xFFcad1e2),
    //       backgroundImage: AssetImage(AppAsset.avatar),
    //     ),
    //     Expanded(
    //       child: Card(
    //         child: Padding(
    //           padding: const EdgeInsets.all(15.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: const [
    //               Text(
    //                 "comments[index].name",
    //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    //               ),
    //               SizedBox(height: 8),
    //               Text("comments[index].body")
    //             ],
    //           ),
    //         ),
    //       ),
    //     )
    //   ],
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            postItem(),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Comments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(thickness: 2),
            ),
            guestComments(),
            // const SizedBox(height: 10),
            // newComment()
          ],
        ),
      ),
    );
  }
}
