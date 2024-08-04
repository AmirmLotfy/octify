import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/views/auth/login_or_register.dart';

import '../../core/design/app_button.dart';
import '../../core/design/app_image.dart';
import '../../core/logic/helper_methods.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  double sliderValue = 10;

  final list = [
    _Model(
        title: "Welcome to Octify",
        desc:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        image: "on_boarding1.svg"),
    _Model(
        title: "Lorem Ipsum",
        desc:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        image: "on_boarding2.svg"),
    _Model(
        title: "Lorem Ipsum",
        desc:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
        image: "on_boarding3.svg"),
  ];

  int currentPage = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            currentPage != list.length - 1
                ? Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        navigateTo(const LoginOrRegisterView());
                      },
                      child: const Text("Skip"),
                    ),
                  )
                : SizedBox(
                    height: 24.h,
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: PageView.builder(
                controller: pageController,
                itemCount: list.length,
                onPageChanged: (value) {
                  currentPage = value;
                  setState(() {});
                },
                itemBuilder: (context, index) => Center(
                  child: AppImage(
                    list[index].image,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  list.length,
                  (index) => Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8),
                    child: Container(
                      height: 7,
                      width: currentPage == index ? 20.w : 7.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: currentPage == index
                            ? Theme.of(context).primaryColor
                            : const Color(0xffD9D9D9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                list[currentPage].title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  list[currentPage].desc,
                  textAlign: TextAlign.center,
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xff7E7E7E)),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: currentPage != list.length - 1 ? "Next" : "Get Started",
        type: ButtonType.bottomNav,
        onPress: () {
          if (currentPage == list.length - 1) {
            navigateTo(const LoginOrRegisterView());
          } else {
            pageController.nextPage(
              duration: const Duration(milliseconds: 1200),
              curve: Curves.bounceInOut,
            );
          }
        },
      ),
    );
  }
}

class _Model {
  final String image, title, desc;

  _Model({
    required this.title,
    required this.desc,
    required this.image,
  });
}
