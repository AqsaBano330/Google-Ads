import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  void init(){
    super.initState();
    initBannerAd();
  }

late BannerAd bannerAd;
bool isAdLoaded = false;
var adUnit = "ca-app-pub-3511723039021473/5813113198";

initBannerAd(){
  bannerAd = BannerAd(
    size: AdSize.banner,
     adUnitId: adUnit,
      listener: BannerAdListener(
        onAdLoaded: (ad){
          setState(() {
            isAdLoaded = true;
          });
        },

        onAdFailedToLoad: (ad, error){
          ad.dispose();
          print(error);
        }
      ), 
      request: AdRequest());
      bannerAd.load();
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: isAdLoaded ? SizedBox(
        height: bannerAd.size.height.toDouble(),
        width: bannerAd.size.width.toDouble(),
        child: AdWidget(ad: bannerAd),
      ): SizedBox(),

    );
  }
}