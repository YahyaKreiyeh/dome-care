import 'package:dome_care/core/constants/constants.dart';
import 'package:dome_care/core/helpers/spacing.dart';
import 'package:dome_care/core/routing/routes.dart';
import 'package:dome_care/core/routing/routes_extension.dart';
import 'package:dome_care/core/style/assets/assets.gen.dart';
import 'package:dome_care/core/themes/app_colors.dart';
import 'package:dome_care/core/themes/text_styles.dart';
import 'package:dome_care/core/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with TickerProviderStateMixin {
  final _pageIndex = ValueNotifier<int>(0);
  late final PageController _pageController;

  final List<_OnboardingPage> _pages = <_OnboardingPage>[
    _OnboardingPage(
      image: Assets.images.onboarding1.path,
      title: 'Book Appointments & Consultations',
      subtitle:
          'You can request a Consultation from Doctors and Book Appointment with them 👨‍⚕️',
    ),
    _OnboardingPage(
      image: Assets.images.onboarding2.path,
      title: 'Keep your Medical Records',
      subtitle:
          'DomeCare allows you to keep your Medical Records safely at anytime, anywhere 🔐',
    ),
    _OnboardingPage(
      image: Assets.images.onboarding3.path,
      title: 'Search for your Medication',
      subtitle:
          'Get fully automated Medication leaflet and search for it in nearest pharmacies🚶‍♂️',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      final page = _pageController.page;
      if (page != null) {
        final rounded = page.round();
        if (_pageIndex.value != rounded) _pageIndex.value = rounded;
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              _OnBoarding(pageController: _pageController, pages: _pages),

              _Indicator(pageIndex: _pageIndex, pages: _pages),

              const _GetStartedButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnBoarding extends StatelessWidget {
  const _OnBoarding({
    required PageController pageController,
    required List<_OnboardingPage> pages,
  }) : _pageController = pageController,
       _pages = pages;

  final PageController _pageController;
  final List<_OnboardingPage> _pages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        itemCount: _pages.length,
        itemBuilder: (context, index) => _OnboardingCard(
          controller: _pageController,
          index: index,
          data: _pages[index],
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required ValueNotifier<int> pageIndex,
    required List<_OnboardingPage> pages,
  }) : _pageIndex = pageIndex,
       _pages = pages;

  final ValueNotifier<int> _pageIndex;
  final List<_OnboardingPage> _pages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 110),
      child: ValueListenableBuilder<int>(
        valueListenable: _pageIndex,
        builder: (_, idx, _) =>
            _DotsIndicator(count: _pages.length, index: idx),
      ),
    );
  }
}

class _OnboardingCard extends StatelessWidget {
  const _OnboardingCard({
    required this.controller,
    required this.index,
    required this.data,
  });

  final PageController controller;
  final int index;
  final _OnboardingPage data;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final currentPage = controller.hasClients
            ? controller.page ?? 0.0
            : 0.0;
        final delta = (controller.hasClients ? index - currentPage : 0.0);

        var t = (1 - delta.abs()).clamp(0.0, 1.0);
        t = Curves.easeOutCubic.transform(t);

        final opacity = t;
        final dy = (1 - t) * 30 * delta.sign;
        final scale = 0.98 + 0.02 * t;

        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, dy),
            child: Transform.scale(scale: scale, child: child),
          ),
        );
      },
      child: Semantics(
        image: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalSpace(36),
            Expanded(
              child: Center(
                child: Image.asset(
                  data.image,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Text(
              data.title,
              textAlign: TextAlign.center,
              style: TextStyles.primaryText70018,
            ),
            VerticalSpace(11),
            Text(
              data.subtitle,
              textAlign: TextAlign.center,
              style: TextStyles.secondaryText40016,
            ),
            VerticalSpace(32),
          ],
        ),
      ),
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          text: 'Get Started',
          onPressed: () => context.pushReplacementNamed(Routes.login),
          textStyle: TextStyles.white50017,
        ),
        VerticalSpace(14),
      ],
    );
  }
}

class _OnboardingPage {
  final String image;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int index;

  const _DotsIndicator({required this.count, required this.index});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (i) {
          final selected = i == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            width: selected ? 70 : 18,
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.notSelectedGrey,
              borderRadius: BorderRadius.circular(radius),
            ),
          );
        }),
      ),
    );
  }
}
