import 'package:badminton/Pages/Notification/pg_notification.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';

import 'package:flutter/material.dart';

class PgUploadscore extends StatefulWidget {
  const PgUploadscore({super.key});

  @override
  State<PgUploadscore> createState() => _PgUploadscoreState();
}

class _PgUploadscoreState extends State<PgUploadscore> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.all(15),
                    decoration:
                        const BoxDecoration(color: AppColors.whiteColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.location,
                                fit: BoxFit.contain,
                                width: 25,
                                height: 20,
                              ),
                              padHorizontal(5),
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Label(
                                            txt: "Nearby",
                                            type: TextTypes.f_12_700),
                                        Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: 20,
                                        )
                                      ]),
                                  Label(
                                    txt: "Sector 24, Chandigarh",
                                    type: TextTypes.f_12_500,
                                    forceColor: AppColors.smalltxt,
                                  )
                                ],
                              )
                            ]),
                        Row(children: [
                          Image.asset(
                            AppAssets.chat,
                            fit: BoxFit.contain,
                            width: 40,
                            height: 40,
                          ),
                          padHorizontal(5),
                          // GestureDetector(
                          //     onTap: () => {
                          //           Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //               builder: (context) =>
                          //                   const PgNotification(),
                          //             ),
                          //           )
                          //         },
                          //     child: Image.asset(
                          //       AppAssets.bell,
                          //       fit: BoxFit.contain,
                          //       width: 40,
                          //       height: 40,
                          //     )),
                          padHorizontal(5),
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    width: 2, color: AppColors.primaryColor)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  AppAssets.profile,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ])
                      ],
                    )),
                padVertical(15),
                Expanded(
                    child: WidgetGlobalMargin(
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                      Row(
                        children: [
                          Image.asset(
                            AppAssets.more,
                            fit: BoxFit.contain,
                            width: 25,
                            height: 25,
                            color: AppColors.darkprimary,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    minWidth:
                                        MediaQuery.of(context).size.width),
                                child: Row(
                                  children: [
                                    padHorizontal(8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Row(
                                        children: [
                                          Label(
                                            txt: "Paddle",
                                            type: TextTypes.f_10_400,
                                            forceColor: AppColors.whiteColor,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: AppColors.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    padHorizontal(8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Row(
                                        children: [
                                          Label(
                                            txt: "Club",
                                            type: TextTypes.f_10_400,
                                            forceColor: AppColors.whiteColor,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: AppColors.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    padHorizontal(8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Row(
                                        children: [
                                          Label(
                                            txt: "Mon-Thu",
                                            type: TextTypes.f_10_400,
                                            forceColor: AppColors.whiteColor,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: AppColors.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                                    padHorizontal(8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: const Row(
                                        children: [
                                          Label(
                                            txt: "Distance",
                                            type: TextTypes.f_10_400,
                                            forceColor: AppColors.whiteColor,
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: AppColors.whiteColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      padVertical(20),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Label(
                          txt: "Open Matches",
                          type: TextTypes.f_10_600,
                          forceColor: AppColors.whiteColor,
                        ),
                      ),
                      padVertical(15),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
                                        const Label(
                                          txt: "•  Padel",
                                          type: TextTypes.f_10_600,
                                          forceColor: AppColors.smalltxt,
                                        ),
                                        padHorizontal(8),
                                        const Label(
                                          txt: "•  90min",
                                          type: TextTypes.f_10_600,
                                          forceColor: AppColors.smalltxt,
                                        )
                                      ]),
                                      const Label(
                                        txt: "Friendly Match",
                                        type: TextTypes.f_10_600,
                                        forceColor: AppColors.smalltxt,
                                      ),
                                    ],
                                  ),
                                  padVertical(10),
                                  Row(children: [
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColors.addbtn,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Icon(Icons.add),
                                        ),
                                        const Label(
                                          txt: "Available",
                                          type: TextTypes.f_10_400,
                                          forceColor: AppColors.primaryColor,
                                        )
                                      ],
                                    ),
                                    padHorizontal(10),
                                    Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColors.addbtn,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Icon(Icons.add),
                                        ),
                                        const Label(
                                          txt: "Available",
                                          type: TextTypes.f_10_400,
                                          forceColor: AppColors.primaryColor,
                                        )
                                      ],
                                    )
                                  ]),
                                  padVertical(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          padVertical(5),
                                          Row(children: [
                                            Image.asset(
                                              AppAssets.location,
                                              fit: BoxFit.contain,
                                              width: 15,
                                              height: 15,
                                            ),
                                            padHorizontal(5),
                                            const Label(
                                              txt:
                                                  "Kemmer Trafficway, West Zenatown,",
                                              type: TextTypes.f_10_400,
                                              forceColor: AppColors.smalltxt,
                                            )
                                          ]),
                                          padVertical(10),
                                          Row(children: [
                                            Image.asset(
                                              AppAssets.calender2,
                                              fit: BoxFit.contain,
                                              width: 15,
                                              height: 15,
                                              color: AppColors.primaryColor,
                                            ),
                                            padHorizontal(5),
                                            const Label(
                                              txt: "Nov 10, 2024 | 08:00 A.M.",
                                              type: TextTypes.f_10_400,
                                              forceColor: AppColors.smalltxt,
                                            )
                                          ])
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.blue2,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Label(
                                          txt: "Join Now",
                                          type: TextTypes.f_10_600,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ));
                        },
                      ),
                    ])))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
