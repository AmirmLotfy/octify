import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:octify/core/design/app_button.dart';
import 'package:octify/core/design/app_input.dart';
import 'package:octify/core/logic/helper_methods.dart';
import 'package:octify/views/results.dart';
import 'package:octify/views/select_persona.dart';

import '../core/design/second_app_bar.dart';
import '../core/theme.dart';
import 'tell_about_persona/view.dart';

class ChallengesView extends StatefulWidget {
  final String personaName;
  final PersonaType type;
  final PersonaModelData personaModelData;

  const ChallengesView({
    super.key,
    required this.personaName,
    required this.type,
    required this.personaModelData,
  });

  @override
  State<ChallengesView> createState() => _ChallengesViewState();
}

class _ChallengesViewState extends State<ChallengesView> {
  List<_Category> get list {
    switch (widget.type) {
      case PersonaType.general:
        // todo: need the challenges for general persona
        return [];
      case PersonaType.child:
        return childList;
      case PersonaType.partner:
        return myPartner;
      case PersonaType.parent:
        return myParent;
      case PersonaType.pet:
        return myPet;
      case PersonaType.friend:
        return myFriend;
      case PersonaType.myself:
        return mySelf;
      case PersonaType.colleague:
        return myColleague;
        // todo: change these lists
      case PersonaType.sibling:
        return childList;
      case PersonaType.teenager:
        return childList;
      case PersonaType.baby:
        return childList;
      case PersonaType.neighbor:
        return childList;
      case PersonaType.customer:
        return childList;
      case PersonaType.teacher:
        return childList;
    }
  }

  List<String> selectedList = [];
  final otherChallengesController = TextEditingController();

  final childList = [
    _Category(
      title: "Communication",
      list: [
        "Tantrums",
        "Defiance",
        "Difficulty following rules",
      ],
    ),
    _Category(
      title: "Academic Struggles",
      list: [
        "Difficulty with schoolwork",
        "Lack of motivation",
        "Learning disabilities"
      ],
    ),
    _Category(title: "Social Challenges", list: [
      "Trouble making friends",
      "Bullying",
      "Social anxiety",
    ]),
    _Category(
      title: "Health Concerns",
      list: [
        "Frequent illnesses",
        "Managing chronic conditions",
        "Sleep problems"
      ],
    ),
    _Category(
      title: "Emotional Well-being",
      list: [
        "Anxiety",
        "Depression",
        "Low self-esteem",
      ],
    ),
  ];

  final myPartner = [
    _Category(
      title: "Communication Problems",
      list: [
        "Misunderstandings",
        "Lack of effective communication",
        "Frequent arguments",
      ],
    ),
    _Category(
      title: "Trust Issues",
      list: [
        "Infidelity",
        "Jealousy",
        "Past betrayals affecting trust",
      ],
    ),
    _Category(
      title: "Financial Disagreements",
      list: [
        "Differing views on spending",
        "Saving",
        "Financial priorities",
      ],
    ),
    _Category(
      title: "Intimacy Issues",
      list: ["Lack of physical", "Emotional intimacy"],
    ),
    _Category(
      title: "Life Stage Differences",
      list: [
        "Different goals ",
        "Priorities based on career",
        "Family",
        "Personal growth",
      ],
    ),
  ];

  final myParent = [
    _Category(
      title: "Health Management",
      list: [
        "Chronic illnesses",
        "mobility issues",
        "managing medications",
      ],
    ),
    _Category(
      title: "Communication Difficulties",
      list: [
        "Generational gaps",
        "Memory loss",
        "Hearing problems",
      ],
    ),
    _Category(
      title: "Independence vs. Support",
      list: [
        "Balancing their need for independence with the need for support",
      ],
    ),
    _Category(
      title: "Emotional Well-being",
      list: [
        "Loneliness",
        "Depression",
        "Dealing with loss",
      ],
    ),
    _Category(
      title: "Family Dynamics",
      list: [
        "Sibling disagreements about care or conflicting family roles",
      ],
    ),
  ];

  final myFriend = [
    _Category(
      title: "Maintaining Connection",
      list: [
        "Staying in touch despite busy schedules",
        "Long distances",
      ],
    ),
    _Category(
      title: "Providing Support",
      list: [
        "Offering emotional support during tough times",
      ],
    ),
    _Category(
      title: "Managing Conflicts",
      list: [
        "Resolving disagreements",
        "Misunderstandings",
      ],
    ),
    _Category(
      title: "Balancing Time",
      list: [
        "Finding time to spend together amidst other commitments",
      ],
    ),
    _Category(
      title: "Encouraging Growth",
      list: [
        "Supporting their personal",
        "Professional growth without jealousy",
      ],
    ),
  ];

