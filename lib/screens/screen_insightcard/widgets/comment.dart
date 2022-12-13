import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/comment_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comment extends GetView<CommentController> {
  const Comment({
    super.key,
    required this.commentId,
    required this.selected,
    this.commentPresseCallback,
  });
  final String commentId;
  final bool selected;
  final void Function(
      {String? commentId,
      ModelUserComment? userComment,
      String? author})? commentPresseCallback;
  @override
  // TODO: implement tag
  String? get tag => commentId;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: controller.isComment ? 0 : 30,
              ),
              child: userAvatar(
                padding: 0,
                radius: 25,
                unique: controller.commentData.author,
                url: controller.userData?.profileImageUrl,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  if (commentPresseCallback != null) {
                    commentPresseCallback!(
                      commentId: commentId,
                      userComment: controller.commentData,
                      author: controller.userData?.displayName,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                      color: selected
                          ? Colors.transparent.withOpacity(0.1)
                          : Colors.transparent.withOpacity(0.04),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userData?.displayName ?? "로딩중..",
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        timeago.format(
                            controller.commentData.createdAt.toDate(),
                            locale: 'kr',
                            allowFromNow: true),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.commentData.comment,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
