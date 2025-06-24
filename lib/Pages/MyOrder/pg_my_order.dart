// import 'package:badminton/Pages/OrderSummary/pg_order_summary.dart';
// import 'package:badminton/app_settings/components/label.dart';
// import 'package:badminton/app_settings/components/widget_global_margin.dart';
// import 'package:badminton/app_settings/constants/app_assets.dart';
// import 'package:badminton/app_settings/constants/app_colors.dart';
// import 'package:badminton/app_settings/constants/app_dim.dart';
//
// import 'package:flutter/material.dart';
//
// class PgMyOrder extends StatefulWidget {
//   const PgMyOrder({super.key});
//
//   @override
//   State<PgMyOrder> createState() => _PgMyOrderState();
// }
//
// class _PgMyOrderState extends State<PgMyOrder> {
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
//                           txt: "My Orders",
//                           type: TextTypes.f_18_600,
//                         ),
//                       ]),
//                       padVertical(20),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: 4,
//                         itemBuilder: (context, index) {
//                           return GestureDetector(
//                               onTap: () {
//                                 // Navigator.push(
//                                 //   context,
//                                 //   MaterialPageRoute(
//                                 //     builder: (context) =>
//                                 //         const PgOrderSummary(),
//                                 //   ),
//                                 // );
//                               },
//                               child: Container(
//                                   margin:
//                                       const EdgeInsets.symmetric(vertical: 5),
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                     color: AppColors.lightGrey,
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Column(
//                                     children: [
//                                       padVertical(10),
//                                       Row(
//                                         children: [
//                                           Container(
//                                             padding: const EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                               boxShadow: const [
//                                                 BoxShadow(
//                                                     color: Colors.black12,
//                                                     blurRadius: 2)
//                                               ],
//                                               color: AppColors.whiteColor,
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                             ),
//                                             child: Image.asset(
//                                               width: 70,
//                                               height: 70,
//                                               AppAssets.rankProfile,
//                                               fit: BoxFit.contain,
//                                             ),
//                                           ),
//                                           padHorizontal(10),
//                                           Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 const Label(
//                                                   txt:
//                                                       "HEAD Radical Elite.....",
//                                                   type: TextTypes.f_18_700,
//                                                   forceColor:
//                                                       AppColors.primaryColor,
//                                                 ),
//                                                 Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         padVertical(5),
//                                                         Row(children: [
//                                                           Image.asset(
//                                                             AppAssets.location,
//                                                             fit: BoxFit.contain,
//                                                             width: 15,
//                                                             height: 15,
//                                                           ),
//                                                           padHorizontal(5),
//                                                           const Label(
//                                                             txt:
//                                                                 "Kemmer Trafficway, West Zenatown,",
//                                                             type: TextTypes
//                                                                 .f_10_400,
//                                                             forceColor:
//                                                                 AppColors
//                                                                     .smalltxt,
//                                                           )
//                                                         ]),
//                                                         padVertical(10),
//                                                         Row(children: [
//                                                           Image.asset(
//                                                             AppAssets.calender2,
//                                                             fit: BoxFit.contain,
//                                                             width: 15,
//                                                             height: 15,
//                                                             color: AppColors
//                                                                 .primaryColor,
//                                                           ),
//                                                           padHorizontal(5),
//                                                           const Label(
//                                                             txt:
//                                                                 "Nov 10, 2024 | 08:00 A.M.",
//                                                             type: TextTypes
//                                                                 .f_10_400,
//                                                             forceColor:
//                                                                 AppColors
//                                                                     .smalltxt,
//                                                           )
//                                                         ])
//                                                       ],
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ])
//                                         ],
//                                       ),
//                                       padVertical(10),
//                                       const Divider(),
//                                       padVertical(10),
//                                       const Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Label(
//                                               txt: "Total Order (1)   :",
//                                               type: TextTypes.f_12_500,
//                                             ),
//                                             Label(
//                                               txt: '\$ 34.00',
//                                               type: TextTypes.f_12_700,
//                                             ),
//                                           ]),
//                                       padVertical(10),
//                                     ],
//                                   )));
//                         },
//                       )
//                     ])))),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
