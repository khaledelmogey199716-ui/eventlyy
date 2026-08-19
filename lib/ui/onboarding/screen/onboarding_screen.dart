import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/core/reusable_components/custom_btn.dart';
import 'package:evently_c19/ui/onboarding/widgets/onboarding_model.dart';
import 'package:evently_c19/ui/onboarding/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:evently_c19/core/remote/local/prefs_manager.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  Future<void> _finishOnboarding() async {
    await PrefsManager.setOnboardingCompleted();

    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed(
      RoutesManager.loginRouteName,
    );
  }

  int currentPage = 0;

  PageController pageController = PageController();

  List<OnboardingModel> onboarding = [
    OnboardingModel(image: AssetsManager.onboarding1,
        text1: StringsManager.onboardingTitle1,
        text2: StringsManager.onboardingBody1),

    OnboardingModel(image: AssetsManager.onboarding2,
        text1: StringsManager.onboardingTitle2,
        text2: StringsManager.onboardingBody2),

    OnboardingModel(image: AssetsManager.onboarding3,
        text1: StringsManager.onboardingTitle3,
        text2: StringsManager.onboardingBody3),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AssetsManager.logo,
          height: 27,
          fit: BoxFit.fitHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
        actions: [
          if(currentPage!=onboarding.length-1)
          InkWell(
            onTap: _finishOnboarding,
            child: Container(
              margin: EdgeInsets.only(right: 16),
              padding: EdgeInsets.symmetric(vertical: 5.5,horizontal: 16),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).colorScheme.onSecondary )

              ),
              child:
              Text(StringsManager.skip, style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              )
              ),),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  left: 16,
                  bottom: 28,
                  top: 24
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(onboarding[index].image,width: double.infinity,fit: BoxFit.fitWidth,color: Theme.of(context).colorScheme.onTertiary,),
                      PageIndicator(currentPage: currentPage,pageCount: 3,),
                      Text(onboarding[index].text1,style: Theme.of(context).textTheme.titleMedium,),
                      Expanded(child: Text(onboarding[index].text2,style: Theme.of(context).textTheme.bodyMedium,)),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: CustomBtn(
                          title: currentPage == 2
                              ? StringsManager.getStarted
                              : StringsManager.next,
                          onClick: () {
                            if (currentPage < 2) {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              _finishOnboarding();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );

            },
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });

              },
            itemCount: onboarding.length,),
          ),
        ],
      ),
    );
  }


}
