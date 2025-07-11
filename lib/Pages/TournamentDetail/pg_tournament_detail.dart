import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:flutter/material.dart';

class PgTournamentDetail extends StatefulWidget {
  const PgTournamentDetail({super.key});

  @override
  State<PgTournamentDetail> createState() => _PgTournamentDetailState();
}

class _PgTournamentDetailState extends State<PgTournamentDetail> {
  int selectedButton = 0;
  int selectedButton2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: WidgetGlobalMargin(
                      child: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                    padVertical(20),
                    Row(children: [
                      GestureDetector(
                          onTap: () => {Navigator.pop(context)},
                          child: Container(
                            width: 38,
                            height: 29,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              AppAssets.backbtn,
                              fit: BoxFit.contain,
                              height: 9,
                              width: 12,
                              color: AppColors.whiteColor,
                            ),
                          )),
                      padHorizontal(10),
                      const Label(
                        txt: "Tournaments",
                        type: TextTypes.f_18_600,
                      ),
                    ]),
                    padVertical(20),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            padVertical(10),
                            const Label(
                              txt: "Tournament Details",
                              type: TextTypes.f_14_700,
                            ),
                            padVertical(10),
                            const Divider(),
                            padVertical(10),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              child: Image.asset(
                                AppAssets.rankProfile,
                                fit: BoxFit.cover,
                                height: 112,
                                width: double.infinity,
                              ),
                            ),
                            padVertical(10),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                    txt: "Paddle Tournament",
                                    type: TextTypes.f_18_600,
                                  ),
                                  Label(
                                    txt: "₹800",
                                    type: TextTypes.f_18_600,
                                  ),
                                ]),
                            const Label(
                                txt: "Sector 24, Chandigarh",
                                type: TextTypes.f_14_700),
                            padVertical(10),
                            Row(children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.date,
                                    fit: BoxFit.contain,
                                    height: 15,
                                    width: 15,
                                  ),
                                  padHorizontal(10),
                                  const Label(
                                    txt: '17 Dec 2024',
                                    type: TextTypes.f_12_500,
                                    forceColor: AppColors.grey,
                                  ),
                                ],
                              ),
                              padHorizontal(30),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.time,
                                    fit: BoxFit.contain,
                                    height: 15,
                                    width: 15,
                                  ),
                                  padHorizontal(10),
                                  const Label(
                                    txt: '09:00 AM',
                                    type: TextTypes.f_12_500,
                                    forceColor: AppColors.grey,
                                  ),
                                ],
                              ),
                            ]),
                            padVertical(5),
                            Row(children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.format,
                                    fit: BoxFit.contain,
                                    height: 15,
                                    width: 15,
                                  ),
                                  padHorizontal(10),
                                  const Row(children: [
                                    Label(
                                      txt: 'Format :',
                                      type: TextTypes.f_12_500,
                                      forceColor: AppColors.grey,
                                    ),
                                    Label(
                                      txt: ' Knockout',
                                      type: TextTypes.f_12_500,
                                    ),
                                  ])
                                ],
                              ),
                              padHorizontal(30),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    AppAssets.team,
                                    fit: BoxFit.contain,
                                    height: 15,
                                    width: 15,
                                  ),
                                  padHorizontal(10),
                                  const Row(children: [
                                    Label(
                                      txt: 'No of teams :',
                                      type: TextTypes.f_12_500,
                                      forceColor: AppColors.grey,
                                    ),
                                    Label(
                                      txt: ' 16',
                                      type: TextTypes.f_12_500,
                                    ),
                                  ])
                                ],
                              ),
                            ]),
                            padVertical(5),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.prize,
                                  fit: BoxFit.contain,
                                  height: 15,
                                  width: 15,
                                ),
                                padHorizontal(10),
                                const Row(children: [
                                  Label(
                                    txt: 'Prize: ',
                                    type: TextTypes.f_12_500,
                                    forceColor: AppColors.grey,
                                  ),
                                  Label(
                                    txt: 'Unknown',
                                    type: TextTypes.f_12_500,
                                  ),
                                ])
                              ],
                            ),
                            padVertical(5),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.date,
                                  fit: BoxFit.contain,
                                  height: 15,
                                  width: 15,
                                ),
                                padHorizontal(10),
                                const Row(children: [
                                  Label(
                                    txt: 'Last Registrations Date :',
                                    type: TextTypes.f_12_500,
                                    forceColor: AppColors.grey,
                                  ),
                                  Label(
                                    txt: ' 26 Nov 2024 ',
                                    type: TextTypes.f_12_500,
                                  ),
                                ])
                              ],
                            ),
                          ],
                        )),
                    padVertical(20),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            padVertical(10),
                            const Label(
                              txt: "Schedule",
                              type: TextTypes.f_14_700,
                            ),
                            padVertical(5),
                            const Divider(),
                            padVertical(3),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Label(
                                          txt: "Day 1 ",
                                          type: TextTypes.f_12_700),
                                      Label(
                                          txt: "(17 Dec)",
                                          type: TextTypes.f_10_600)
                                    ],
                                  ),
                                  Label(
                                    txt: "8 AM - 12 PM , 6 PM - 9 PM",
                                    type: TextTypes.f_12_700,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ]),
                            padVertical(5),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Label(
                                          txt: "Day 1 ",
                                          type: TextTypes.f_12_700),
                                      Label(
                                          txt: "(17 Dec)",
                                          type: TextTypes.f_10_600)
                                    ],
                                  ),
                                  Label(
                                    txt: "8 AM - 12 PM , 6 PM - 9 PM",
                                    type: TextTypes.f_12_700,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ]),
                            padVertical(5),
                            const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Label(
                                          txt: "Day 1 ",
                                          type: TextTypes.f_12_700),
                                      Label(
                                          txt: "(17 Dec)",
                                          type: TextTypes.f_10_600)
                                    ],
                                  ),
                                  Label(
                                    txt: "8 AM - 12 PM , 6 PM - 9 PM",
                                    type: TextTypes.f_12_700,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ])
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padVertical(10),
                              const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                      txt: "Teams Joined",
                                      type: TextTypes.f_14_700,
                                    ),
                                    Label(
                                      txt: "3/16",
                                      type: TextTypes.f_14_700,
                                    ),
                                  ]),
                              padVertical(5),
                              const Divider(),
                              padVertical(5),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.asset(
                                          AppAssets.rankProfile,
                                          fit: BoxFit.fill,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                      padHorizontal(15),
                                      const Label(
                                          txt: "Rebecca & Steven",
                                          type: TextTypes.f_12_700)
                                    ]),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.blue2,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.chat_bubble_outline,
                                        size: 18,
                                        color: AppColors.whiteColor,
                                      ),
                                    )
                                  ]),
                              padVertical(3),
                              Divider(),
                              padVertical(5),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.asset(
                                          AppAssets.rankProfile,
                                          fit: BoxFit.fill,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                      padHorizontal(15),
                                      const Label(
                                          txt: "Rebecca & Steven",
                                          type: TextTypes.f_12_700)
                                    ]),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.blue2,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.chat_bubble_outline,
                                        size: 18,
                                        color: AppColors.whiteColor,
                                      ),
                                    )
                                  ]),
                              padVertical(3),
                              Divider(),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.asset(
                                          AppAssets.rankProfile,
                                          fit: BoxFit.fill,
                                          height: 30,
                                          width: 30,
                                        ),
                                      ),
                                      padHorizontal(15),
                                      const Label(
                                          txt: "Rebecca & Steven",
                                          type: TextTypes.f_12_700),
                                    ]),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.blue2,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Icon(
                                        Icons.chat_bubble_outline,
                                        size: 18,
                                        color: AppColors.whiteColor,
                                      ),
                                    )
                                  ]),
                            ])),
                    Container(
                      height: 47,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Label(
                              txt: "Code of conduct", type: TextTypes.f_12_700),
                          Icon(Icons.keyboard_arrow_down_rounded)
                        ],
                      ),
                    ),
                    padVertical(7),
                    SizedBox(
                        width: double.infinity,
                        child: commonButton(
                            context: context,
                            onPressed: () {},
                            txt: "Book Now"))
                  ]))))
            ],
          )
        ]),
      ),
    );
  }
}
