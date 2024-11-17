// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture customSvg({required String name, Color? color, double? height}) {
  return SvgPicture.asset(
    'assets/images/$name.svg',
    color: color,
    height: height,
  );
}
