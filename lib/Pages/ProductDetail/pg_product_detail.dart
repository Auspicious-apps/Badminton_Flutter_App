// import 'package:badminton/Pages/CartScreen/pg_cart_screen.dart';
// import 'package:badminton/Pages/Merchandise/Widgets/card_list.dart';
// import 'package:badminton/app_settings/components/label.dart';
// import 'package:badminton/app_settings/components/widget_global_margin.dart';
// import 'package:badminton/app_settings/constants/app_assets.dart';
// import 'package:badminton/app_settings/constants/app_colors.dart';
// import 'package:badminton/app_settings/constants/app_dim.dart';
// import 'package:badminton/app_settings/constants/common_button.dart';
// import 'package:flutter/material.dart';
//
// class PgProductDetail extends StatefulWidget {
//   const PgProductDetail({super.key});
//
//   @override
//   State<PgProductDetail> createState() => _PgProductDetailState();
// }
//
// class _PgProductDetailState extends State<PgProductDetail> {
//   int selectedIndex = 0;
//   final List<Map<String, String>> products = [
//     {
//       "name": "HEAD Radical Elite 2024 Padel Racquet",
//       "price": "₹15,749",
//       "oldPrice": "₹20,999",
//       "image": AppAssets.rackettt,
//     },
//     {
//       "name": "HEAD Radical Elite 2024 Padel Racquet",
//       "price": "₹15,749",
//       "oldPrice": "₹20,999",
//       "image": AppAssets.rackettt,
//     },
//     {
//       "name": "HEAD Radical Elite 2024 Padel Racquet",
//       "price": "₹15,749",
//       "oldPrice": "₹20,999",
//       "image": AppAssets.rackettt,
//     },
//     {
//       "name": "HEAD Radical Elite 2024 Padel Racquet",
//       "price": "₹15,749",
//       "oldPrice": "₹20,999",
//       "image": AppAssets.rackettt,
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.background,
//         body: SafeArea(
//             child: WidgetGlobalMargin(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 padVertical(10),
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
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
//                       ]),
//                       Row(children: [
//                         const Icon(
//                           Icons.search,
//                           color: AppColors.smalltxt,
//                         ),
//                         padHorizontal(10),
//                         const Icon(
//                           Icons.shopping_cart,
//                           color: AppColors.smalltxt,
//                         )
//                       ]),
//                     ]),
//                 padVertical(20),
//                 Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       boxShadow: const [
//                         BoxShadow(color: Colors.black12, blurRadius: 2)
//                       ],
//                       color: AppColors.whiteColor,
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Column(children: [
//                       Image.asset(
//                         AppAssets.rackettt,
//                         width: double.infinity,
//                         height: 330,
//                         fit: BoxFit.contain,
//                       ),
//                     ])),
//                 padVertical(20),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: List.generate(6, (index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 12.0),
//                         child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   boxShadow: const [
//                                     BoxShadow(
//                                         color: Colors.black12, blurRadius: 2)
//                                   ],
//                                   color: AppColors.whiteColor,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Image.asset(
//                                   width: 70,
//                                   height: 70,
//                                   AppAssets.rackettt,
//                                   fit: BoxFit.contain,
//                                 ),
//                               )
//                             ]),
//                       );
//                     }),
//                   ),
//                 ),
//                 padVertical(20),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 1.2,
//                   child: const Label(
//                     txt: "HEAD Radical Elite 2024 Padel Racquet",
//                     type: TextTypes.f_20_600,
//                   ),
//                 ),
//                 padVertical(5),
//                 const Label(
//                   txt:
//                       "Each paddle match consists of best-of-three sets, following standard tennis scoring rules with tie-breakers at 6-6.",
//                   type: TextTypes.f_12_400,
//                   forceColor: AppColors.grey,
//                 ),
//                 padVertical(20),
//                 Row(
//                   children: [
//                     Expanded(
//                         child: commonButton(
//                             context: context,
//                             onPressed: () {},
//                             txt: "Buy It Now")),
//                     padHorizontal(10),
//                     GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const PgCartScreen(),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           height: 56,
//                           padding: const EdgeInsets.all(15),
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: const Icon(
//                             Icons.shopping_cart,
//                             color: AppColors.whiteColor,
//                           ),
//                         ))
//                   ],
//                 ),
//                 padVertical(20),
//                 Container(
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     boxShadow: const [
//                       BoxShadow(color: Colors.black12, blurRadius: 2)
//                     ],
//                     color: AppColors.whiteColor,
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedIndex = 0;
//                                 });
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 10),
//                                 decoration: BoxDecoration(
//                                   color: selectedIndex == 0
//                                       ? AppColors.blue2
//                                       : AppColors.whiteColor,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Label(
//                                   txt: "Details",
//                                   type: TextTypes.f_12_700,
//                                   forceColor: selectedIndex == 0
//                                       ? AppColors.whiteColor
//                                       : AppColors.smalltxt,
//                                 ),
//                               )),
//                           GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedIndex = 1;
//                                 });
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 10),
//                                 decoration: BoxDecoration(
//                                   color: selectedIndex == 1
//                                       ? AppColors.blue2
//                                       : AppColors.whiteColor,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Label(
//                                   txt: "Specifications",
//                                   type: TextTypes.f_12_700,
//                                   forceColor: selectedIndex == 1
//                                       ? AppColors.whiteColor
//                                       : AppColors.smalltxt,
//                                 ),
//                               )),
//                           GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   selectedIndex = 2;
//                                 });
//                               },
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 15, vertical: 10),
//                                 decoration: BoxDecoration(
//                                   color: selectedIndex == 2
//                                       ? AppColors.blue2
//                                       : AppColors.whiteColor,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Label(
//                                   txt: "Reviews",
//                                   type: TextTypes.f_12_700,
//                                   forceColor: selectedIndex == 2
//                                       ? AppColors.whiteColor
//                                       : AppColors.smalltxt,
//                                 ),
//                               )),
//                         ],
//                       ),
//                       padVertical(10),
//                       const Label(
//                         txt: "HEAD Radical Elite 2024 Padel Racquet",
//                         type: TextTypes.f_14_600,
//                       ),
//                       padVertical(5),
//                       const Label(
//                         txt: "Description",
//                         type: TextTypes.f_12_700,
//                       ),
//                       padVertical(10),
//                       const Label(
//                         txt:
//                             "The Head Zephyr UL 2023 Padel Racquet epitomizes cutting-edge performance with its ultra-light construction, meticulously designed to provide effortless maneuverability on the court. Engineered for precision, it allows players to react with lightning-fast reflexes while maintaining unparalleled control. This racquet's agility makes it a formidable weapon for those who seek to dominate play with swift, decisive shots, ensuring you remain one step ahead of your opponents at all times.",
//                         type: TextTypes.f_10_400,
//                         forceColor: AppColors.smalltxt,
//                       ),
//                     ],
//                   ),
//                 ),
//                 padVertical(10),
//                 const Center(
//                     child: Label(
//                   txt: "Similar Products",
//                   type: TextTypes.f_20_600,
//                   forceAlignment: TextAlign.center,
//                 )),
//                 padVertical(10),
//                 Container(
//                   height: 300, // Set a fixed height based on your layout
//                   child: GridView.builder(
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 8,
//                       childAspectRatio: 0.5,
//                     ),
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//                       return ProductCard(
//                         image: product["image"]!,
//                         name: product["name"]!,
//                         price: product["price"]!,
//                         oldPrice: product["oldPrice"]!,
//                       );
//                     },
//                   ),
//                 )
//               ],
//             ),
//           ),
//         )));
//   }
// }
