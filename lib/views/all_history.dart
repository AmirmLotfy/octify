import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/second_app_bar.dart';

import 'home/pages/home.dart';

class AllHistoryView extends StatefulWidget {
  const AllHistoryView({super.key});

  @override
  State<AllHistoryView> createState() => _AllHistoryViewState();
}

class _AllHistoryViewState extends State<AllHistoryView> {
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
      appBar: const SecondAppBar(text: "All History",),
      body: ListView.separated(
        padding: EdgeInsets.all(24.r),
        itemBuilder: (context, index) => ItemHistory(model: list[index]),
        separatorBuilder: (context, index) => SizedBox(height: 16.5.h),
        itemCount: list.length,
      ),
    );
  }
}
