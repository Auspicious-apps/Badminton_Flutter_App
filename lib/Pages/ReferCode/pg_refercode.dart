// import 'package:badminton/app_settings/components/label.dart';
// import 'package:badminton/app_settings/components/widget_global_margin.dart';
// import 'package:badminton/app_settings/constants/app_assets.dart';
// import 'package:badminton/app_settings/constants/app_colors.dart';
// import 'package:badminton/app_settings/constants/app_dim.dart';
// import 'package:badminton/app_settings/constants/common_button.dart';
//
// import 'package:flutter/material.dart';
//
// class PgRefercode extends StatefulWidget {
//   const PgRefercode({super.key});
//
//   @override
//   State<PgRefercode> createState() => _PgRefercodeState();
// }
//
// class _PgRefercodeState extends State<PgRefercode> {
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
//                           txt: "Refer To A Friend",
//                           type: TextTypes.f_18_600,
//                         ),
//                       ]),
//                       padVertical(30),
//                       Image.asset(
//                         AppAssets.referall,
//                         fit: BoxFit.contain,
//                         // width: 46,
//                         // height: 46,
//                       ),
//                       padVertical(30),
//                       Row(
//                         children: [
//                           padHorizontal(40),
//                           Container(
//                             width: 27,
//                             height: 27,
//                             decoration: BoxDecoration(
//                               color: AppColors.blue3,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: const Align(
//                               alignment: Alignment.center,
//                               child: Label(
//                                 txt: '1',
//                                 type: TextTypes.f_14_400,
//                                 forceColor: AppColors.whiteColor,
//                               ),
//                             ),
//                           ),
//                           padHorizontal(20),
//                           const Label(
//                             txt: 'Share your referral code',
//                             type: TextTypes.f_12_500,
//                           ),
//                         ],
//                       ),
//                       padVertical(10),
//                       Row(
//                         children: [
//                           padHorizontal(40),
//                           Container(
//                             width: 27,
//                             height: 27,
//                             decoration: BoxDecoration(
//                               color: AppColors.blue3,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: const Align(
//                               alignment: Alignment.center,
//                               child: Label(
//                                 txt: '2',
//                                 type: TextTypes.f_14_400,
//                                 forceColor: AppColors.whiteColor,
//                               ),
//                             ),
//                           ),
//                           padHorizontal(20),
//                           const Label(
//                             txt: 'Your friend creates a new account',
//                             type: TextTypes.f_12_500,
//                           ),
//                         ],
//                       ),
//                       padVertical(10),
//                       Row(
//                         children: [
//                           padHorizontal(40),
//                           Container(
//                             width: 27,
//                             height: 27,
//                             decoration: BoxDecoration(
//                               color: AppColors.blue3,
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             child: const Align(
//                               alignment: Alignment.center,
//                               child: Label(
//                                 txt: '3',
//                                 type: TextTypes.f_14_400,
//                                 forceColor: AppColors.whiteColor,
//                               ),
//                             ),
//                           ),
//                           padHorizontal(20),
//                           const Label(
//                             txt: 'You get 10% off on your next game.',
//                             type: TextTypes.f_12_500,
//                           ),
//                         ],
//                       ),
//                       padVertical(30),
//                       Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                     padding: const EdgeInsets.all(15),
//                                     decoration: BoxDecoration(
//                                       color: AppColors.slidercon,
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: const Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Label(
//                                             txt: "KBSKCBHSCBHSX",
//                                             type: TextTypes.f_12_500),
//                                         Label(
//                                             txt: "copy",
//                                             type: TextTypes.f_12_500)
//                                       ],
//                                     )),
//                                 padVertical(12),
//                                 SizedBox(
//                                     width: double.infinity,
//                                     child: commonButton(
//                                       context: context,
//                                       txt: "Buy It Now",
//                                       onPressed: () {},
//                                     ))
//                               ]))
//                     ])))),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
