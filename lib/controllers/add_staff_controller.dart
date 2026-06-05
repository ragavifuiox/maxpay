import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/search_staff_model.dart' hide Data;
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/core/domain/usecase/addd_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/staff_list_usecase.dart';

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

      print("=========== REQUEST DATA ===========");
      print("NAME : $name");
      print("MOBILE : $mobile");
      print("PACKAGE : $package");
      print("===================================");

      final result = await addStaffUsecase(name, mobile, package);

      result.fold(
        (failure) {
          print("=========== FAILURE ===========");
          print(failure.message);
          print("================================");

          CustomToast.error(failure.message);
        },
        (response) {
          print("=========== BACKEND RESPONSE ===========");
          print("SUCCESS : ${response.success}");
          print("MESSAGE : ${response.message}");
          print("FULL RESPONSE : $response");
          print("========================================");

          if (response.success == true) {
            CustomToast.success(
              response.message ?? "Staff Added Successfully",
            );

      Get.back(result: true);
Get.find<AddStaffController>().stafflist();
          } else {
            CustomToast.error(
              response.message ?? "Failed to Add Staff",
            );
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

    print("Searching Mobile: $mobile");

    final result = await searchStaffUsecase(mobile);

    result.fold(
      (failure) {
        print("FAILURE: ${failure.message}");
        CustomToast.error(failure.message);
      },
      (response) {
        print("SUCCESS: ${response.success}");
        print("NAME: ${response.data?.data?.retailerName}");

        if (response.success == true) {
          nameController.text =
              response.data?.data?.retailerName ?? '';
               packageController.text =
      response.data?.data?.commissionPackage ?? '';

          print("TEXT SET: ${nameController.text}");
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