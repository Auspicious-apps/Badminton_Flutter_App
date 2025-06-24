// import 'package:badminton/app_settings/components/label.dart';
// import 'package:badminton/app_settings/components/widget_global_margin.dart';
// import 'package:badminton/app_settings/constants/app_assets.dart';
// import 'package:badminton/app_settings/constants/app_colors.dart';
// import 'package:badminton/app_settings/constants/app_dim.dart';
// import 'package:flutter/material.dart';
//
// class PgPlayCoins extends StatefulWidget {
//   const PgPlayCoins({super.key});
//
//   @override
//   State<PgPlayCoins> createState() => _PgPlayCoinsState();
// }
//
// class _PgPlayCoinsState extends State<PgPlayCoins> {
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
//                           txt: "Play Coins",
//                           type: TextTypes.f_18_600,
//                         ),
//                       ]),
//                       Stack(
//                         children: [
//                           Image.asset(
//                             AppAssets.coinsbanner,
//                             fit: BoxFit.contain,
//                             height: 200,
//                             width: double.infinity,
//                           ),
//                           Positioned(
//                             top: 40,
//                             left: 20,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Label(
//                                   txt: "Total play coins",
//                                   type: TextTypes.f_14_400,
//                                   forceColor: AppColors.whiteColor,
//                                 ),
//                                 padVertical(5),
//                                 Label(
//                                   txt: "₹2000",
//                                   type: TextTypes.f_30_700,
//                                   forceColor: AppColors.whiteColor,
//                                 ),
//                                 padVertical(25),
//                                 Text(
//                                   "200 matches played",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const Label(
//                         txt: "Transaction History",
//                         type: TextTypes.f_18_600,
//                       ),
//                       padVertical(10),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: 4,
//                         itemBuilder: (context, index) {
//                           return Container(
//                               margin: const EdgeInsets.symmetric(vertical: 5),
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     width: 1, color: AppColors.border),
//                                 color: AppColors.whiteColor,
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(children: [
//                                     padHorizontal(10),
//                                     const Label(
//                                       txt: "Added to wallet",
//                                       type: TextTypes.f_14_400,
//                                       forceColor: AppColors.primaryColor,
//                                     ),
//                                   ]),
//                                   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       const Label(
//                                         txt: "+₹2000",
//                                         type: TextTypes.f_14_600,
//                                         forceColor: AppColors.green2,
//                                       ),
//                                       padVertical(5),
//                                       const Label(
//                                         txt: "23 July 2024",
//                                         type: TextTypes.f_10_600,
//                                         forceColor: AppColors.grey,
//                                       ),
//                                       padVertical(5),
//                                     ],
//                                   )
//                                 ],
//                               ));
//                         },
//                       ),
//                       padVertical(10),
//                     ])))),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
