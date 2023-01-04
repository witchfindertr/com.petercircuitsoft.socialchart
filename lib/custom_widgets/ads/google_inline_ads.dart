import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:socialchart/custom_widgets/ads/google_inline_ads_controller.dart';
import 'package:get/get.dart';

class GoogleInlineAds extends StatelessWidget {
  const GoogleInlineAds({
    super.key,
    this.height,
    required this.width,
    required this.tag,
  });
  final double? height;
  final double width;
  final String tag;

  @override
  Widget build(BuildContext context) {
    // var controller =
    //     Get.put<GoogleInlineAdsController>(GoogleInlineAdsController(containerWidth: width, containerHeight: height),tag: tag);
    return GetBuilder(
      init: GoogleInlineAdsController(
        containerWidth: width,
        containerHeight: height,
      ),
      tag: tag,
      didChangeDependencies: (state) {
        // print("didChangeDependencies");
        state.controller!.loadAd();
      },
      builder: (controller) {
        return Obx(
          () => controller.inlineAdaptiveAd != null &&
                  controller.isLoaded &&
                  controller.adSize != null
              ? Container(
                  height: height ?? controller.adSize!.height.toDouble(),
                  child: AdWidget(
                    ad: controller.inlineAdaptiveAd!,
                  ),
                )
              : SizedBox(height: height ?? 0),
        );
      },
    );
  }
}
