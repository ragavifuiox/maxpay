import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart' show ExtensionSnackbar, GetNavigation;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/mobile_recharge.dart' show MobileRecharge;
import 'package:maxpay/core/data/model/plan_detail_model.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/data/model/plan_tab_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/data/model/tab_detail.dart';
import 'package:maxpay/core/data/model/trans_confirm_model.dart';
import 'package:maxpay/core/domain/usecase/mobile_recharge_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_tab_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/tab_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_confirm_usecase.dart';

class PrePaidController extends GetxController {
  final PlanUseCase planUseCase;
  final SearchPlanUsecase searchPlanUsecase;
  final PlanDetailUseCase planDetailUseCase;
  final TransConfirmUseCase transConfirmUseCase;
  final MobileRechargeUsecase mobileRechargeUseCase;
  final PlanTabUseCase plantabusecase;
  final  TabDetailUsecase tabdetailusecase;
  final String productdetid =
    Get.arguments?['productId'] ?? '';
  
  PrePaidController({
    required this.planUseCase,
    required this.searchPlanUsecase,
    required this.planDetailUseCase,
    required this.transConfirmUseCase,
    required this.mobileRechargeUseCase,
    required this.plantabusecase,
    required this.tabdetailusecase
  });

  RxBool isLoading = false.obs;
Rx<MobileRecharge?> rechargeResponse =
    Rx<MobileRecharge?>(null);
  RxList<Data> plans = <Data>[].obs;
  RxList<PlanDetailData> plandetail = <PlanDetailData>[].obs;
  RxList<PlanData> searchPlansList = <PlanData>[].obs;
RxList<PlanDetailData> planDetailList =
    <PlanDetailData>[].obs;
   
