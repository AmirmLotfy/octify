import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

class AppExpansionTile extends StatefulWidget {
  final String title, label;
  final String icon;
  final List<String> list;
  final ValueChanged<String?> onChange;
  final double? marginBottom;

  const AppExpansionTile({
    super.key,
    required this.title,
    required this.label,
    required this.list,
    this.marginBottom,
    required this.icon,
    required this.onChange,
  });

  @override
  State<AppExpansionTile> createState() => _AppExpansionTileState();
}

class _AppExpansionTileState extends State<AppExpansionTile> {
  bool isOpen = false;
  String? selectedValue;
  final controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.marginBottom ?? 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 10.h),
          ExpansionTile(
            controller: controller,
            collapsedBackgroundColor: const Color(0xffFAFAFA),
            leading: AppImage(
              widget.icon,
              height: 24.h,
              width: 24.h,
            ),
            title: Text(
              selectedValue ?? widget.title,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff8C8C8C)),
            ),
            collapsedShape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(12.r),
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(12.r),
            ),
            onExpansionChanged: (value) {
              isOpen = value;
              setState(() {});
            },
            childrenPadding: EdgeInsets.symmetric(horizontal: 16.w),
            trailing: Transform.rotate(
              angle: isOpen ? 0 : pi,
              child: AppImage(
                "arrow_up.svg",
                height: 24.h,
                width: 24.h,
              ),
            ),
            children: [
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    widget.list.length,
                    (index) => GestureDetector(
                      onTap: () {
                        selectedValue = widget.list[index];
                        controller.collapse();
                        setState(() {});
                        widget.onChange(selectedValue);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Text(
                          widget.list[index],
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xff8c8c8c),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
