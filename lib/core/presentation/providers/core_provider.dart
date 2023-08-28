import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../core.dart';
import '../../domain/entities/dropdown_option_entities.dart';

class CoreProvider with ChangeNotifier {
  TextEditingController _playerNameController = TextEditingController();
  final List<DropdownOption> languageList = [
    DropdownOption(
      title: "English",
      value: "en",
      index: 0,
    ),
    DropdownOption(title: "Indonesia", value: "id", index: 1),
    DropdownOption(title: "Arabic", value: "ar", index: 2),
    DropdownOption(title: "Chinese", value: "zh", index: 3),
    DropdownOption(title: "Danish", value: "da", index: 4),
    DropdownOption(title: "Dutch", value: "nl", index: 5),
    DropdownOption(title: "Finnish", value: "fi", index: 6),
    DropdownOption(title: "French", value: "fr", index: 7),
    DropdownOption(title: "German", value: "de", index: 8),
    DropdownOption(title: "Greek", value: "el", index: 9),
    DropdownOption(title: "Italian", value: "it", index: 10),
    DropdownOption(title: "Japanese", value: "ja", index: 11),
    DropdownOption(title: "Korean", value: "ko", index: 12),
    DropdownOption(title: "Norwegian", value: "no", index: 13),
    DropdownOption(title: "Polish", value: "pl", index: 14),
    DropdownOption(title: "Portuguese", value: "pt", index: 15),
    DropdownOption(title: "Russian", value: "ru", index: 16),
    DropdownOption(title: "Spanish", value: "es", index: 17),
    DropdownOption(title: "Swedish", value: "sv", index: 18),
    DropdownOption(title: "Turkish", value: "tr", index: 19)
  ];

  RewardedAd? _rewardedAd;
  RewardedAd? _rewardAd;
  DropdownOption? _language =
      DropdownOption(title: "English", value: "en", index: 0);
  late FocusNode focusNodeAddPlayer = FocusNode();

  set setRewardedAd(val) {
    _rewardedAd = val;
    notifyListeners();
  }

  set setRewardAd(val) {
    _rewardAd = val;
    notifyListeners();
  }

  set setLanguage(val) {
    _language = val;
    notifyListeners();
  }

  RewardedAd? get rewardedAd => _rewardedAd;
  RewardedAd? get rewardAd => _rewardAd;
  TextEditingController get playerNameController => _playerNameController;
  DropdownOption? get language => _language;

  void initializeRewardAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          setRewardAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (RewardedAd ad) {
              ad.dispose();
              setRewardedAd = null;
              initializeRewardAd();
            },
            onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
              ad.dispose();
              initializeRewardAd();
            },
          );
        },
        onAdFailedToLoad: (LoadAdError error) {
          printWarning('RewardedAd failed to load: $error');
        },
      ),
    );
  }
}
