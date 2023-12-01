import 'package:diamond/modules/admob_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdComponent extends StatelessWidget {
  const BannerAdComponent({super.key});

  @override
  Widget build(BuildContext context) {
    AdMobController.instance.loadBanner();
    return ListenableBuilder(
      listenable: AdMobController.instance,
      builder: (context, child) {
        if (AdMobController.instance.loaded) {
          return SizedBox(
            height: AdMobController.instance.bannerAd.size.height.toDouble(),
            width: AdMobController.instance.bannerAd.size.width.toDouble(),
            child: AdWidget(
              ad: AdMobController.instance.bannerAd,
            ),
          );
        }
        return const Text('Loading...');
      },
    );
  }
}
