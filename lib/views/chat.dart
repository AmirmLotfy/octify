import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../core/design/app_back.dart';
import '../core/design/app_empty.dart';
import '../core/design/app_failed.dart';
import '../core/design/app_image.dart';
import '../core/design/app_loading.dart';
import '../features/get_messages/bloc.dart';
import '../features/send_message/bloc.dart';

// id patient person
// id support person
class ChatView2 extends StatefulWidget {
  const ChatView2({super.key});

  @override
  State<ChatView2> createState() => _ChatView2State();
}

class _ChatView2State extends State<ChatView2> {
  final bloc = KiwiContainer().resolve<GetMessagesBloc>()
    ..add(GetMessagesEvent());
  final messageController = TextEditingController();
  final listController = ScrollController();
  final sendMessageBloc = KiwiContainer().resolve<SendMessageBloc>();
  var inputDirection = TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBack(),
        title: Row(
          children: [
            AppImage(
              "logo.png",
              height: 32.h,
              width: 32.h,
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Octify",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 3,
                      backgroundColor: Color(0xff3ABF38),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Active Now",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff3ABF38),
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder(
              bloc: bloc,
              builder: (context, state) {
                if (state is GetMessagesFailedState) {
                  return AppFailed(
                    msg: state.msg,
                    onPress: () {},
                  );
                } else if (state is GetMessagesSuccessState) {
                  if (state.list.isEmpty) {
                    return const AppEmpty(image: "", title: "No Messages Yet.");
                  }
                  return ListView.separated(
                    controller: listController,
                    reverse: true,
                    padding: EdgeInsets.all(24.r),
                    itemBuilder: (context, index) => _Item(
                      index: index,
                      model: state.list[index],
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemCount: state.list.length,
                  );
                } else {
                  return const AppLoading();
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w)
                .copyWith(bottom: 16.h, top: 2.h),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: messageController,
                    textDirection: inputDirection,
                    style: TextStyle(fontSize: 14.sp),
                    onChanged: (value) {
                      setState(() {});
                      /*
                       if(first char is arab)
                         inputDirection = TextDirection.rtl
                         else
                         inputDirection = TextDirection.ltr

                         setState
                       */
                    },
                    decoration: const InputDecoration(
                      hintText: "Type something...",
                    ),
                  ),
                ),
                BlocConsumer(
                  bloc: sendMessageBloc,
                  listener: (context, state) {
                    if (state is SendMessageSuccessState) {
                      bloc.add(AppendMessageEvent(
                        data: messageController.text,
                      ));
                      messageController.clear();
                      listController.jumpTo(0);
                    }
                  },
                  builder: (context, state) {
                    if (state is SendMessageLoadingState) {
                      return Padding(
                        padding: EdgeInsets.all(8.r),
                        child: const CircularProgressIndicator(strokeWidth: 1),
                      );
                    }
                    return IconButton(
                      iconSize: 20.r,
                      icon: AppImage(
                        "send.svg",
                        height: 24.h,
                        width: 24.h,
                        color: Theme.of(context).primaryColor.withOpacity(
                            messageController.text.isEmpty ? .2 : 1),
                      ),
                      onPressed: () {
                        sendMessageBloc.add(SendMessageEvent());
                      },
                    );
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final int index;
  final MessageModel model;

  const _Item({required this.index, required this.model});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: model.isMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!model.isMe)
            AppImage(
              "logo.png",
              height: 32.h,
              width: 32.h,
            ),
          if (!model.isMe) SizedBox(width: 8.w),
          _TextMessage(model: model),
        ],
      ),
    );
  }
}

class _TextMessage extends StatelessWidget {
  final MessageModel model;

  const _TextMessage({required this.model});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(12.r),
            decoration: BoxDecoration(
                color: model.isMe
                    ? Theme.of(context).primaryColor
                    : const Color(0xffF4F4F4),
                borderRadius: BorderRadiusDirectional.only(
                  bottomStart: Radius.circular(12.r),
                  topStart: model.isMe ? Radius.circular(12.r) : Radius.zero,
                  topEnd: Radius.circular(12.r),
                  bottomEnd: model.isMe ? Radius.zero : Radius.circular(12.r),
                )),
            child: Text(
              model.message.toString(),
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: model.isMe ? Colors.white : null),
            ),
          ),
          SizedBox(height: 4.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              model.timeSent.toString(),
              style: TextStyle(
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xff8C8C8C),
              ),
            ),
          )
        ],
      ),
    );
  }
}
