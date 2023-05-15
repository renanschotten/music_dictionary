import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:music_dictionary/shared/core/ads/ad_helper.dart';
import 'package:music_dictionary/shared/core/crashlytics_logging.dart';

class AdController {
  ValueNotifier<BannerAd?> banner = ValueNotifier<BannerAd?>(null);

  void initBanner() {
    BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          banner.value = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, error) {
          CrashlyticsLogging.instance.recordError(
            message: error.message,
          );
          ad.dispose();
        },
      ),
    ).load();
  }
}
