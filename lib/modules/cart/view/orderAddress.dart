import 'dart:async';



import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/modules/cart/controller/orderAddressController.dart';
import 'package:badminton/modules/profile/controller/allusers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';

import '../../../app_settings/components/common_textfield.dart';
import '../../../app_settings/constants/common_button.dart';
import '../../../repository/endpoint.dart';

class Orderaddress extends GetView<OrderAddressController> {
  const Orderaddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: WidgetGlobalMargin(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      padVertical(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
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
                          SizedBox(width: 20),
                          const Label(
                            txt: "Delivery Address",
                            type: TextTypes.f_18_600,
                          ),
                        ],
                      ),
                      padVertical(10),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Label(
                            txt: "Name of recipient",
                            type: TextTypes.f_12_700,
                            forceColor: AppColors.smalltxt,
                          ).marginSymmetric(horizontal: 4,vertical: 10),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.withOpacity(0.3))),
                            child: commonTxtField(
                              hTxt: "Name of recipient",

                              controller: controller.name,
                            ),
                          ),

                          Label(
                            txt: "City",
                            type: TextTypes.f_12_700,
                            forceColor: AppColors.smalltxt,
                          ).marginSymmetric(horizontal: 4,vertical: 10),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.withOpacity(0.3))),
                            child: commonTxtField(
                              hTxt: "City",

                              controller: controller.address,
                            ),
                          ),

                          Label(
                            txt: "State",
                            type: TextTypes.f_12_700,
                            forceColor: AppColors.smalltxt,
                          ).marginSymmetric(horizontal: 4,vertical: 10),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.withOpacity(0.3))),
                            child: commonTxtField(
                              hTxt: "State",

                              controller: controller.state,
                            ),
                          ),

                          Label(
                            txt: "Street Address or PO Box (P.O. Box)",
                            type: TextTypes.f_12_700,
                            forceColor: AppColors.smalltxt,
                          ).marginSymmetric(horizontal: 4,vertical: 10),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.withOpacity(0.3))),
                            child: commonTxtField(
                              hTxt: "Street Address or PO Box (P.O. Box)",

                              controller: controller.StreetAddress,
                            ),
                          ),


                          SizedBox(
                            height: 100,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                        txt: "Postal Code",
                                        type: TextTypes.f_12_700,
                                        forceColor: AppColors.smalltxt,
                                      ).marginSymmetric(horizontal: 4,vertical: 10),
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.withOpacity(0.3))),
                                        child: commonTxtField(
                                          hTxt: "Postal Code",
                                          keyboardType: TextInputType.number,
                                          maxLength: 6,
                                  
                                          controller: controller.pinCode,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                        txt: "Country",
                                        type: TextTypes.f_12_700,
                                        forceColor: AppColors.smalltxt,
                                      ).marginSymmetric(horizontal: 4,vertical: 10),
                                      Container(
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.withOpacity(0.3))),
                                        child: commonTxtField(
                                          hTxt: "Country",
                                  
                                          controller: controller.country,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Label(
                            txt: "Recipient Phone",
                            type: TextTypes.f_12_700,
                            forceColor: AppColors.smalltxt,
                          ).marginSymmetric(horizontal: 4),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey.withOpacity(0.3))),
                            child: commonTxtField(
                              hTxt: "Recipient Phone",
                              keyboardType: TextInputType.phone,
                              maxLength: 10,

                              controller: controller.phoneNumber,
                            ),
                          ),

                        ],
                      ).marginSymmetric(vertical: 20),


                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: Get.width,
              child: commonButton(
                context: context,
                onPressed: () {
                  controller.processOrder();
                },
                txt: "Continue"
              ),
            ).marginSymmetric(horizontal: 20, vertical: 10),

          ],
        ),
      ),
    );
  }
}
