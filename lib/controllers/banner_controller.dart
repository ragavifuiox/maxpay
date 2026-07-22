import 'dart:async';
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

  Timer? autoSlideTimer;

  @override
  void onInit() {
    super.onInit();

    pageController = PageController();

    fetchbanner();
    fetchadv();
  }

  Future<void> fetchbanner() async {
    isLoading.value = true;

    final result = await bannerUsecase();

    result.fold(
      (failure) {
        isLoading.value = false;
        Get.snackbar("Error", failure.message);
      },
      (data) {
        bannerData.value = data;
        isLoading.value = false;

        startAutoSlide();
      },
    );
  }

  Future<void> fetchadv() async {
    final result = await advusecase();

    result.fold(
      (failure) {
        Get.snackbar("Error", failure.message);
      },
      (data) {
        advdata.value = data;
      },
    );
  }

  void startAutoSlide() {
    autoSlideTimer?.cancel();

    autoSlideTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => nextBanner(),
    );
  }

  void nextBanner() {
    final list = bannerData.value?.data ?? [];

    if (list.isEmpty) return;
    if (!pageController.hasClients) return;

    int next = currentIndex.value + 1;

    if (next >= list.length) {
      next = 0;
    }

    pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    currentIndex.value = next;
  }

  void previousBanner() {
    final list = bannerData.value?.data ?? [];

    if (list.isEmpty) return;
    if (!pageController.hasClients) return;

    int previous = currentIndex.value - 1;

    if (previous < 0) {
      previous = list.length - 1;
    }

    pageController.animateToPage(
      previous,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    currentIndex.value = previous;
  }

  @override
  void onClose() {
    autoSlideTimer?.cancel();
    pageController.dispose();
    super.onClose();
  }
}