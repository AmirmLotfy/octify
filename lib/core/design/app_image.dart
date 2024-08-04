import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum FailedImageType { normal, male, female }

class AppImage extends StatelessWidget {
  final FailedImageType failedImageType;
  final bool isClickable;
  final String url;
  final double? height, width;
  final Color? color;
  final BoxFit fit;

  const AppImage(
    this.url, {
    super.key,
    this.height,
    this.isClickable = false,
    this.width,
    this.color,
    this.fit = BoxFit.scaleDown,
    this.failedImageType = FailedImageType.normal,
  });

  @override
  Widget build(BuildContext context) {
    if (url.startsWith('https')) {
      return Image.network(
        url,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => errWidget,
      );
    } else if (url.endsWith("svg")) {
      return SvgPicture.asset(
        "assets/svg/$url",
        height: height,
        width: width,
        color: color,
        fit: fit,
      );
    }  else if (url.contains("com.araby.octify")) {
      return Image.file(
        File(url),
        color: color,
        errorBuilder: (context, error, stackTrace) => errWidget,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      if (url.isEmpty) {
        return errWidget;
      }
      return Image.asset(
        "assets/images/$url",
        color: color,
        errorBuilder: (context, error, stackTrace) => errWidget,
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  void showImage(context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        titlePadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        contentPadding: EdgeInsets.zero,
        children: [
          Stack(
            alignment: AlignmentDirectional.topEnd,
            children: [
              Image.memory(
                base64Decode(url),
              ),
              PositionedDirectional(
                top: 16.h,
                end: 16.w,
                child: const CloseButton(),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget get errWidget => Image.asset(
        "assets/images/$_errorImage",
        height: height ?? 20,
        width: width ?? 20,
        fit: BoxFit.scaleDown,
      );

  String get _errorImage {
    switch (failedImageType) {
      case FailedImageType.male:
        return "male_failed.png";
      case FailedImageType.female:
        return "female_failed.png";
      default:
        return "normal_failed.png";
    }
  }
}
