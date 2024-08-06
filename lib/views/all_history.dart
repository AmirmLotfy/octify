import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/second_app_bar.dart';

import 'home/pages/home.dart';

class AllHistoryView extends StatefulWidget {
  final List<HistoryModel> list;
  const AllHistoryView({super.key, required this.list});

  @override
  State<AllHistoryView> createState() => _AllHistoryViewState();
}

class _AllHistoryViewState extends State<AllHistoryView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "All History",),
      body: ListView.separated(
        padding: EdgeInsets.all(24.r),
        itemBuilder: (context, index) => ItemHistory(model: widget.list[index]),
        separatorBuilder: (context, index) => SizedBox(height: 16.5.h),
        itemCount: widget.list.length,
      ),
    );
  }
}
