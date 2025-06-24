import 'package:badminton/Pages/EnrollScreen/pg_enrollscreen.dart';
import 'package:badminton/Pages/PreviousTournamentDetail/pg_pre_tournament_det.dart';
import 'package:badminton/Pages/TournamentDetail/pg_tournament_detail.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';

class PgTournaments extends StatefulWidget {
  const PgTournaments({super.key});

  @override
  State<PgTournaments> createState() => _PgTournamentsState();
}

class _PgTournamentsState extends State<PgTournaments> {
  int selectedButton = 0;

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
                    padVertical(30),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedButton = 0;
                                    });
                                  },
                                  child: Container(
                                      height: 44,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      decoration: BoxDecoration(
                                        color: selectedButton == 0
                                            ? AppColors.primaryColor
                                            : AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Label(
                                          txt: "Upcoming",
                                          type: TextTypes.f_12_500,
                                          forceColor: selectedButton == 0
                                              ? AppColors.whiteColor
                                              : AppColors.smalltxt,
                                        ),
                                      )))),
                          padHorizontal(20),
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedButton = 1;
                                  });
                                },
                                child: Container(
                                    height: 44,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: selectedButton == 1
                                          ? AppColors.primaryColor
                                          : AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                        child: Label(
                                      txt: "Previous",
                                      type: TextTypes.f_12_500,
                                      forceColor: selectedButton == 1
                                          ? AppColors.whiteColor
                                          : AppColors.smalltxt,
                                    )))),
                          )
                        ]),
                    padVertical(20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.border,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Image.asset(
                                  AppAssets.search,
                                  fit: BoxFit.contain,
                                  width: 20,
                                  height: 20,
                                ),
                                padHorizontal(10),
                                const Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search Tournaments",
                                      hintStyle: TextStyle(
                                          color: AppColors.smalltxt,
                                          fontFamily: AppConst.fontFamily,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13),
                                    ),
                                    style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontFamily: AppConst.fontFamily,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: AppColors.border,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              padHorizontal(8),
                              Image.asset(
                                AppAssets.filter,
                                fit: BoxFit.contain,
                                height: 15,
                                width: 15,
                              ),
                              padHorizontal(8),
                            ],
                          ),
                        ],
                      ),
                    ),
                    padVertical(20),
                    selectedButton == 0
                        ? Column(children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const PgTournamentDetail(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppColors.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: [
                                            padVertical(10),
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: Image.asset(
                                                    AppAssets.rankProfile,
                                                    fit: BoxFit.fill,
                                                    height: 96,
                                                    width: 98,
                                                  ),
                                                ),
                                                padHorizontal(10),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Label(
                                                        txt:
                                                            "Paddle Tournament",
                                                        type:
                                                            TextTypes.f_18_700,
                                                        forceColor: AppColors
                                                            .primaryColor,
                                                      ),
                                                      Row(children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                          child: Image.asset(
                                                            AppAssets
                                                                .rankProfile,
                                                            fit: BoxFit.fill,
                                                            height: 17,
                                                            width: 17,
                                                          ),
                                                        ),
                                                        padHorizontal(5),
                                                        const Label(
                                                          txt:
                                                              "4/12 Players Joined",
                                                          type: TextTypes
                                                              .f_10_400,
                                                          forceColor: AppColors
                                                              .smalltxt,
                                                        )
                                                      ]),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              padVertical(5),
                                                              Row(children: [
                                                                Image.asset(
                                                                  AppAssets
                                                                      .location,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  width: 15,
                                                                  height: 15,
                                                                ),
                                                                padHorizontal(
                                                                    5),
                                                                const Label(
                                                                  txt:
                                                                      "Kemmer Trafficway, West Zenatown,",
                                                                  type: TextTypes
                                                                      .f_10_400,
                                                                  forceColor:
                                                                      AppColors
                                                                          .smalltxt,
                                                                )
                                                              ]),
                                                              padVertical(10),
                                                              Row(children: [
                                                                Image.asset(
                                                                  AppAssets
                                                                      .calender2,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  width: 15,
                                                                  height: 15,
                                                                  color: AppColors
                                                                      .primaryColor,
                                                                ),
                                                                padHorizontal(
                                                                    5),
                                                                const Label(
                                                                  txt:
                                                                      "Nov 10, 2024 | 08:00 A.M.",
                                                                  type: TextTypes
                                                                      .f_10_400,
                                                                  forceColor:
                                                                      AppColors
                                                                          .smalltxt,
                                                                )
                                                              ])
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ])
                                              ],
                                            ),
                                            padVertical(20),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                      child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const PgTournamentDetail(),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                              height: 44,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          15,
                                                                      vertical:
                                                                          10),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .whiteColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Label(
                                                                  txt:
                                                                      "View Details",
                                                                  type: TextTypes
                                                                      .f_12_500,
                                                                  forceColor:
                                                                      AppColors
                                                                          .grey,
                                                                ),
                                                              )))),
                                                  padHorizontal(20),
                                                  Expanded(
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const PgEnrollscreen(),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                            height: 44,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .blue2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                            ),
                                                            child: const Center(
                                                                child: Label(
                                                              txt: "Enroll Now",
                                                              type: TextTypes
                                                                  .f_12_500,
                                                              forceColor:
                                                                  AppColors
                                                                      .whiteColor,
                                                            )))),
                                                  )
                                                ]),
                                            padVertical(10),
                                          ],
                                        )));
                              },
                            )
                          ])
                        : Column(children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.lightGrey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        padVertical(10),
                                        Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Image.asset(
                                                AppAssets.rankProfile,
                                                fit: BoxFit.fill,
                                                height: 96,
                                                width: 98,
                                              ),
                                            ),
                                            padHorizontal(10),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Label(
                                                    txt: "Paddle Tournament",
                                                    type: TextTypes.f_18_700,
                                                    forceColor:
                                                        AppColors.primaryColor,
                                                  ),
                                                  Row(children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                      child: Image.asset(
                                                        AppAssets.rankProfile,
                                                        fit: BoxFit.fill,
                                                        height: 17,
                                                        width: 17,
                                                      ),
                                                    ),
                                                    padHorizontal(5),
                                                    const Label(
                                                      txt:
                                                          "4/12 Players Joined",
                                                      type: TextTypes.f_10_400,
                                                      forceColor:
                                                          AppColors.smalltxt,
                                                    )
                                                  ]),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          padVertical(5),
                                                          Row(children: [
                                                            Image.asset(
                                                              AppAssets
                                                                  .location,
                                                              fit: BoxFit
                                                                  .contain,
                                                              width: 15,
                                                              height: 15,
                                                            ),
                                                            padHorizontal(5),
                                                            const Label(
                                                              txt:
                                                                  "Kemmer Trafficway, West Zenatown,",
                                                              type: TextTypes
                                                                  .f_10_400,
                                                              forceColor:
                                                                  AppColors
                                                                      .smalltxt,
                                                            )
                                                          ]),
                                                          padVertical(10),
                                                          Row(children: [
                                                            Image.asset(
                                                              AppAssets
                                                                  .calender2,
                                                              fit: BoxFit
                                                                  .contain,
                                                              width: 15,
                                                              height: 15,
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                            padHorizontal(5),
                                                            const Label(
                                                              txt:
                                                                  "Nov 10, 2024 | 08:00 A.M.",
                                                              type: TextTypes
                                                                  .f_10_400,
                                                              forceColor:
                                                                  AppColors
                                                                      .smalltxt,
                                                            )
                                                          ])
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ])
                                          ],
                                        ),
                                        padVertical(20),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PgPreTournamentDet(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                                height: 44,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: AppColors.whiteColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Center(
                                                  child: Label(
                                                    txt: "View Details",
                                                    type: TextTypes.f_12_500,
                                                    forceColor: AppColors.grey,
                                                  ),
                                                ))),
                                        padHorizontal(20),
                                        padVertical(10),
                                      ],
                                    ));
                              },
                            )
                          ]),
                  ]))))
            ],
          )
        ]),
      ),
    );
  }
}
