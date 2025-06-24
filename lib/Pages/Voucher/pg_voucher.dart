import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';

import 'package:flutter/material.dart';

class PgVoucher extends StatefulWidget {
  const PgVoucher({super.key});

  @override
  State<PgVoucher> createState() => _PgVoucherState();
}

class _PgVoucherState extends State<PgVoucher> {
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
                          txt: "Vouchers",
                          type: TextTypes.f_18_600,
                        ),
                      ]),
                      padVertical(30),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Container(
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                      color: AppColors.rankPoint,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Label(
                                          txt: '${index + 1}',
                                          type: TextTypes.f_12_700),
                                    ),
                                  ),
                                  padHorizontal(10),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        AppAssets.racket,
                                        fit: BoxFit.fill,
                                        width: 46,
                                        height: 46,
                                      )),
                                  padHorizontal(8),
                                  const Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Label(
                                          txt: "BHJDXIASUBXCSI",
                                          type: TextTypes.f_12_700,
                                          forceColor: AppColors.primaryColor,
                                        ),
                                        Label(
                                          txt: "Full Match",
                                          type: TextTypes.f_12_500,
                                          forceColor: AppColors.grey,
                                        ),
                                      ])
                                ]),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.blue2,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Label(
                                    txt: "11,258",
                                    type: TextTypes.f_12_700,
                                    forceColor: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      padVertical(40),
                      SizedBox(
                          width: double.infinity,
                          child: commonButton(
                            context: context,
                            txt: "Buy New Voucher",
                            onPressed: () {},
                          ))
                    ])))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
