// import 'package:badminton/app_settings/components/label.dart';
// import 'package:badminton/app_settings/components/widget_global_margin.dart';
// import 'package:badminton/app_settings/constants/app_assets.dart';
// import 'package:badminton/app_settings/constants/app_colors.dart';
// import 'package:badminton/app_settings/constants/app_dim.dart';
// import 'package:badminton/app_settings/constants/common_button.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_dash/flutter_dash.dart';
//
// class PgPackages extends StatefulWidget {
//   const PgPackages({super.key});
//
//   @override
//   State<PgPackages> createState() => _PgPackagesState();
// }
//
// class _PgPackagesState extends State<PgPackages> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                     child: WidgetGlobalMargin(
//                         child: SingleChildScrollView(
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                       padVertical(20),
//                       Row(children: [
//                         GestureDetector(
//                             onTap: () => {Navigator.pop(context)},
//                             child: Container(
//                               width: 38,
//                               height: 29,
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 color: AppColors.primaryColor,
//                                 borderRadius: BorderRadius.circular(5),
//                               ),
//                               child: Image.asset(
//                                 AppAssets.backbtn,
//                                 fit: BoxFit.contain,
//                                 height: 9,
//                                 width: 12,
//                                 color: AppColors.whiteColor,
//                               ),
//                             )),
//                         padHorizontal(10),
//                         const Label(
//                           txt: "Packages",
//                           type: TextTypes.f_18_600,
//                         ),
//                       ]),
//                       padVertical(20),
//                       Container(
//                           margin: const EdgeInsets.symmetric(vertical: 5),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border:
//                                 Border.all(width: 1, color: AppColors.border),
//                             color: AppColors.whiteColor,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Row(children: [
//                                 Container(
//                                   width: 16,
//                                   height: 16,
//                                   margin:
//                                       const EdgeInsets.symmetric(vertical: 5),
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(
//                                         width: 1, color: AppColors.border),
//                                     color: AppColors.appBackground,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                 ),
//                                 padHorizontal(10),
//                                 const Label(
//                                   txt: "Setup Autopay",
//                                   type: TextTypes.f_14_600,
//                                 ),
//                               ]),
//                               const Icon(
//                                 Icons.payment_rounded,
//                                 color: AppColors.primaryColor,
//                               )
//                             ],
//                           )),
//                       padVertical(10),
//                       Container(
//                           margin: const EdgeInsets.symmetric(vertical: 5),
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border:
//                                 Border.all(width: 1, color: AppColors.border),
//                             color: AppColors.whiteColor,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(children: [
//                                   Container(
//                                     width: 16,
//                                     height: 16,
//                                     margin:
//                                         const EdgeInsets.symmetric(vertical: 5),
//                                     padding: const EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                           width: 1, color: AppColors.border),
//                                       color: AppColors.appBackground,
//                                       borderRadius: BorderRadius.circular(10),
//                                     ),
//                                   ),
//                                   padHorizontal(10),
//                                   const Label(
//                                     txt: "Recharge Once",
//                                     type: TextTypes.f_14_600,
//                                   ),
//                                 ]),
//                                 padVertical(10),
//                                 const Label(
//                                   txt: "₹2000",
//                                   type: TextTypes.f_14_600,
//                                 ),
//                                 const Divider(),
//                                 padVertical(10),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 15, vertical: 10),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.green2,
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: const Column(
//                                         children: [
//                                           Label(
//                                             txt: "₹800",
//                                             type: TextTypes.f_18_600,
//                                             forceColor: AppColors.whiteColor,
//                                           ),
//                                           Label(
//                                             txt: "cashback",
//                                             type: TextTypes.f_10_600,
//                                             forceColor: AppColors.whiteColor,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                         child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 6),
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: AppColors.green2),
//                                               color: AppColors.whiteColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 const Column(
//                                                   children: [
//                                                     Label(
//                                                       txt: "Recharge With",
//                                                       type: TextTypes.f_10_600,
//                                                       forceColor:
//                                                           AppColors.smalltxt,
//                                                     ),
//                                                     Label(
//                                                       txt: "₹8000",
//                                                       type: TextTypes.f_14_600,
//                                                       forceColor:
//                                                           AppColors.smalltxt,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     const Dash(
//                                                       direction: Axis.vertical,
//                                                       length: 50,
//                                                       dashLength: 5,
//                                                       dashThickness: 1,
//                                                       dashColor: Colors.grey,
//                                                     ),
//                                                     padHorizontal(20),
//                                                     Column(
//                                                       children: [
//                                                         const Label(
//                                                           txt: "Avail Now",
//                                                           type: TextTypes
//                                                               .f_10_600,
//                                                           forceColor: AppColors
//                                                               .smalltxt,
//                                                         ),
//                                                         padVertical(10),
//                                                         Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                       10,
//                                                                   vertical: 1),
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: AppColors
//                                                                 .green2,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                           ),
//                                                           child: const Icon(
//                                                             Icons.arrow_forward,
//                                                             size: 18,
//                                                             color: AppColors
//                                                                 .whiteColor,
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                     padHorizontal(20),
//                                                   ],
//                                                 )
//                                               ],
//                                             )))
//                                   ],
//                                 ),
//                                 padVertical(15),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 15, vertical: 10),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.green2,
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: const Column(
//                                         children: [
//                                           Label(
//                                             txt: "₹1500",
//                                             type: TextTypes.f_18_600,
//                                             forceColor: AppColors.whiteColor,
//                                           ),
//                                           Label(
//                                             txt: "cashback",
//                                             type: TextTypes.f_10_600,
//                                             forceColor: AppColors.whiteColor,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                         child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 6),
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: AppColors.green2),
//                                               color: AppColors.whiteColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 const Column(
//                                                   children: [
//                                                     Label(
//                                                       txt: "Recharge With",
//                                                       type: TextTypes.f_10_600,
//                                                       forceColor:
//                                                           AppColors.smalltxt,
//                                                     ),
//                                                     Label(
//                                                       txt: "₹12000",
//                                                       type: TextTypes.f_14_600,
//                                                       forceColor:
//                                                           AppColors.smalltxt,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     const Dash(
//                                                       direction: Axis.vertical,
//                                                       length: 50,
//                                                       dashLength: 5,
//                                                       dashThickness: 1,
//                                                       dashColor: Colors.grey,
//                                                     ),
//                                                     padHorizontal(20),
//                                                     Column(
//                                                       children: [
//                                                         const Label(
//                                                           txt: "Avail Now",
//                                                           type: TextTypes
//                                                               .f_10_600,
//                                                           forceColor: AppColors
//                                                               .smalltxt,
//                                                         ),
//                                                         padVertical(10),
//                                                         Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                       10,
//                                                                   vertical: 1),
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: AppColors
//                                                                 .green2,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                           ),
//                                                           child: const Icon(
//                                                             Icons.arrow_forward,
//                                                             size: 18,
//                                                             color: AppColors
//                                                                 .whiteColor,
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                     padHorizontal(20),
//                                                   ],
//                                                 )
//                                               ],
//                                             )))
//                                   ],
//                                 ),
//                                 padVertical(15),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 15, vertical: 10),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.green2,
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: const Column(
//                                         children: [
//                                           Label(
//                                             txt: "₹1800",
//                                             type: TextTypes.f_18_600,
//                                             forceColor: AppColors.whiteColor,
//                                           ),
//                                           Label(
//                                             txt: "cashback",
//                                             type: TextTypes.f_10_600,
//                                             forceColor: AppColors.whiteColor,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                         child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 6),
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: AppColors.green2),
//                                               color: AppColors.whiteColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 const Column(
//                                                   children: [
//                                                     Label(
//                                                       txt: "Recharge With",
//                                                       type: TextTypes.f_10_600,
//                                                       forceColor:
//                                                           AppColors.smalltxt,
//                                                     ),
//                                                     Label(
//                                                       txt: "₹15000",
//                                                       type: TextTypes.f_14_600,
//                                                       forceColor:
//                                                           AppColors.smalltxt,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     const Dash(
//                                                       direction: Axis.vertical,
//                                                       length: 50,
//                                                       dashLength: 5,
//                                                       dashThickness: 1,
//                                                       dashColor: Colors.grey,
//                                                     ),
//                                                     padHorizontal(20),
//                                                     Column(
//                                                       children: [
//                                                         const Label(
//                                                           txt: "Avail Now",
//                                                           type: TextTypes
//                                                               .f_10_600,
//                                                           forceColor: AppColors
//                                                               .smalltxt,
//                                                         ),
//                                                         padVertical(10),
//                                                         Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                       10,
//                                                                   vertical: 1),
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: AppColors
//                                                                 .green2,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                           ),
//                                                           child: const Icon(
//                                                             Icons.arrow_forward,
//                                                             size: 18,
//                                                             color: AppColors
//                                                                 .whiteColor,
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                     padHorizontal(20),
//                                                   ],
//                                                 )
//                                               ],
//                                             )))
//                                   ],
//                                 ),
//                                 padVertical(15),
//                                 Row(
//                                   children: [
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 15, vertical: 10),
//                                       decoration: BoxDecoration(
//                                         color: AppColors.green2,
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                       child: const Column(
//                                         children: [
//                                           Label(
//                                             txt: "₹1800",
//                                             type: TextTypes.f_18_600,
//                                             forceColor: AppColors.whiteColor,
//                                           ),
//                                           Label(
//                                             txt: "cashback",
//                                             type: TextTypes.f_10_600,
//                                             forceColor: AppColors.whiteColor,
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                     Expanded(
//                                         child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 10, vertical: 6),
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                   width: 1,
//                                                   color: AppColors.green2),
//                                               color: AppColors.whiteColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                             ),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 const Column(
//                                                   children: [
//                                                     Label(
//                                                       txt: "Recharge With",
//                                                       type: TextTypes.f_10_600,
//                                                       forceColor:
//                                                           AppColors.smalltxt,
//                                                     ),
//                                                     Label(
//                                                       txt: "₹15000",
//                                                       type: TextTypes.f_14_600,
//                                                       forceColor:
//                                                           AppColors.smalltxt,
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     const Dash(
//                                                       direction: Axis.vertical,
//                                                       length: 50,
//                                                       dashLength: 5,
//                                                       dashThickness: 1,
//                                                       dashColor: Colors.grey,
//                                                     ),
//                                                     padHorizontal(20),
//                                                     Column(
//                                                       children: [
//                                                         const Label(
//                                                           txt: "Avail Now",
//                                                           type: TextTypes
//                                                               .f_10_600,
//                                                           forceColor: AppColors
//                                                               .smalltxt,
//                                                         ),
//                                                         padVertical(10),
//                                                         Container(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   horizontal:
//                                                                       10,
//                                                                   vertical: 1),
//                                                           decoration:
//                                                               BoxDecoration(
//                                                             color: AppColors
//                                                                 .green2,
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         10),
//                                                           ),
//                                                           child: const Icon(
//                                                             Icons.arrow_forward,
//                                                             size: 18,
//                                                             color: AppColors
//                                                                 .whiteColor,
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                     padHorizontal(20),
//                                                   ],
//                                                 )
//                                               ],
//                                             )))
//                                   ],
//                                 ),
//                                 padVertical(10)
//                               ])),
//                       padVertical(50),
//                       SizedBox(
//                           width: double.infinity,
//                           child: commonButton(
//                             txt: "Pay ₹2000",
//                             context: context,
//                             onPressed: () {},
//                           ))
//                     ])))),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
