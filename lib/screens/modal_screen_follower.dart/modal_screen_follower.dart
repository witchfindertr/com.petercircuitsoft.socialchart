import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/models/model_user_list.dart';
import 'package:socialchart/screens/modal_screen_follower.dart/modal_screen_follower_controller.dart';

class ModalScreenFollower extends GetView<ModalScreenFollowerController> {
  const ModalScreenFollower({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: controller.tabController,
          tabs: controller.follwerTabs,
          labelColor: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: controller.tabController,
          children: [
            PagedListView.separated(
              pagingController: controller.followerPagingController,
              builderDelegate: PagedChildBuilderDelegate<
                  QueryDocumentSnapshot<ModelUserList>>(
                itemBuilder: (context, item, index) => ListTile(
                  title: Text(
                    item.data().userId,
                  ),
                ),
              ),
              separatorBuilder: (context, index) => Divider(),
            ),
            PagedListView.separated(
              pagingController: controller.followingPagingController,
              builderDelegate: PagedChildBuilderDelegate<
                  QueryDocumentSnapshot<ModelUserList>>(
                itemBuilder: (context, item, index) => ListTile(
                  title: Text(
                    item.data().userId,
                  ),
                ),
              ),
              separatorBuilder: (context, index) => Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
