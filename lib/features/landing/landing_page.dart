import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/presentation/providers/core_provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  static const String routeName = '/landing';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

final session = locator<Session>();

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<CoreProvider>();
      provider.setLanguage = provider.languageList[session.isIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    appLoc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: deepBluishPurple,
      body: Consumer<CoreProvider>(
        builder: (context, provider, _) {
          return SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: paddingSizeExtraLarge),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDropdown(
                      value: provider.languageList[session.isIndex],
                      dropdownList: provider.languageList,
                      title: appLoc.selectLanguage,
                      onChanged: (value) {
                        provider.setLanguage = value;
                        session.setIndexLanguage = value.index;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: sizeExtraLarge),
                      child: CustomButton(
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.black,
                        ),
                        text: "Mulai Chating",
                        onPressed: () {
                          provider.initializeRewardAd();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
