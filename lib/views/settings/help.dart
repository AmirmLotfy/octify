import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';

import '../../core/design/second_app_bar.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Help and support"),
      body: ListView.separated(
        padding: EdgeInsets.all(24.r),
        itemBuilder: (context, index) => const _Item(),
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemCount: 3,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Theme.of(context).primaryColor.withOpacity(.08)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Support",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Our support team is here to help you. You can reach us via:",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff8C8C8C)),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "support@gmail.com",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff8c8c8c),
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Phone: ",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                      child: Text(
                    "+1-800-555-1234",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff8c8c8c),
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  const _Item();

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: const Text("Lorem Ipsum is simply dummy?"),
      childrenPadding: EdgeInsets.all(16.r),
      trailing: AppImage(isOpen ? "remove_selected.svg" : "add_selected.svg"),
      onExpansionChanged: (value) {
        isOpen = value;
        setState(() {});
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.08),
      children: [
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xff8c8c8c),
          ),
        )
      ],
    );
  }
}