  final mySelf = [
    _Category(
      title: "Work-Life Balance",
      list: [
        "Managing professional responsibilities ",
        "Personal Life",
      ],
    ),
    _Category(
      title: "Mental Health",
      list: [
        "Dealing with stress",
        "Anxiety",
        "Depression",
      ],
    ),
    _Category(
      title: "Physical Health",
      list: [
        "Maintaining a healthy lifestyle",
        "Managing chronic conditions",
        "Fitness",
      ],
    ),
    _Category(
      title: "Personal Growth",
      list: [
        "Setting and achieving personal goals",
        "Overcoming procrastination",
      ],
    ),
    _Category(
      title: "Social Relationships",
      list: [
        "Building and maintaining meaningful relationships",
      ],
    ),
  ];
  final myPet = [
    _Category(
      title: "Health Issues",
      list: ["Chronic illnesses", "Regular vet visits", "Managing medications"],
    ),
    _Category(
      title: "Behavioral Problems",
      list: [
        "Aggression",
        "Anxiety",
        "Destructive behavior",
      ],
    ),
    _Category(
      title: "Training Challenges",
      list: [
        "House training",
        "Obedience",
        "Specific skill training",
      ],
    ),
    _Category(
      title: "Diet and Nutrition",
      list: [
        "Ensuring a balanced diet",
        "Managing allergies",
        "Weight issues",
      ],
    ),
    _Category(
      title: "Exercise Needs",
      list: [
        "Providing enough physical activity and mental stimulation",
      ],
    ),
  ];

  final myColleague = [
    _Category(
      title: "Communication Barriers",
      list: [
        "Misunderstandings",
        "lack of clarity",
        "differing communication styles",
      ],
    ),
    _Category(
      title: "Collaboration Issues",
      list: [
        "Difficulty working together on projects",
        "differing work styles"
      ],
    ),
    _Category(
      title: "Conflict Resolution",
      list: [
        "Handling disagreements",
        "Conflicts professionally",
      ],
    ),
    _Category(
      title: "Workload Management",
      list: [
        "Balancing tasks and responsibilities",
        "avoiding burnout",
      ],
    ),
    _Category(
      title: "Professional Development",
      list: [
        "Supporting each other’s career growth and development.",
      ],
    ),
  ];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SecondAppBar(text: "Challenges"),
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  height: 2.5.h,
                  fontFamily: AppTheme.fontFamily2,
                ),
                children: [
                  const TextSpan(text: "1. What challenges are you\n"),
                  TextSpan(
                      text: "facing with ${widget.personaName}?",
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    list.length,
                    (i) => Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            list[i].title,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8.h),
                          Wrap(
                            alignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            spacing: 16.w,
                            runSpacing: 16.h,
                            children: List.generate(
                              list[i].list.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  if (selectedList
                                      .contains(list[i].list[index])) {
                                    selectedList.remove(list[i].list[index]);
                                  } else {
                                    selectedList.add(list[i].list[index]);
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 27.w,
                                    vertical: 8.h,
                                  ),
                                  decoration: BoxDecoration(
                                      color: selectedList
                                              .contains(list[i].list[index])
                                          ? Theme.of(context).primaryColor
                                          : null,
                                      border: !selectedList
                                              .contains(list[i].list[index])
                                          ? Border.all(
                                              color: Theme.of(context)
                                                  .dividerColor,
                                            )
                                          : null,
                                      borderRadius: BorderRadius.circular(8.r)),
                                  child: Text(
                                    list[i].list[index],
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: selectedList
                                              .contains(list[i].list[index])
                                          ? Colors.white
                                          : const Color(0xff8c8c8c),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            AppInput(
              controller: otherChallengesController,
              label: "Other Challenges",
              hint: "Enter Other Challenges",
            )
          ],
        ),
      ),
      bottomNavigationBar: AppButton(
        text: "Analyze",
        isLoading: isLoading,
        type: ButtonType.bottomNav,
        onPress: () async {
          if (otherChallengesController.text.isNotEmpty) {
            selectedList.add(otherChallengesController.text);
          }
          navigateTo(ResultsView(
            title: widget.personaName,
            personaType: widget.type,
            challengesList: selectedList,
            personaModelData: widget.personaModelData,
          ));
        },
      ),
    );
  }
}

class _Category {
  final String title;
  final List<String> list;

  _Category({required this.title, required this.list});
}
