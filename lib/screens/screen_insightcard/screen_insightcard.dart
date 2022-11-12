import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/controllers/auth_controller.dart';
import 'package:socialchart/custom_widgets/insightcard/insightcard.dart';
import 'package:socialchart/models/model_user_comment.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_insightcard/screen_insightcard_controller.dart';
import 'package:socialchart/screens/screen_insightcard/widgets/comment.dart';
import 'package:socialchart/socialchart/socialchart_controller.dart';

class ScreenInsightCard extends GetView<ScreenInsightCardController> {
  const ScreenInsightCard({super.key, required this.navKey});

  final NavKeys navKey;

  @override
  // TODO: implement tag
  String? get tag => navKey.name;

  static const routeName = "/ScreenInsightCard";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("InsightCard Screen")),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => Future.sync(
            () => controller.pagingController.refresh(),
          ),
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: controller.cardInfo != null
                    ? InsightCard(
                        cardId: controller.cardId,
                        cardInfo: controller.cardInfo!,
                        navKey: navKey,
                        trimLine: 100)
                    : SizedBox(),
              ),
              PagedSliverList(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<
                    QueryDocumentSnapshot<ModelUserComment>>(
                  itemBuilder: ((context, item, index) {
                    return Comment(
                      userComment: item.data(),
                    );
                  }),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                    bottom: kMinInteractiveDimensionCupertino + 10),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(
        () => controller.scrollOffset > 0
            ? TextButton(
                onPressed: () {
                  controller.scrollController.animateTo(
                    0.0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  );
                },
                child: Icon(Icons.arrow_upward),
              )
            : SizedBox(),
      ),
      // body: SingleChildScrollView(
      //   padding: const EdgeInsets.only(
      //       bottom: kMinInteractiveDimensionCupertino + 10),
      //   controller: controller.scrollController,
      //   child: Obx(
      //     () => !controller.isLoading && controller.cardInfo != null
      //         ? InsightCard(
      //             cardId: controller.cardId,
      //             cardInfo: controller.cardInfo!,
      //             navKey: navKey,
      //             trimLine: 100)
      //         : Text("로딩 중이에요"),
      //   ),
      // ),
      bottomSheet: Container(
        width: double.infinity,
        height: kMinInteractiveDimensionCupertino + 10,
        decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black26))),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: CachedNetworkImageProvider(
                  AuthController.to.currentUser?.imageUrl ?? ""),
            ),
            SizedBox(width: 10),
            Flexible(
              child: TextField(
                focusNode: controller.focusNode,
                controller: controller.textController,
                enabled: controller.textFieldEnabled,
                onTap: controller.scrollToEnd,
                decoration: InputDecoration(
                  hintText: "댓글을 입력하세요.",
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Icon(CupertinoIcons.paperplane),
                onPressed: () => {controller.addReply()})
          ],
        ),
      ),
    );
  }
}
