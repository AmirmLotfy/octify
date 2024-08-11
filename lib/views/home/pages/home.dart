import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/cache_helper.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/results.dart';

import '../../all_history.dart';
import '../../select_persona.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // todo: need the rest of bg shapes
  List<HistoryModel> list = [
    // HistoryModel(
    //   icon: "child_fill.svg",
    //   title: "My Child",
    //   body:
    //       "Track your child's developmental milestones, challenges, and achievements. View past advice and insights tailored to their growth.",
    //   bgShape: "shape1.svg",
    //   color: const Color(0xffA6B2EE),
    // ),
    // HistoryModel(
    //   icon: "partner_filled.svg",
    //   title: "My Partner",
    //   body:
    //       "Review your relationship history, past advice, and personalized insights. Monitor key moments and challenges faced together.",
    //   bgShape: "shape2.svg",
    //   color: const Color(0xff8FD1CD),
    // ),
    // HistoryModel(
    //   icon: "parent_fill.svg",
    //   title: "My Parent",
    //   body:
    //       "Keep a record of your parent's health updates, caregiving tips, and relationship advice. Access previous guidance tailored to their needs.",
    //   bgShape: "shape3.svg",
    //   color: const Color(0xff7FD2F2),
    // ),
    // HistoryModel(
    //     icon: "friend_filled.svg",
    //     title: "My Friend",
    //     body:
    //         "Maintain a history of your friend's important events, interests, and challenges. Revisit past advice to strengthen your friendship.",
    //     bgShape: "shape4.svg",
    //     color: const Color(0xffFEDEA5)),
    // HistoryModel(
    //     icon: "my_self_fill.svg",
    //     title: "Myself",
    //     body:
    //         "View your personal growth journey, self-care plans, and past advice. Reflect on your progress and revisit previous recommendations.",
    //     bgShape: "shape1.svg",
    //     color: const Color(0xffEBCAE7)),
    // HistoryModel(
    //     icon: "my_pet_fill.svg",
    //     title: "My Pet",
    //     body:
    //         "Record your pet’s health updates, care tips, and special moments. Access past advice to ensure your pet’s well-being.",
    //     bgShape: "shape2.svg",
    //     color: const Color(0xffC2D6FE)),
    // HistoryModel(
    //     icon: "colleague_filled.svg",
    //     title: "My Colleague",
    //     body:
    //         "Monitor key interactions, professional challenges, and milestones with your colleague. Access past advice to improve workplace relationships and collaboration.",
    //     bgShape: "shape3.svg",
    //     color: const Color(0xff96D9B0)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Center(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  // todo show user image if founded else show the first char of his name
                  if (CacheHelper.image.isEmpty &&
                      CacheHelper.firstName.isNotEmpty)
                    Container(
                      height: 48.h,
                      width: 48.h,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xffEEEEEE),
                          )),
                      child: Text(
                        CacheHelper.firstName[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  if (CacheHelper.image.isNotEmpty)
                    ClipOval(
                      child: AppImage(
                        CacheHelper.image,
                        height: 48.h,
                        fit: BoxFit.cover,
                        width: 48.h,
                      ),
                    ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Hello,",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        CacheHelper.name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24).copyWith(top: 8.h),
        child: Column(
          children: [
            if (list.length > 4)
              Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "History",
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600),
                    ),
                    TextButton(
                        onPressed: () {
                          navigateTo(AllHistoryView(list: list));
                        },
                        child: const Text("View All"))
                  ],
                ),
              ),
            Expanded(
              child: Builder(builder: (context) {
                if (list.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppImage("create_persona.svg"),
                        Text(
                          "Create a unique persona to tailor solutions\nthat perfectly align with your needs.",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Theme.of(context).hintColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 32.h),
                        FilledButton.icon(
                          icon: const AppImage("add.svg"),
                          onPressed: () {
                            navigateTo(SelectPersonaView());
                          },
                          label: const Text("Create Persona"),
                        )
                      ],
                    ),
                  );
                }
                return ListView.separated(
                  // padding: EdgeInsets.all(24.r),
                  itemBuilder: (context, index) =>
                      ItemHistory(model: list[index]),
                  separatorBuilder: (context, index) =>
                      SizedBox(height: 16.5.h),
                  itemCount: list.length > 4 ? 4 : list.length,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryModel {
  final String icon, title, body, bgShape;
  final Color color;

  HistoryModel(
      {required this.icon,
      required this.title,
      required this.body,
      required this.bgShape,
      required this.color});
}

class ItemHistory extends StatelessWidget {
  final HistoryModel model;

  const ItemHistory({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(ResultsView(
          title: model.title,
        ));
      },
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: model.color,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppImage(
                model.bgShape,
                height: 132.h,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        AppImage(
                          model.icon,
                          height: 48.h,
                          width: 48.h,
                        ),
                        SizedBox(width: 16.w),
                        Text(
                          model.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      model.body,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
