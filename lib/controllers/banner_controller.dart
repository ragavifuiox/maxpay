import 'package:flutter/material.dart' hide Banner;
import 'package:get/get.dart';
import 'package:maxpay/core/data/model/advertisement_model.dart';
import 'package:maxpay/core/data/model/banner_model.dart';
import 'package:maxpay/core/domain/usecase/advertisement_usecase.dart';
import 'package:maxpay/core/domain/usecase/banner_usecase.dart';

class BannerController extends GetxController {
  final BannerUsecase bannerUsecase;
  final AdvertisementUsecase advusecase;

  BannerController({
    required this.bannerUsecase,
    required this.advusecase,
    });

  RxBool isLoading = false.obs;

  Rx<Banner?> bannerData = Rx<Banner?>(null);
  Rx<Advertisement?> advdata = Rx<Advertisement?>(null);

  RxInt currentIndex = 0.obs;

  late PageController pageController;

  @override
  void onInit() {
    pageController = PageController();
    fetchbanner();
    fetchadv();
    super.onInit();
  }

  Future<void> fetchbanner() async {
    isLoading.value = true;

    final result = await bannerUsecase();

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar('Error', failure.message);
      },
      (data) {
        bannerData.value = data;
        isLoading.value = false;

        startAutoSlide(); // 🔥 IMPORTANT FIX
      },
    );
  }



 Future<void> fetchadv() async {
    isLoading.value = true;

    final result = await advusecase();

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar('Error', failure.message);
      },
      (data) {
        advdata.value = data;
        isLoading.value = false;

       
      },
    );
  }
  void startAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      final list = bannerData.value?.data ?? [];

      if (list.isEmpty || !pageController.hasClients) return;

      int nextPage = currentIndex.value + 1;

      if (nextPage >= list.length) {
        nextPage = 0;
      }

      pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      currentIndex.value = nextPage;

      startAutoSlide(); // loop
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}