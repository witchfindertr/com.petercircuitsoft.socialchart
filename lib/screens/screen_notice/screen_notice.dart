import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:socialchart/app_constant.dart';
import 'package:socialchart/custom_widgets/main_sliver_appbar.dart';
import 'package:socialchart/models/model_user_notice.dart';
import 'package:socialchart/navigators/navigator_main/navigator_main_controller.dart';
import 'package:socialchart/screens/screen_notice/screen_notice_controller.dart';

class ScreenNotice extends GetView<ScreenNoticeController> {
  const ScreenNotice({super.key, required this.navKey});

  final NavKeys navKey;

  @override
  // TODO: implement tag
  String? get tag => navKey.name;

  static const routeName = "/ScreenNotice";

  @override
  Widget build(BuildContext context) {
    NavigatorMainController.to.scrollControllerMap.addEntries(
        {'${navKey.index}$routeName': controller.scrollController}.entries);
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => controller.pagingController.refresh(),
          ),
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              MainSliverAppbar(
                titleText: 'Notice',
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              SliverToBoxAdapter(
                child: const SizedBox(),
              ),
              PagedSliverList.separated(
                pagingController: controller.pagingController,
                separatorBuilder: (context, index) {
                  return Container(
                    color: Theme.of(context).backgroundColor,
                    height: 8,
                  );
                },
                builderDelegate: PagedChildBuilderDelegate<
                    QueryDocumentSnapshot<ModelUserNotice>>(
                  itemBuilder: ((context, item, index) {
                    return Text(item.data().insightCardId);
                  }),
                  noItemsFoundIndicatorBuilder: (context) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "알림이 없습니다.",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                  noMoreItemsIndicatorBuilder: (context) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "👆👆마지막 알림입니다.👆👆",
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
    );
  }
}
