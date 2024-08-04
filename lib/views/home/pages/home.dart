import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/results.dart';

import '../../all_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final list = [
    HistoryModel(
        icon: "parent_fill.svg",
        title: "Parent",
        body:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        bgShape: "bgShape",
        color: const Color(0xff7FD2F2)),
    HistoryModel(
        icon: "child_fill.svg",
        title: "Child",
        body:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        bgShape: "bgShape",
        color: const Color(0xffA6B2EE)),
    HistoryModel(
        icon: "my_self_fill.svg",
        title: "Myself",
        body:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        bgShape: "bgShape",
        color: const Color(0xffEBCAE7)),
    HistoryModel(
        icon: "my_pet_fill.svg",
        title: "My Pet",
        body:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        bgShape: "bgShape",
        color: const Color(0xffC2D6FE)),
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
                      "A",
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor,
                      ),
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
                        "Amr Bakr",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "History",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                TextButton(
                    onPressed: () {
                      navigateTo(AllHistoryView());
                    },
                    child: const Text("View All"))
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.separated(
                // padding: EdgeInsets.all(24.r),
                itemBuilder: (context, index) => ItemHistory(model: list[index]),
                separatorBuilder: (context, index) => SizedBox(height: 16.5.h),
                itemCount: list.length,
              ),
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
        navigateTo(ResultsView(title: model.title,));
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: model.color,
        ),
        child: Column(
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
    );
  }
}
