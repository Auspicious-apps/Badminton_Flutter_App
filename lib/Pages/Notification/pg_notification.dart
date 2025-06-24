// import 'package:badminton/app_settings/components/label.dart';
// import 'package:badminton/app_settings/constants/app_assets.dart';
// import 'package:badminton/app_settings/constants/app_colors.dart';
// import 'package:badminton/app_settings/constants/app_dim.dart';
// import 'package:flutter/material.dart';
//
// class PgNotification extends StatefulWidget {
//   const PgNotification({super.key});
//
//   @override
//   State<PgNotification> createState() => _PgNotificationState();
// }
//
// class _PgNotificationState extends State<PgNotification> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
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
//                     child:
//                         // WidgetGlobalMargin(
//                         //     child:
//                         SingleChildScrollView(
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                       padVertical(10),
//                       Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: GestureDetector(
//                               onTap: () => {Navigator.pop(context)},
//                               child: Container(
//                                 width: 38,
//                                 height: 29,
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.primaryColor,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Image.asset(
//                                   AppAssets.backbtn,
//                                   fit: BoxFit.contain,
//                                   height: 9,
//                                   width: 12,
//                                   color: AppColors.whiteColor,
//                                 ),
//                               ))),
//                       padVertical(20),
//                       Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Label(
//                                   txt: "Notifications",
//                                   type: TextTypes.f_20_600),
//                               Row(children: [
//                                 Image.asset(
//                                   AppAssets.read,
//                                   fit: BoxFit.contain,
//                                   width: 14,
//                                   height: 7,
//                                 ),
//                                 padHorizontal(5),
//                                 const Label(
//                                   txt: "Mark All As Read",
//                                   type: TextTypes.f_12_700,
//                                   forceColor: AppColors.blue,
//                                 )
//                               ])
//                             ],
//                           )),
//                       Divider(),
//                       padVertical(8),
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: 4,
//                         itemBuilder: (context, index) {
//                           return Container(
//                               decoration: const BoxDecoration(),
//                               child: Column(children: [
//                                 Padding(
//                                     padding:
//                                         EdgeInsets.symmetric(horizontal: 15),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Row(children: [
//                                           ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(30),
//                                               child: Image.asset(
//                                                 AppAssets.racket,
//                                                 fit: BoxFit.contain,
//                                                 width: 50,
//                                                 height: 50,
//                                               )),
//                                           padHorizontal(8),
//                                           Row(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 const Label(
//                                                     txt: "Joseph Quinn",
//                                                     type: TextTypes.f_14_700),
//                                                 padHorizontal(5),
//                                                 const Label(
//                                                   txt: "has joined the match.",
//                                                   type: TextTypes.f_10_400,
//                                                   forceColor:
//                                                       AppColors.smalltxt,
//                                                 )
//                                               ])
//                                         ]),
//                                       ],
//                                     )),
//                                 padVertical(8),
//                                 const Divider(),
//                                 padVertical(8),
//                               ]));
//                         },
//                       ),
//                     ])))
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
