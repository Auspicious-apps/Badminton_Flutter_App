import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';

class PgPreTournamentDet extends StatefulWidget {
  const PgPreTournamentDet({super.key});

  @override
  State<PgPreTournamentDet> createState() => _PgPreTournamentDetState();
}

class _PgPreTournamentDetState extends State<PgPreTournamentDet> {
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
                              txt: "Winning Team",
                              type: TextTypes.f_14_700,
                            ),
                            padVertical(5),
                            const Divider(),
                            padVertical(3),
                            Row(children: [
                              ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(15)),
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
                                      txt: "Matches",
                                      type: TextTypes.f_14_700,
                                    ),
                                    Icon(Icons.keyboard_arrow_down_rounded)
                                  ]),
                              padVertical(10),
                              Container(
                                height: 47,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppColors.blue2,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                      txt: "Finals",
                                      type: TextTypes.f_14_600,
                                      forceColor: AppColors.whiteColor,
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.whiteColor,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.background,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 58,
                                                    height: 60,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                ShapeDecoration(
                                                              shape: OvalBorder(
                                                                side:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 10,
                                                          top: 40.52,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        2),
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: AppColors
                                                                  .blue2,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Label(
                                                                txt: '2.1',
                                                                type: TextTypes
                                                                    .f_10_400,
                                                                forceColor:
                                                                    AppColors
                                                                        .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  padVertical(3),
                                                  Label(
                                                    txt: 'Maria',
                                                    type: TextTypes.f_10_400,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 58,
                                                    height: 60,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                ShapeDecoration(
                                                              shape: OvalBorder(
                                                                side:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 10,
                                                          top: 40.52,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        2),
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: AppColors
                                                                  .blue2,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Label(
                                                                txt: '2.1',
                                                                type: TextTypes
                                                                    .f_10_400,
                                                                forceColor:
                                                                    AppColors
                                                                        .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  padVertical(3),
                                                  Label(
                                                    txt: 'Maria',
                                                    type: TextTypes.f_10_400,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: AppColors.border)),
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 58,
                                                    height: 60,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                ShapeDecoration(
                                                              shape: OvalBorder(
                                                                side:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 10,
                                                          top: 40.52,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        2),
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: AppColors
                                                                  .blue2,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Label(
                                                                txt: '2.1',
                                                                type: TextTypes
                                                                    .f_10_400,
                                                                forceColor:
                                                                    AppColors
                                                                        .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  padVertical(3),
                                                  Label(
                                                    txt: 'Lorem',
                                                    type: TextTypes.f_10_400,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  SizedBox(
                                                    width: 58,
                                                    height: 60,
                                                    child: Stack(
                                                      children: [
                                                        Positioned(
                                                          left: 0,
                                                          top: 0,
                                                          child: Container(
                                                            width: 50,
                                                            height: 50,
                                                            decoration:
                                                                ShapeDecoration(
                                                              shape: OvalBorder(
                                                                side:
                                                                    BorderSide(
                                                                  width: 1,
                                                                  color:
                                                                      AppColors
                                                                          .gold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 10,
                                                          top: 40.52,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10,
                                                                    vertical:
                                                                        2),
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: AppColors
                                                                  .blue2,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: Label(
                                                                txt: '2.1',
                                                                type: TextTypes
                                                                    .f_10_400,
                                                                forceColor:
                                                                    AppColors
                                                                        .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  padVertical(3),
                                                  Label(
                                                    txt: 'Lorem',
                                                    type: TextTypes.f_10_400,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      padVertical(10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AppAssets.calender2,
                                              fit: BoxFit.contain,
                                              width: 15,
                                              height: 15,
                                              color: AppColors.smalltxt,
                                            ),
                                            padHorizontal(5),
                                            const Label(
                                              txt: "Nov 10, 2024 | 08:00 A.M.",
                                              type: TextTypes.f_10_400,
                                              forceColor: AppColors.smalltxt,
                                            )
                                          ]),
                                      padVertical(10),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 244,
                                              height: 46,
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    left: 0,
                                                    top: 23,
                                                    child: Container(
                                                      width: 98,
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 1,
                                                            strokeAlign: BorderSide
                                                                .strokeAlignCenter,
                                                            color: Color(
                                                                0xFFD6D6D6),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 179,
                                                    top: 23,
                                                    child: Container(
                                                      width: 65,
                                                      decoration:
                                                          ShapeDecoration(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          side: BorderSide(
                                                            width: 1,
                                                            strokeAlign: BorderSide
                                                                .strokeAlignCenter,
                                                            color: Color(
                                                                0xFFD6D6D6),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 0,
                                                    top: 1,
                                                    child: Text(
                                                      'Maria ',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF10375C),
                                                        fontSize: 10,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 180,
                                                    top: 0,
                                                    child: Text(
                                                      '3',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5F6A7C),
                                                        fontSize: 12,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 204,
                                                    top: 0,
                                                    child: Text(
                                                      '3',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5F6A7C),
                                                        fontSize: 12,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 228,
                                                    top: 0,
                                                    child: Text(
                                                      '3',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5F6A7C),
                                                        fontSize: 12,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 180,
                                                    top: 32,
                                                    child: Text(
                                                      '2',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5F6A7C),
                                                        fontSize: 12,
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 204,
                                                    top: 32,
                                                    child: Text(
                                                      '2',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5F6A7C),
                                                        fontSize: 12,
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 228,
                                                    top: 32,
                                                    child: Text(
                                                      '2',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5F6A7C),
                                                        fontSize: 12,
                                                        fontFamily: 'Quicksand',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 148,
                                                    top: 16,
                                                    child: Text(
                                                      'Pts',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF5F6A7C),
                                                        fontSize: 10,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 0,
                                                    top: 33,
                                                    child: Text(
                                                      'Lorem Ipsum',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF10375C),
                                                        fontSize: 10,
                                                        fontFamily: 'Raleway',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ])),
                  ]))))
            ],
          )
        ]),
      ),
    );
  }
}
