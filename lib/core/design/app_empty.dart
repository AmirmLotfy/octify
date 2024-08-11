import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

class AppEmpty extends StatelessWidget {
  final String image;
  final String title;
  final String? hint;

  const AppEmpty({super.key, required this.image, required this.title,this.hint});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(image.isNotEmpty)
          AppImage(
            image,
            height: 200.h,
            width: 250.h,
            // color: Color(0xff8A99AA),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              // color: const Color(0xff090909),
            ),
          ),
          if(hint!=null)
          Padding(
            padding:  EdgeInsets.only(top: 8.h),
            child: Text(
              hint!,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color:Theme.of(context).hintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
