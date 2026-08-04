import 'dart:async';
import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/advertisement_model.dart';
import 'package:maxpay/core/data/model/bank_details_model.dart';
import 'package:maxpay/core/data/model/banner_model.dart';
import 'package:maxpay/core/domain/usecase/advertisement_usecase.dart';
import 'package:maxpay/core/domain/usecase/bank_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/banner_usecase.dart';

class BankDetailController extends GetxController {
  final BankDetailUsecase bankdetailusecase;
  

  BankDetailController({required this.bankdetailusecase,});

  RxBool isLoading = false.obs;

  Rx<BankDetails?> bankData = Rx<BankDetails?>(null);
 

  Timer? autoSlideTimer;

  @override
  void onInit() {
    super.onInit();
    fetchbankdetail();
 }

  Future<void> fetchbankdetail() async {
    isLoading.value = true;

    final result = await bankdetailusecase();

    result.fold(
      (failure) {
        isLoading.value = false;
        CustomToast.error(failure.message);
      },
      (data) {
        bankData.value = data;
        isLoading.value = false;

      
      },
    );
  }

 
}
