import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/app_image.dart';

class ItemCheckList extends StatelessWidget {
  final String? title;
  final List<String> list;

  const ItemCheckList({super.key,  this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Theme.of(context).primaryColor.withOpacity(.08)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title!=null)
          Text(
            title!,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          if(title!=null)
            Padding(
              padding:  EdgeInsets.only(top: 8.h,bottom: 8.h),
              child: Text(
                "Steps",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          Column(
            children: List.generate(
              list.length,
              (index) => Padding(
                padding:
                    EdgeInsets.only(bottom: index == list.length - 1 ? 0 : 6.h),
                child: Row(
                  children: [
                    AppImage(
                      "achievement.svg",
                      height: 12.h,
                      width: 12.h,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                        child: Text(
                      list[index],
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff8C8C8C),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
