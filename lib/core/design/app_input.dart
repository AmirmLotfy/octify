import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_image.dart';

enum InputType { normal, password, money, phone }

class AppInput extends StatefulWidget {
  final InputType inputType;
  final String? hint, label;
  final Widget? suffix;
  final String? prefix;
  final double? marginBottom;
  final Color? prefixColor;
  final bool isDense;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String value)? onChanged;
  final void Function(bool value)? onTogglePassword;

  const AppInput({
    super.key,
    this.hint,
    this.marginBottom,
    this.prefix,
    this.prefixColor,
    this.inputType = InputType.normal,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.validator,
    this.onChanged,
    this.isDense = false,
    this.suffix,
    this.maxLines = 1,
    this.label,
    this.onTogglePassword,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isPasswordShown = false;
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.marginBottom ?? 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Text(
                widget.label!,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
              ),
            ),
          TextFormField(
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            controller: widget.controller,
            onChanged: widget.onChanged,
            minLines: widget.maxLines,
            maxLines: widget.maxLines,
            obscuringCharacter: "*",
            obscureText:
                ((widget.inputType == InputType.password) && !isPasswordShown),
            textInputAction: widget.textInputAction,
            keyboardType: widget.keyboardType,
            validator: (value) {
              if (widget.validator != null &&
                  widget.validator!(value) != null &&
                  widget.validator!(value)!.isNotEmpty) {
                isError = true;
              } else {
                isError = false;
              }

              setState(() {});
              return widget.validator != null ? widget.validator!(value) : null;
            },
            inputFormatters: [
              if ([InputType.money].contains(widget.inputType))
                FilteringTextInputFormatter.allow(RegExp("^(?!0)[0-9\\s]*")),
              if (widget.inputType == InputType.phone)
                FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
            ],
            decoration: InputDecoration(
              hintText: widget.hint,
              alignLabelWithHint: true,
              fillColor: isError
                  ? Theme.of(context).primaryColor.withOpacity(.1)
                  : null,
              isDense: widget.isDense,
              prefixIcon:
                  widget.prefix != null || widget.inputType == InputType.phone
                      ? SizedBox(
                          height: 20.h,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 16.w),
                              widget.inputType == InputType.phone
                                  ? const AppImage(
                                      "saudi.png",
                                      height: 20,
                                      width: 20,
                                    )
                                  : AppImage(
                                      widget.prefix!,
                                      color: widget.prefixColor,
                                      // height: 20.h,
                                      width: 30.h,
                                    ),
                              if (widget.inputType == InputType.phone)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: const VerticalDivider(),
                                ),
                              if (widget.inputType == InputType.phone)
                                SizedBox(width: 8.w),
                              if (widget.inputType == InputType.phone)
                                Text(
                                  "+966",
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              if (widget.inputType == InputType.phone)
                                SizedBox(width: 4.w),
                            ],
                          ),
                        )
                      : null,
              suffixIcon: widget.inputType == InputType.password
                  ? IconButton(
                      onPressed: () {
                        isPasswordShown = !isPasswordShown;
                        if (widget.onTogglePassword != null) {
                          widget.onTogglePassword!(isPasswordShown);
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        isPasswordShown
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Color(isPasswordShown
                            ? Theme.of(context).primaryColor.value
                            : 0xff8C8C8C),
                      ),
                    )
                  : widget.suffix ?? const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
