import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/app_button.dart';
import '../../core/design/second_app_bar.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Notification"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            _Item(text: "All chat notification", onChange: (value) {}),
            _Item(text: "All tagged message", onChange: (value) {}),
            _Item(text: "New update notification", onChange: (value) {},withDivider: false,),
          ],
        ),
      ),
      // bottomNavigationBar: AppButton(
      //   text: "Save Changes",
      //   type: ButtonType.bottomNav,
      //   onPress: () {},
      // ),
    );
  }
}

class _Item extends StatefulWidget {
  final String text;
  final bool initValue;
  final bool withDivider;
  final void Function(bool value)? onChange;

  const _Item({
    required this.text,
    required this.onChange,
    this.initValue = false,  this.withDivider=true,
  });

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool isOn = false;

  @override
  void initState() {
    super.initState();
    isOn = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () {
          // onChange();
          isOn = !isOn;
          setState(() {});
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )),
                SizedBox(width: 12.w),
                Switch(
                  value: isOn,
                  onChanged: (value) {
                    isOn = !isOn;
                    setState(() {});
                  },
                )
              ],
            ),
            if(widget.withDivider)
            const Divider(),
          ],
        ),
      ),
    );
  }
}
