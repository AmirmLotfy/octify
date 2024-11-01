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
      case PersonaType.sibling:
        return sibling;
      case PersonaType.teenager:
        return teenager;
      case PersonaType.baby:
        return baby;
      case PersonaType.neighbor:
        return neighbor;
      case PersonaType.customer:
        return customer;
      case PersonaType.teacher:
        return teacher;
    }
  }

  List<String> selectedList = [];
  final otherChallengesController = TextEditingController();

  final childList = [
    _Category(
      title: "Communication",
      list: [
        "Expressing Feelings",
        "Understanding Instructions",
        "Developing Social Skills",
      ],
    ),
    _Category(
      title: "Learning",
      list: ["Attention Span", "Learning Differences", "Motivation"],
    ),
    _Category(title: "Behavior", list: [
      "Temper Tantrums",
      "Rule Following",
      "Impulse Control",
    ]),
  ];

  final myParent = [
    _Category(
      title: "Communication Issues",
      list: [
        "Misunderstandings",
        "Generational Gap",
        "Expressing Emotions",
      ],
    ),
    _Category(
      title: "Boundaries and Independence",
      list: [
        "Overprotection",
        "Setting Boundaries",
        "Expectations vs. Reality",
      ],
    ),
    _Category(
      title: "Decision-Making Conflicts",
      list: [
        "Life Choices",
        "Financial Decisions",
        "Living Arrangements",
      ],
    ),
    _Category(
      title: "Health and Well-being",
      list: [
        "Aging Parents",
        "Mental Health",
        "Lifestyle Differences",
      ],
    ),
    _Category(
      title: "Cultural Differences",
      list: [
        "Tradition vs. Modernity",
        "Cultural Expectations",
      ],
    ),
    _Category(
      title: "Support and Caregiving",
      list: [
        "Caregiving Strain",
        "Reciprocity",
        "Guilt and Obligation",
      ],
    ),
  ];

  final myPartner = [
    _Category(
      title: "Communication",
      list: [
        "Active Listening",
        "Conflict Resolution",
        "Emotional Transparency",
      ],
    ),
    _Category(
      title: "Relationship Growth",
      list: [
        "Maintaining Romance",
        "Shared Goals",
        "Navigating Life Changes",
      ],
    ),
    _Category(
      title: "Trust & Loyalty",
      list: [
        "Rebuilding Trust",
        "Maintaining Fidelity",
        "Jealousy Management",
      ],
    ),
  ];

  final myColleague = [
    _Category(
      title: "Workplace Communication",
      list: [
        "Email/Message Clarity",
        "Feedback Sensitivity",
        "Remote Work Coordination",
      ],
    ),
    _Category(
      title: "Team Dynamics",
      list: [
        "Role Clarity",
        "Conflict Management",
        "Collaborative Effort",
      ],
    ),
    _Category(
      title: "Professional Growth",
      list: [
        "Career Progression",
        "Skill Development",
        "Work-Life Integration",
      ],
    ),

  ];

  final myPet = [
    _Category(
      title: "Health & Wellness",
      list: [
        "Dietary Needs",
        "Exercise Requirements",
        "Veterinary Care",
      ],
    ),
    _Category(
      title: "Behavior",
      list: [
        "Training Consistency",
        "Separation Anxiety",
        "Socialization",
      ],
    ),
    _Category(
      title: "Bonding",
      list: [
        "Building Trust",
        "Interactive Play",
        "Understanding Needs",
      ],
    ),
  ];


  final myFriend = [
    _Category(
      title: "Communication",
      list: [
        "Staying in Touch",
        "Handling Misunderstandings",
        "Balancing Openness",
      ],
    ),
    _Category(
      title: "Support",
      list: [
        "Being Present",
        "Setting Boundaries",
        "Avoiding Codependency",
      ],
    ),
    _Category(
      title: "Friendship Growth",
      list: [
        "Nurturing the Bond",
        "Managing Group Dynamics",
        "Handling Life Changes",
      ],
    ),

  ];

  final mySelf = [
    _Category(
      title: "Self-Improvement",
      list: [
        "Goal Setting",
        "Time Management",
        "Overcoming Procrastination",
      ],
    ),
    _Category(
      title: "Emotional Well-being",
      list: [
        "Stress Management",
        "Mindfulness",
        "Self-Esteem",
      ],
    ),
    _Category(
      title: "Work-Life Balance",
      list: [
        "Avoiding Burnout",
        "Pursuing Hobbies",
        "Maintaining Health",
      ],
    ),
  ];

  final sibling = [
    _Category(
      title: "Sibling Rivalry",
      list: [
        "Jealousy",
        "Competing for Attention",
        "Differences in Treatment",
      ],
    ),
    _Category(
      title: "Communication",
      list: [
        "Differences in Treatment",
        "Conflict Resolution",
        "Understanding Perspectives",
      ],
    ),
    _Category(
      title: "Bonding",
      list: [
        "Shared Interests",
        "Support System",
        "Strengthening the Relationship",
      ],
    ),
  ];

  final teenager = [
    _Category(
      title: "Identity Development",
      list: [
        "Self-Exploration",
        "Peer Pressure",
        "Cultural Expectations",
      ],
    ),
    _Category(
      title: "Independence",
      list: [
        "Autonomy",
        "Decision Making",
        "Financial Responsibility",
      ],
    ),
    _Category(
      title: "Emotional Health",
      list: [
        "Mood Swings",
        "Stress Management",
        "Building Resilience",
      ],
    ),
  ];

  final baby = [
    _Category(
      title: "Health & Nutrition",
      list: [
        "Feeding difficulties",
        "Sleep schedule",
        "Immunizations",
      ],
    ),
    _Category(
      title: "Developmental Milestones",
      list: [
        "Crawling",
        "Walking",
        "First words",
      ],
    ),
    _Category(
      title: "Comfort & Care",
      list: [
        "Soothing during crying",
        "Bathing routines",
        "Diaper changes",
      ],
    ),
  ];

  final neighbor = [
    _Category(
      title: "Building Relationships",
      list: [
        "Introducing oneself",
        "Maintaining friendly interactions",
        "Addressing conflicts",
      ],
    ),
    _Category(
      title: "Community Involvement",
      list: [
        "Participating in neighborhood events",
        "Collaborating on community projects",
        "Staying informed about local issues",
      ],
    ),
    _Category(
      title: "Safety & Security",
      list: [
        "Keeping the neighborhood safe",
        "Reporting suspicious activities",
        "Supporting neighborhood watch programs",
      ],
    ),
  ];

  final customer = [
    _Category(
      title: "Communication",
      list: [
        "Responding to inquiries",
        "Providing clear information",
        "Handling complaints",
      ],
    ),
    _Category(
      title: "Customer Satisfaction",
      list: [
        "Meeting customer expectations",
        "Offering personalized service",
        "Ensuring product quality",
      ],
    ),
    _Category(
      title: "Loyalty & Retention",
      list: [
        "Encouraging repeat purchases",
        "Building brand loyalty",
        "Managing feedback and reviews",
      ],
    ),
  ];
  final teacher = [
    _Category(
      title: "Understanding Communication",
      list: [
        "Misunderstanding instructions",
        "Difficulty expressing concerns",
        "Unclear feedback",
      ],
    ),
    _Category(
      title: "Navigating Academic Expectations",
      list: [
        "High academic demands",
        "Supporting assignments",
        "Balancing expectations",
      ],
    ),
    _Category(
      title: "Building a Collaborative Relationship",
      list: [
        "Establishing rapport",
        "Unresponsive teacher",
        "Advocacy balance",
      ],
    ),
    _Category(
      title: "Addressing Behavioral Concerns",
      list: [
        "Disciplinary disagreements",
        "Behavior expectations",
        "Managing actions",
      ],
    ),
    _Category(
      title: "Dealing with Overwhelm",
      list: [
        "Excessive demands",
        "Frequent communications",
        "Instructional pressure",
      ],
    ),
    _Category(
      title: "Understanding Educational Changes",
      list: [
        "Adapting to new methods",
        "Curriculum confusion",
        "Technology expectations",
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
