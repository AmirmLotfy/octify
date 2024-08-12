import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/app_image.dart';

class ItemCheckList extends StatelessWidget {
  final String? title;
  final List<String>? list;

  const ItemCheckList({super.key, this.title, this.list});

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
          if (title != null) BoldableText(title!),
          // if (title != null) Html(data: title!.replaceFirst("```html", "")),
          // Text(
          //   title!,
          //   style: TextStyle(
          //     fontSize: 16.sp,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          if (title != null && list != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
              child: Text(
                "Steps",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          // todo: make it wrap
          if (list != null)
            Wrap(
              children: List.generate(
                list!.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                      bottom: index == list!.length - 1 ? 0 : 6.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppImage(
                        "achievement.svg",
                        height: 12.h,
                        width: 12.h,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                          child: Text(
                        list![index],
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

class BoldableText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool isSelectable;

  const BoldableText(this.text,
      {super.key, this.isSelectable = false, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    final List<TextSpan> children = [];
    final List<String> split = text.split('**');
    for (int i = 0; i < split.length; i++) {
      if (i % 2 == 0) {
        children.add(TextSpan(text: split[i], style: style));
      } else {
        children.add(TextSpan(
            text: split[i],
            style: (style ?? const TextStyle())
                .copyWith(fontWeight: FontWeight.bold)));
      }
    }
    if (isSelectable) {
      return SelectableText.rich(
        TextSpan(children: children),
        style: style,
        textAlign: textAlign,
      );
    }
    return Text.rich(
      TextSpan(children: children),
      style: style,
      textAlign: textAlign,
    );
  }
}
