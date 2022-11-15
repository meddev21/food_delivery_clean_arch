import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:food_delivery_clean_arch/src/config/app_colors.dart';

void snackbar(String title, String body){
  Get.snackbar(title, body,
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
}
