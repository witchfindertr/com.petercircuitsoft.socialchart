import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

class GoogleInlineAdsController extends GetxController {
  GoogleInlineAdsController({
    required this.containerWidth,
    this.containerHeight,
  });
  final double? containerHeight;
  final double containerWidth;

  var _testAdsId = "ca-app-pub-3940256099942544/6300978111";
  final _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-5515079939326185~2414708172'
      : 'ca-app-pub-5515079939326185~6545524874';
  final _inlineAdaptiveAd = Rxn<BannerAd>();

  BannerAd? get inlineAdaptiveAd => _inlineAdaptiveAd.value;
  set inlineAdaptiveAd(BannerAd? value) => _inlineAdaptiveAd.value = value;

  final _isLoaded = false.obs;
  bool get isLoaded => _isLoaded.value;
  set isLoaded(bool value) => _isLoaded.value = value;

  AdSize? adSize;

  double get _adWidth => containerWidth;

  void loadAd() async {
    await inlineAdaptiveAd?.dispose();
    inlineAdaptiveAd = null;
    isLoaded = false;

    // Get an inline adaptive size for the current orientation.
    AdSize size = AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(
        _adWidth.truncate());

    inlineAdaptiveAd = BannerAd(
      //todo: first item has to be changed to _adUnitId before release
      adUnitId: kReleaseMode ? _testAdsId : _testAdsId,
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) async {
          print('Inline adaptive banner loaded: ${ad.responseInfo}');

          // After the ad is loaded, get the platform ad size and use it to
          // update the height of the container. This is necessary because the
          // height can change after the ad is loaded.
          BannerAd bannerAd = (ad as BannerAd);
          final AdSize? size = await bannerAd.getPlatformAdSize();
          if (size == null) {
            print('Error: getPlatformAdSize() returned null for $bannerAd');
            return;
          }

          inlineAdaptiveAd = bannerAd;
          isLoaded = true;
          adSize = size;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Inline adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    await inlineAdaptiveAd!.load();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadAd();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    inlineAdaptiveAd?.dispose();
  }
}
