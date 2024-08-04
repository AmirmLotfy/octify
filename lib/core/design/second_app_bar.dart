
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_back.dart';

class SecondAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;
  final Widget? bottom;
  final double? bottomSize;

  const SecondAppBar(
      {super.key,
      required this.text,
      this.actions,
      this.bottom,
      this.bottomSize});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom != null || bottomSize != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(bottomSize!),
              child: bottom!,
            )
          : null,
      leading: const AppBack(),
      title: Text(text),
      actions: actions,
      titleSpacing: 4.w,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h + (bottomSize ?? 0));
}
