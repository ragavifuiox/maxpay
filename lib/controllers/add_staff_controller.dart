import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/search_staff_model.dart' hide Data;
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/core/domain/usecase/addd_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/staff_list_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class AddStaffController extends GetxController {
  final AddStaffUsecase addStaffUsecase;
  final StaffListUseCase staffListUseCase;
  final SearchStaffUsecase searchStaffUsecase;

  AddStaffController({
    required this.addStaffUsecase,
    required this.staffListUseCase,
    required this.searchStaffUsecase,
  });
  @override
  void onInit() {
    stafflist();
    super.onInit();
  }

  final staff = <Data>[].obs;
  final searchStaffData = <SearchStaffData>[].obs;
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController packageController = TextEditingController();
  // ================= ADD STAFF =================
  Future<void> addstaff(String name, String mobile, String package) async {
    try {
      isLoading = true;
      update();

      AppLogger.logError("=========== REQUEST DATA ===========");
      AppLogger.logError("NAME : $name");
      AppLogger.logError("MOBILE : $mobile");
      AppLogger.logError("PACKAGE : $package");
      AppLogger.logError("===================================");

      final result = await addStaffUsecase(name, mobile, package);

      result.fold(
        (failure) {
          AppLogger.logError("=========== FAILURE ===========");
          AppLogger.logError(failure.message);
          AppLogger.logError("================================");

          CustomToast.error(failure.message);
        },
        (response) {
          AppLogger.logError("=========== BACKEND RESPONSE ===========");
          AppLogger.logError("SUCCESS : ${response.success}");
          AppLogger.logError("MESSAGE : ${response.message}");
          AppLogger.logError("FULL RESPONSE : $response");
          AppLogger.logError("========================================");

          if (response.success == true) {
            CustomToast.success(response.message ?? "Staff Added Successfully");

            Get.back(result: true);
            Get.find<AddStaffController>().stafflist();
          } else {
            CustomToast.error(response.message ?? "Failed to Add Staff");
          }
        },
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> searchStaff(String mobile) async {
    try {
      isLoading = true;
      update();

      AppLogger.logError("Searching Mobile: $mobile");

      final result = await searchStaffUsecase(mobile);

      result.fold(
        (failure) {
          AppLogger.logError("FAILURE: ${failure.message}");
          CustomToast.error(failure.message);
        },
        (response) {
          AppLogger.logError("SUCCESS: ${response.success}");
          AppLogger.logError("NAME: ${response.data?.data?.retailerName}");

          if (response.success == true) {
            nameController.text = response.data?.data?.retailerName ?? '';
            packageController.text =
                response.data?.data?.commissionPackage ?? '';

            AppLogger.logError("TEXT SET: ${nameController.text}");
          } else {
            nameController.clear();
            packageController.clear();
          }

          update();
        },
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  // ================= STAFF LIST =================
  Future<void> stafflist() async {
    try {
      isLoading = true;
      update();

      final result = await staffListUseCase();

      result.fold(
        (failure) {
          CustomToast.error(failure.message);
        },
        (data) {
          staff.value = data.data ?? [];
        },
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
