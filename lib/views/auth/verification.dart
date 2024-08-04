import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/auth/reset_password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../core/design/app_button.dart';
import '../../core/design/second_app_bar.dart';
import '../../core/theme.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final countDownController = CountDownController();
  final codeController = TextEditingController();
  bool completed = false, isTimeFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Verification"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r).copyWith(top: 36.h),
        child: Column(
          children: [
            Center(
              child: Text(
                "Verification",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontFamily: AppTheme.fontFamily2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Please enter the code we just sent to\nemail amramer522@gmail.com",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
            SizedBox(height: 30.h),
            PinCodeTextField(
              length: 4,
              controller: codeController,
              animationType: AnimationType.fade,
              mainAxisAlignment: MainAxisAlignment.center,
              keyboardType: TextInputType.number,
              separatorBuilder: (context, index) => SizedBox(
                width: 20.w,
              ),
              cursorHeight: 24.h,
              textStyle: TextStyle(
                  fontSize:  16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
              cursorColor: Theme.of(context).primaryColor.withOpacity(.5),
              enableActiveFill: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12.r),
                fieldHeight: 48.h,
                fieldWidth: 48.h,
                activeFillColor: Theme.of(context).primaryColor,
                inactiveColor: const Color(0xffE9E9E9),
                activeColor: Theme.of(context).primaryColor,
                selectedColor: Theme.of(context).primaryColor,
                inactiveFillColor: Colors.transparent,
                selectedFillColor: Colors.transparent,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              appContext: context,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    if (isTimeFinished) {
                      countDownController.restart();
                      isTimeFinished = false;
                      setState(() {});
                    }
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: "If you didn't receive a code. ",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            )),
                        TextSpan(
                          text: "Resend",
                          style: TextStyle(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(isTimeFinished ? 1 : .32),
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                // const Spacer(),
                CircularCountDownTimer(
                  duration: 60,
                  controller: countDownController,
                  width: 50.w,
                  height: 50.h,
                  isTimerTextShown: !isTimeFinished,
                  autoStart: true,
                  ringColor: Colors.transparent,
                  fillColor: Colors.transparent,
                  fillGradient: null,
                  strokeWidth: 0,
                  strokeCap: StrokeCap.square,
                  textFormat: CountdownTextFormat.MM_SS,
                  textStyle:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  isReverse: true,
                  onComplete: () {
                    isTimeFinished = true;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: "Verify",
        type: ButtonType.bottomNav,
        onPress: () {
          navigateTo(const ResetPasswordView());
        },
      ),
    );
  }
}
