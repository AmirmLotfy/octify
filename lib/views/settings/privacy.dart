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
    _Category(title: "Information We Collect", list: [
      _Model(
        image: "data_usage.svg",
        title: "Personal Information",
        subTitle:
            "Name, age, gender, and contact details. Health information, interests, hobbies, and other personal details as provided for different personas.",
      ),
      _Model(
        image: "data_sharing.svg",
        title: "Usage Data",
        subTitle:
            "Information about how you use the app, including pages visited, features used, and time spent on the app.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Device Information",
        subTitle:
            "Information about your device, including IP address, browser type, operating system, and device identifiers.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Cookies and Tracking Technologies",
        subTitle:
            "We use cookies and similar technologies to collect information about your interactions with the app to enhance user experience and analyze usage patterns. How We Use Your Information",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Personalization",
        subTitle:
            "To provide personalized advice, insights, and recommendations tailored to your specific personas and their needs.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Improvement of Services",
        subTitle:
            "To analyze usage patterns and feedback to improve the functionality and user experience of the app.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Communication",
        subTitle:
            "To send you notifications, updates, and promotional materials related to the app.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Security",
        subTitle:
            "To monitor and ensure the security of our app, including preventing unauthorized access and fraudulent activities.",
      ),
    ]),
    _Category(title: "Data Sharing and Disclosure", list: [
      _Model(
        image: "user_rights.svg",
        title: "Service Providers",
        subTitle:
            "We may share your information with third-party service providers who perform services on our behalf, such as data analysis, hosting, and customer support. These providers are contractually obligated to protect your information and use it only for the purposes we specify.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Legal Requirements",
        subTitle:
            "We may disclose your information if required to do so by law or in response to valid requests by public authorities.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Business Transfers",
        subTitle:
            "In the event of a merger, acquisition, or sale of all or a portion of our assets, your information may be transferred to the new owner.",
      ),
    ]),
    _Category(title: "Data Security", list: [
      _Model(
        image: "user_rights.svg",
        title: "Access and Correction",
        subTitle:
            "You have the right to access and update your personal information at any time through the app's settings.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Data Deletion",
        subTitle:
            "You can request the deletion of your personal information by contacting us at support@octify.ai. Please note that certain data may be retained for legal or operational purposes.",
      ),
      _Model(
        image: "user_rights.svg",
        title: "Opt-Out",
        subTitle:
            "You can opt-out of receiving promotional communications by following the unsubscribe instructions provided in the communications.",
      ),
    ]),
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
      //todo make like help Effective Date - This Data Privacy and Usage Policy is effective as of Aug 1st 2024.
      // bottomNavigationBar: ,
    );
  }
}

class _Item extends StatelessWidget {
  final _Category model;

  const _Item({required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: 16.h),
        ...List.generate(
          model.list.length,
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.list[index].title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Row(
                //   children: [
                //     AppImage(
                //       model.list[index].image,
                //       height: 24.h,
                //       width: 24.h,
                //     ),
                //     SizedBox(width: 4.w),
                //     Text(
                //       model.title,
                //       style: TextStyle(
                //         fontSize: 18.sp,
                //         fontWeight: FontWeight.w600,
                //         color: Theme.of(context).primaryColor,
                //       ),
                //     )
                //   ],
                // ),
                SizedBox(height: 14.h),
                Text(
                  model.list[index].subTitle,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).hintColor
                  ),
                ),
                if (model.list[index].items != null) SizedBox(height: 14.h),
                if (model.list[index].items != null)
                  ItemCheckList(
                    list: model.list[index].items!,
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _Category {
  final String title;
  final List<_Model> list;

  _Category({required this.title, required this.list});
}

class _Model {
  final String image, title, subTitle;
  final List<String>? items;

  _Model(
      {required this.image,
      required this.title,
      required this.subTitle,
      this.items});
}
