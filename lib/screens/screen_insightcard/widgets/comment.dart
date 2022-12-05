import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/models/firebase_collection_ref.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/models/model_user_data.dart';
import 'package:socialchart/utils/timeago_custom_messages.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentController extends GetxController {
  CommentController({required this.userId});
  final String userId;
  final _userData = Rxn<UserDataModel>();
  UserDataModel? get userData => _userData.value;
  @override
  void onInit() {
    // TODO: implement onInit
    userDataColRef().doc(userId).get().then(
          (value) => _userData.value = value.data(),
        );

    super.onInit();
  }
}

class Comment extends StatelessWidget {
  const Comment({super.key, required this.userComment});
  final ModelUserComment userComment;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CommentController(userId: userComment.author),
        tag: userComment.author);
    return Obx(
      () => Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: userAvatar(
                padding: 0,
                radius: 25,
                unique: controller.userId,
                url: controller.userData?.profileImageUrl,
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
                child: Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.04),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
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
            ))
          ],
        ),
      ),
    );
  }
}
