import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../controller/play_coins_controller.dart';

class PgPlayCoins extends GetView<PlayCoinsController> {
  const PgPlayCoins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatDate(dynamic createdAt) {
      try {
        if (createdAt == null) return '';
        if (createdAt is DateTime) {
          return DateFormat('dd MMMM yyyy').format(createdAt);
        }
        if (createdAt is String) {
          final parsedDate = DateTime.parse(createdAt);
          return DateFormat('dd MMMM yyyy').format(parsedDate);
        }
        return '';
      } catch (e) {
        return '';
      }
    }

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
                      child: Obx(() {
                        final data = controller.transactionHistoryData.value.data;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: controller.goBack,
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
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Label(
                                  txt: "Play Coins",
                                  type: TextTypes.f_18_600,
                                ),
                              ],
                            ),
                            if (data == null) ...[
                              SkeletonItem(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        width: double.infinity,
                                        height: 200,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                              height: 14,
                                              width: 120,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                              height: 30,
                                              width: 100,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                          const SizedBox(height: 25),
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                              height: 14,
                                              width: 80,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    const Label(
                                      txt: "Transaction History",
                                      type: TextTypes.f_18_600,
                                    ),
                                    const SizedBox(height: 10),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: 3, // Show 3 placeholder items
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(vertical: 5),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1, color: AppColors.border),
                                            color: AppColors.whiteColor,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 14,
                                                  width: 100,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  SkeletonLine(
                                                    style: SkeletonLineStyle(
                                                      height: 14,
                                                      width: 60,
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  SkeletonLine(
                                                    style: SkeletonLineStyle(
                                                      height: 10,
                                                      width: 80,
                                                      borderRadius: BorderRadius.circular(4),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ] else ...[
                              Stack(
                                children: [
                                  Image.asset(
                                    AppAssets.coinsbanner,
                                    fit: BoxFit.contain,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                  Positioned(
                                    top: 40,
                                    left: 20,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Label(
                                          txt: "Total play coins",
                                          type: TextTypes.f_14_400,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                        const SizedBox(height: 5),
                                        Label(
                                          txt: "₹ ${(data.totalPlayCoinsBalance ?? 0).toStringAsFixed(2)}",
                                          type: TextTypes.f_30_700,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                        const SizedBox(height: 25),
                                        Text(
                                          "${data.totalMatches != 0 ? data.totalMatches?.toStringAsFixed(0) : "no"} matches played",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Label(
                                txt: "Transaction History",
                                type: TextTypes.f_18_600,
                              ),
                              const SizedBox(height: 10),
                              data.transactionHistory?.isEmpty ?? true
                                  ? Container(
                                height: Get.height * 0.2,
                                child: const Center(
                                  child: Label(
                                    txt: "No Transactions",
                                    type: TextTypes.f_14_400,
                                    forceColor: AppColors.blackColor,
                                  ),
                                ),
                              )
                                  : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data.transactionHistory?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final transaction = data.transactionHistory![index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(vertical: 5),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: AppColors.border),
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Label(
                                              txt: transaction.text ?? "",
                                              type: TextTypes.f_14_400,
                                              forceColor: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Label(
                                              txt: transaction.transactionType == "deducted"
                                                  ? "- ${(transaction.amount ?? 0).toStringAsFixed(2)}"
                                                  : "+ ${(transaction.amount ?? 0).toStringAsFixed(2)}",
                                              type: TextTypes.f_14_600,
                                              forceColor: transaction.transactionType == "deducted"
                                                  ? AppColors.red
                                                  : AppColors.green2,
                                            ),
                                            const SizedBox(height: 5),
                                            Label(
                                              txt: formatDate(transaction.createdAt ?? ""),
                                              type: TextTypes.f_10_600,
                                              forceColor: AppColors.grey,
                                            ),
                                            const SizedBox(height: 5),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                            const SizedBox(height: 10),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}