  RxString errorMessage = ''.obs;
RxBool isRechargeLoading = false.obs;
  Rx<TransConfirm?> transConfirmData =
      Rx<TransConfirm?>(null);
      RxList<TabDetailData> tabdetaillist =
    <TabDetailData>[].obs;

RxList<PlantabData> planTabs = <PlantabData>[].obs;
  Rx<Data?> selectedPlan = Rx<Data?>(null);
  Rx<PlanDetailData?> selectplandetail= Rx<PlanDetailData?>(null);

String selectedTabId = "";
  Future<void> getPlans({required String productid}) async {
    try {
      isLoading.value = true;

      final result = await planUseCase(productid: productid);

      result.fold(
        (failure) {
          CustomToast.error(failure.message);
        },
        (response) {
          plans.value = response.data ?? [];

          if (plans.isNotEmpty) {
            selectedPlan.value = plans.first;
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
  
Future<void> getPlanDetail({
  required String planId,
}) async {
  try {
    print("🔍 [GET PLAN DETAIL] Started");
    print("📦 Plan ID: $planId");

    isLoading.value = true;
    print("⏳ Loading Started");

    final result = await planDetailUseCase(
      Planid: planId,
    );

    print("✅ API Response Received");

    result.fold(
      (failure) {
        print("❌ API Failed");
        print("📝 Error: ${failure.message}");

        CustomToast.error(
          failure.message,
        );
      },
      (response) {
        print("🎉 API Success");
        print("📊 Total Plans: ${response.data?.length ?? 0}");
        print("📄 Response Data: ${response.data}");

        planDetailList.value = response.data ?? [];

        print(
          "✅ planDetailList Updated: ${planDetailList.length} items",
        );
      },
    );
  } catch (e, s) {
    print("💥 Exception Occurred");
    print("Error: $e");
    print("StackTrace: $s");
  } finally {
    isLoading.value = false;
    print("🏁 Loading Finished");
  }
}



Future<void> getTabDetail({
  required String tabid,
}) async {
  try {
    print("🔍 [GET Tab DETAIL] Started");
    print("📦 Tab ID: $tabid");

    isLoading.value = true;
    print("⏳ Loading Started");

    final result = await tabdetailusecase(tabid: tabid);

    print("✅ API Response Received");

    result.fold(
      (failure) {
        print("❌ API Failed");
        print("📝 Error: ${failure.message}");

        CustomToast.error(
          failure.message,
        );
      },
      (response) {
        print("🎉 API Success");
        print("📊 Total Plans: ${response.data?.length ?? 0}");
        print("📄 Response Data: ${response.data}");

        tabdetaillist.value = response.data ?? [];

        print(
          "✅ planDetailList Updated: ${planDetailList.length} items",
        );
      },
    );
  } catch (e, s) {
    print("💥 Exception Occurred");
    print("Error: $e");
    print("StackTrace: $s");
  } finally {
    isLoading.value = false;
    print("🏁 Loading Finished");
  }
}
  
  Future<void> searchPlans(String planId, String amount) async {
  try {
    print("🔍 [SEARCH PLANS] Started");
    print("📦 PlanId: $planId | 💰 Amount: $amount");

    isLoading.value = true;
    print("⏳ Loading started...");

    final result = await searchPlanUsecase(planId, amount);

    result.fold(
      (failure) {
        print("❌ API Failed");
        print("⚠️ Error: ${failure.message}");

        CustomToast.error(failure.message);
      },
      (response) {
        print("✅ API Success");

        if (response.success == true) {
          print("📊 Data received: ${response.data}");

          searchPlansList.value = response.data ?? [];

          print("📌 Plans count: ${searchPlansList.length}");
        } else {
          print("⚠️ Response success = false");
          searchPlansList.clear();
        }
      },
    );
  } catch (e) {
    print("🔥 Exception occurred: $e");
  } finally {
    isLoading.value = false;
    print("🏁 Loading finished");
  }
}




Future<void> confirmtrans(String prodcutdetid) async {
  print("🚀 [CONFIRM TRANS] Started");
  print("🆔 Product Detail ID: $prodcutdetid");

  isLoading.value = true;
  print("⏳ Loading started...");

  final result = await transConfirmUseCase(
    prodcutdetid: prodcutdetid,
  );

  result.fold(
    (failure) {
      print("❌ [CONFIRM TRANS FAILED]");
      print("📄 Error Message: ${failure.message}");

      isLoading.value = false;
      print("⏹️ Loading stopped");

      Get.snackbar(
        'Error',
        failure.message,
      );
    },
    (data) {
      print("✅ [CONFIRM TRANS SUCCESS]");
      print("📦 Response Data: $data");

      transConfirmData.value = data;

      isLoading.value = false;
      print("⏹️ Loading stopped");
      print("🎉 Transaction Confirmation Completed");
    },
  );
}
 Future<void> getPlanTabs() async {
  isLoading.value = true;

  final result = await plantabusecase();

  result.fold(
    (failure) {
      Get.snackbar('Error', failure.message);
    },
    (response) {
      planTabs.value = response.data ?? [];
    },
  );

  isLoading.value = false;
}

Future<bool> mobilerecharge(
  String productdetid,
  String mobile,
  String amount,
) async {
  try {
    print("👉 Recharge API CALL STARTED");

    if (isRechargeLoading.value) {
      print("⛔ Already loading - duplicate click blocked");
      return false;
    }

    isRechargeLoading.value = true;

    print("👉 Request Data:");
    print("productdetid: $productdetid");
    print("mobile: $mobile");
    print("amount: $amount");

   final stopwatch = Stopwatch()..start();

print("🚀 API CALL START");

final result = await mobileRechargeUseCase(
  productdetid,
  mobile,
  amount,
);

print(
  "✅ API RESPONSE RECEIVED in ${stopwatch.elapsedMilliseconds} ms",
);

    print("👉 API RESPONSE RECEIVED");

    return result.fold(
      (failure) {
        print("❌ FAILURE RESPONSE");
        print("Error message: ${failure.message}");

        CustomToast.error(failure.message);
        return false;
      },
      (response) {
         rechargeResponse.value = response;
        print("✅ SUCCESS RESPONSE OBJECT");
        print("Full response: $response");

      final status = response.data?.recharge?.status?.toLowerCase();
         print("👉 Parsed status: $status");

      final isSuccess = status == "success";

print("👉 isSuccess: $isSuccess");

if (isSuccess) {
  print("🎉 Recharge SUCCESS");
  CustomToast.success(response.message ?? "Success");
  return true;
} else {
  print("⚠️ Recharge FAILED");
  CustomToast.error(response.message ?? "Recharge Failed");
  return false;
}
      },
    );
  } catch (e, stack) {
    print("🔥 EXCEPTION OCCURRED: $e");
    print("STACKTRACE: $stack");

    CustomToast.error("Something went wrong");
    return false;
  } finally {
    isRechargeLoading.value = false;
    print("👉 Loading set to false (finally block)");
  }
}
}