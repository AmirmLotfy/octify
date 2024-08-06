import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_image.dart';
import 'package:octify/core/logic/helper_methods.dart';

import '../../core/design/second_app_bar.dart';

class HelpView extends StatefulWidget {
  const HelpView({super.key});

  @override
  State<HelpView> createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final list = [
    _Model(
        question: "What is Octify?",
        answer:
            "Octify is a personalized guidance app designed to help you understand and interact better with different personas in your life, such as your child, partner, parent, friend, colleague, and even yourself and your pet."),
    _Model(
        question: "How do I create a new persona?",
        answer:
            'To create a new persona, navigate to the "Add Persona" section, select the type of persona you want to add, and fill in the required details.'),
    _Model(
        question: "How do I update my profile information?",
        answer:
            'Go to the "Profile" section in the app settings, where you can update your personal information, contact details, and preferences.'),
    _Model(
        question: "How do I reset my password?",
        answer:
            'Click on the "Forgot Password" link on the login screen, enter your registered email address, and follow the instructions sent to your email to reset your password.'),
    _Model(
        question: "What information does Octify collect?",
        answer:
            "Octify collects personal information such as name, age, gender, health information, and usage data to provide personalized guidance and improve the app's functionality."),
    _Model(
        question: "How is my data protected?",
        answer:
            "We implement advanced security measures to protect your data from unauthorized access, including encryption and secure servers. For more details, please refer to our Data Privacy and Usage Policy."),
    _Model(
        question: "How do I add or update information for a persona?",
        answer:
            """Navigate to the persona's profile, click on "Edit," and update the relevant details such as health conditions, interests, or challenges."""),
    _Model(
        question: "How do I get personalized advice for a persona?",
        answer:
            "After setting up a persona, you will receive tailored advice and insights based on the information provided. You can view this advice on the persona's profile page."),
    _Model(
        question: "The app is not working properly. What should I do?",
        answer:
            "Try restarting the app or your device. If the problem persists, ensure you have the latest version of the app installed. For further assistance, contact our support team at support@octify.ai."),
    _Model(
        question: "I can't log in to my account. What should I do?",
        answer:
            """Verify that you are using the correct email address and password. If you have forgotten your password, use the "Forgot Password" feature. If you still can't log in, contact our support team for help."""),
    _Model(
        question: "How do I contact Octify support?",
        answer:
            "You can reach our support team by emailing support@octify.ai. We are here to assist you with any questions or issues you may have."),
    _Model(
        question: "What are the support hours?",
        answer:
            "Our support team is available from Monday to Friday, 9 AM to 6 PM (local time). We strive to respond to all inquiries within 24 hours."),
    _Model(
        question: "How can I provide feedback or suggestions for the app?",
        answer:
            "We value your feedback! Please send your suggestions or comments to feedback@octify.ai. Your input helps us improve the app."),
    _Model(
        question: "How do I report a bug or issue?",
        answer:
            "If you encounter a bug or issue, please report it by emailing support@octify.ai with a detailed description of the problem. Our team will investigate and address it as soon as possible."),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Help and support"),
      body: ListView.separated(
        padding: EdgeInsets.all(24.r),
        itemBuilder: (context, index) => _Item(
          model: list[index],
        ),
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemCount: list.length,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.r),
          margin: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Theme.of(context).primaryColor.withOpacity(.08)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact Support",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "Our support team is here to help you. You can reach us via:",
                style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff8C8C8C)),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () {
                  openUrl("mailto:support@octify.ai");
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      Text(
                        "Email: ",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(
                          child: Text(
                        "support@octify.ai",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff8c8c8c),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // todo: ask if they need to remove phone
              // GestureDetector(
              //   onTap: () {
              //     openUrl("tel:");
              //   },
              //   child: Container(
              //     color: Colors.transparent,
              //     child: Row(
              //       children: [
              //         Text(
              //           "Phone: ",
              //           style: TextStyle(
              //             fontSize: 12.sp,
              //             fontWeight: FontWeight.w500,
              //           ),
              //         ),
              //         Expanded(
              //             child: Text(
              //           "+1-800-555-1234",
              //           style: TextStyle(
              //             fontSize: 12.sp,
              //             fontWeight: FontWeight.w400,
              //             color: const Color(0xff8c8c8c),
              //           ),
              //         )),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatefulWidget {
  final _Model model;

  const _Item({required this.model});

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ExpansionTile(
        title: Text(widget.model.question,style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500),),
        childrenPadding: EdgeInsets.all(16.r),
        trailing: AppImage(isOpen ? "remove_selected.svg" : "add_selected.svg"),
        onExpansionChanged: (value) {
          isOpen = value;
          setState(() {});
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          // side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.08),
        children: [
          Text(
            widget.model.answer,
            style: TextStyle(
              fontSize: 12.sp,
              color: const Color(0xff8c8c8c),
            ),
          )
        ],
      ),
    );
  }
}

class _Model {
  final String question, answer;

  _Model({required this.question, required this.answer});
}
