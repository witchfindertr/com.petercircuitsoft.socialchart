import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard_controller.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/custom_widgets/user_avata.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_controller.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/comment.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/comment_controller.dart';

class ScreenInsightCard extends GetView<ScreenInsightCardController> {
  const ScreenInsightCard({super.key, required this.navKey});

  final NavKeys navKey;

  @override
  String? get tag => navKey.name;

  static const routeName = "/ScreenInsightCard";

  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => RefreshIndicator(
            onRefresh: () => Future.sync(
              () => controller.pagingController.refresh(),
            ),
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                MainSliverAppbar(
                  titleText: controller.isCurrentUser
                      ? '내가 작성한 카드'
                      : '${controller.authorData?.displayName ?? ""}님의 카드',
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                SliverToBoxAdapter(
                  child: controller.cardInfo != null
                      ? GetBuilder<InsightCardController>(
                          init: InsightCardController(
                            userId: controller.cardInfo!.author.id,
                            cardId: controller.cardId,
                            cardInfo: controller.cardInfo!,
                            refreshFunction: () =>
                                controller.pagingController.refresh(),
                          ),
                          tag: controller.cardId + routeName,
                          builder: (insigtCardController) {
                            return InsightCard(
                              routeName: routeName,
                              navKey: navKey,
                              showHeader: true,
                              cardId: controller.cardId,
                              cardInfo: controller.cardInfo!,
                            );
                          },
                        )
                      : const SizedBox(),
                ),
                PagedSliverList(
                  pagingController: controller.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<
                      QueryDocumentSnapshot<ModelUserComment>>(
                    itemBuilder: ((context, item, index) {
                      return GetBuilder(
                        init: CommentController(
                            commentId: item.id, commentData: item.data()),
                        tag: item.id,
                        builder: (commentController) {
                          return Comment(
                            commentId: item.id,
                            commentPresseCallback: controller.setTargetComment,
                          );
                        },
                      );
                    }),
                    noItemsFoundIndicatorBuilder: (context) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "등록된 댓글이 없습니다.",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    noMoreItemsIndicatorBuilder: (context) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "👆👆마지막 댓글입니다.👆👆",
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(
                      bottom: kMinInteractiveDimensionCupertino + 10),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.black26))),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => Container(
                  child: controller.targetComment != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${controller.targetCommentAuthor} 님의 글뭉치에 댓글다는 중...",
                              style: Theme.of(context).textTheme.caption,
                            ),
                            InkWell(
                              onTap: () => controller.clearTarget(),
                              child: Text(
                                "취소",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .merge(
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  userAvatar(
                    padding: 0,
                    url: AuthController.to.currentUser?.profileImageUrl,
                    radius: 21,
                    unique: AuthController.to.firebaseUser.value!.uid,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      focusNode: controller.focusNode,
                      controller: controller.textController,
                      enabled: controller.textFieldEnabled,
                      // onTap: controller.scrollToEnd,
                      decoration: const InputDecoration(
                        hintText: "댓글을 입력하세요.",
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  CupertinoButton(
                      padding: const EdgeInsets.all(0),
                      child: const Icon(CupertinoIcons.paperplane),
                      onPressed: () {
                        controller.addComment();
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
