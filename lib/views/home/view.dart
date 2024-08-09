import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/views/home/pages/create_persona.dart';
import 'package:octify/views/home/pages/home.dart';
import 'package:octify/views/home/pages/settings.dart';

import '../../core/design/app_image.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // todo: remove add persona page that was for the empty case of home
  List<String> icons = [
    "home.svg",
    "home.svg",
    "setting.svg",
  ];
  List<String> titles = [
    "Home",
    "Home",
    "Settings",
  ];
  List<Widget> pages = [
    const HomePage(),
    const CreatePersonaPage(),
    const SettingsPage(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      floatingActionButton: GestureDetector(
        onTap: () {
          currentIndex=1;
          setState(() {

          });
        },
        child: Container(
            height: 60.h,
            width: 60.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: AlignmentDirectional.bottomCenter,
                end: AlignmentDirectional.topCenter,
                colors: [
                  Color(0xffFF4F00),
                  Color(0xffFF9668),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: AppImage(
              "add.svg",
              height: 24.h,
              width: 24.h,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 35,
                color: Colors.black.withOpacity(.1))
          ],
        ),
        child: BottomAppBar(
          height: 80.h,
          elevation: 8,
          shape: const CircularNotchedRectangle(),
          notchMargin: 16.r,
          child: Row(
            children: List.generate(
              3,
              (index) => index == 1
                  ? const Spacer()
                  : Expanded(
                      child: GestureDetector(
                        onTap: () {
                          currentIndex = index;
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 80.h,
                          // color: Colors.green,
                          child: Column(
                            children: [
                              AppImage(
                                icons[index],
                                height: 24.h,
                                width: 24.h,
                                color: index == currentIndex
                                    ? Theme.of(context).primaryColor
                                    : const Color(0xff8C8C8C),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                titles[index],
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: index == currentIndex
                                        ? Theme.of(context).primaryColor
                                        : const Color(0xff8C8C8C)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: currentIndex,
      //   elevation: 20,
      //   onTap: (value) {
      //     print(value);
      //     currentIndex = value;
      //     setState(() {});
      //   },
      //   items: List.generate(
      //     icons.length,
      //     (index) => BottomNavigationBarItem(
      //         icon: AppImage(
      //           icons[index],
      //         ),
      //         activeIcon:
      //             AppImage(icons[index], color: Theme.of(context).primaryColor),
      //         label: titles[index]),
      //   ),
      // ),
    );
  }
}
