import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialchart/controllers/user_data_fetcher.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comment extends StatelessWidget {
  const Comment({
    super.key,
    required this.index,
    required this.userComment,
    required this.selected,
    this.commentPresseCallback,
  });
  final int index;
  final ModelUserComment userComment;
  final bool selected;
  final void Function({required int index, String? author})?
      commentPresseCallback;

  @override
  Widget build(BuildContext context) {
    var user = Get.put(UserDataFetcher(userId: userComment.author),
        tag: userComment.author);
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 10,
                left: userComment.createdAt == userComment.commentCreatedAt
                    ? 0
                    : 30,
              ),
              child: userAvatar(
                padding: 0,
                radius: 25,
                unique: userComment.author,
                url: user.userData?.profileImageUrl,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  if (commentPresseCallback != null) {
                    commentPresseCallback!(
                      index: index,
                      author: user.userData?.displayName,
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .primaryColor
                          .withOpacity(selected ? 0.4 : 0.1),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.userData?.displayName ?? "로딩중..",
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        timeago.format(userComment.createdAt.toDate(),
                            locale: 'kr', allowFromNow: true),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        userComment.comment,
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
