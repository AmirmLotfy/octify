import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/design/app_back.dart';
import '../../core/design/app_empty.dart';
import '../../core/design/app_image.dart';
import 'view_model.dart';

class ChatView extends ConsumerWidget {
  final _controller = TextEditingController();

  ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatMessages = ref.watch(chatProvider);
    var inputDirection = TextDirection.ltr;

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
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Builder(builder: (context) {
                // if (chatMessages.isEmpty) {
                //   return const AppEmpty(image: "", title: "No Messages Yet.");
                // }
                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    final isUserMessage =
                        chatMessages[index].startsWith("You:");
                    return Align(
                      alignment: isUserMessage
                          ? AlignmentDirectional.centerEnd
                          : AlignmentDirectional.centerStart,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isUserMessage)
                            AppImage(
                              "logo.png",
                              height: 32.h,
                              width: 32.h,
                            ),
                          if (!isUserMessage) SizedBox(width: 8.w),
                          Flexible(
                            child: IntrinsicWidth(
                              child: Container(
                                padding: EdgeInsetsDirectional.all(12.r),
                                decoration: BoxDecoration(
                                    color: isUserMessage
                                        ? Theme.of(context).primaryColor
                                        : const Color(0xffF4F4F4),
                                    borderRadius:
                                    BorderRadiusDirectional.only(
                                      bottomStart: Radius.circular(12.r),
                                      topStart: isUserMessage
                                          ? Radius.circular(12.r)
                                          : Radius.zero,
                                      topEnd: Radius.circular(12.r),
                                      bottomEnd: isUserMessage
                                          ? Radius.zero
                                          : Radius.circular(12.r),
                                    )),
                                child: Text(
                                  chatMessages[index].replaceFirst("You: ", "").replaceFirst("AI: ", ""),
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: isUserMessage
                                          ? Colors.white
                                          : null),
                                ),
                              ),
                            ),
                          )
                          // _TextMessage(model: model),
                        ],
                      ),
                    );
                    // return Align(
                    //   alignment: isUserMessage
                    //       ? Alignment.centerRight
                    //       : Alignment.centerLeft,
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(vertical: 4),
                    //     padding: const EdgeInsets.symmetric(
                    //         vertical: 10, horizontal: 14),
                    //     decoration: BoxDecoration(
                    //       color: isUserMessage
                    //           ? Colors.lightBlue[100]
                    //           : Colors.deepPurple[100],
                    //       borderRadius: BorderRadius.circular(20),
                    //     ),
                    //     child: Text(
                    //       chatMessages[index],
                    //       style: TextStyle(
                    //         color: isUserMessage ? Colors.black : Colors.black,
                    //       ),
                    //     ),
                    //   ),
                    // );
                  },
                );
              }),
            ),
            StatefulBuilder(
              builder: (context,setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: _controller,
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
                      )
                          // TextField(
                          //   controller: _controller,
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Colors.grey[200],
                          //     hintText: 'Type your message here...',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(20),
                          //       borderSide: BorderSide.none,
                          //     ),
                          //   ),
                          // ),
                          ),
                      const SizedBox(width: 8),
                      IconButton(
                        iconSize: 20.r,
                        icon: AppImage(
                          "send.svg",
                          height: 24.h,
                          width: 24.h,
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(_controller.text.isEmpty ? .2 : 1),
                        ),
                        onPressed: () async{
                          if (_controller.text.isNotEmpty) {
                           await  ref
                                .read(chatProvider.notifier)
                                .sendMessage(_controller.text);
                            _controller.clear();
                          }
                        },
                      )
                    ],
                  ),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
