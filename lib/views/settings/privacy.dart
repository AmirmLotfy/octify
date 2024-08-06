import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/views/components/item_check_list.dart';

import '../../core/design/second_app_bar.dart';

class PrivacyView extends StatefulWidget {
  const PrivacyView({super.key});

  @override
  State<PrivacyView> createState() => _PrivacyViewState();
}

class _PrivacyViewState extends State<PrivacyView> {
  final list = [
    _Model(
      image: "data_usage.svg",
      title: "Data Usage",
      subTitle:
          "Your data helps us enhance user experience, support functionality, and analyze trends. We use collected",
      items: [
        "Personalizing your experience.",
        "Improving app performance.",
        "Communicating updates and offers."
      ],
    ),
    _Model(
      image: "data_sharing.svg",
      title: "Data Sharing",
      subTitle:
          "We may share your data with trusted partners for specific purposes, such as:",
      items: [
        "Service providers for app functionality.",
        "Analytics providers to understand usage patterns.",
        "Legal authorities if required by law."
      ],
    ),
    _Model(
      image: "user_rights.svg",
      title: "User Rights",
      subTitle: "You have the right to:",
      items: [
        "Access your data.",
        "Request correction or deletion.",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Data Privacy and Usage Policy"),
      body: ListView.separated(
        padding: EdgeInsets.all(24.r),
        itemBuilder: (context, index) => _Item(
          model: list[index],
        ),
        separatorBuilder: (context, index) => SizedBox(height: 24.h),
        itemCount: list.length,
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final _Model model;

  const _Item({required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppImage(
              model.image,
              height: 24.h,
              width: 24.h,
            ),
            SizedBox(width: 4.w),
            Text(
              model.title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        SizedBox(height: 14.h),
        Text(
          model.subTitle,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 14.h),
        ItemCheckList(
          list: model.items,
        ),
      ],
    );
  }
}

class _Model {
  final String image, title, subTitle;
  final List<String> items;

  _Model(
      {required this.image,
      required this.title,
      required this.subTitle,
      required this.items});
}
