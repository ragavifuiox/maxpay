import 'package:get/get.dart';
import 'package:maxpay/core/constants/routes_path.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/staff_lsit_model.dart';
import 'package:maxpay/core/domain/usecase/addd_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/staff_list_usecase.dart';

class AddStaffController extends GetxController {
  final AddStaffUsecase addStaffUsecase;
  final StaffListUseCase staffListUseCase; 

  AddStaffController({
    required this.addStaffUsecase,
  
     required this.staffListUseCase,
  });
 final staff = <Data>[].obs;
  bool isLoading = false;

  Future<void> addstaff(
  String name,
  String mobile,
) async {

  try {

    isLoading = true;
    update();

    print("=========== REQUEST DATA ===========");
    print("NAME : $name");
    print("MOBILE : $mobile");
    print("===================================");

    final result = await addStaffUsecase(
      name,
      mobile,
    );

    result.fold(
      (failure) {

        print("=========== FAILURE ===========");
        print(failure.message);
        print("================================");

        CustomToast.error(
          failure.message,
        );

      },
      (response) async {

        print("=========== BACKEND RESPONSE ===========");
        print("SUCCESS : ${response.success}");
        print("MESSAGE : ${response.message}");
        print("FULL RESPONSE : $response");
        print("========================================");

        if (response.success == true) {

          CustomToast.success(
            response.message ??
                "Staff Added Successfully",
          );

          Get.offAllNamed(
            AppRoutes.stafflist,
          );

        } else {

          CustomToast.error(
            response.message ??
                "Failed to Add Staff",
          );
        }
      },
    );

  } finally {

    isLoading = false;
    update();
  }
}Future<void> stafflist() async {
  isLoading = true;
  update();

  final result = await staffListUseCase();

  result.fold(
    (failure) {
      isLoading = false;
      update();

      Get.snackbar(
        'Error',
        failure.message,
      );
    },
    (data) {

      /// backend data list
      staff.value = data.data ?? [];

      isLoading = false;
      update();
    },
  );
}
  }


