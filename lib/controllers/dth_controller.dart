  import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/confirm_dth_model.dart';
import 'package:maxpay/core/data/model/custoer_info_model.dart';
import 'package:maxpay/core/data/model/dth_recharge_model.dart';
import 'package:maxpay/core/data/model/dth_tab_model.dart';
import 'package:maxpay/core/data/model/search_dth_model.dart';
import 'package:maxpay/core/domain/usecase/confirm_dth_usecase.dart';
import 'package:maxpay/core/domain/usecase/customer_info_usecase.dart';
import 'package:maxpay/core/domain/usecase/dth_recharge_usecase.dart';
import 'package:maxpay/core/domain/usecase/dth_tab_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_dth_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';
   
class DthController extends GetxController {
  final DthTabUsecase dthtabUseCase;
  final SearchDthUsecase searchdthusecase;
  final ConfirmDthUsecase confirmdthUsecase;
  final DthRechargeUsecase dthrechargeusecase ;
  final CustomerInfoUsecase customerInfoUsecase ;

  DthController({
    required this.dthtabUseCase,
    required this.searchdthusecase,
    required this.confirmdthUsecase,
    required this.dthrechargeusecase,
    required this.customerInfoUsecase,
  });
  RxBool isCustomerInfoLoading = false.obs;
  Rx<CustomerInfo?> customerInfo = Rx<CustomerInfo?>(null);
  RxBool isLoading = false.obs;
RxBool isRechargeLoading = false.obs;
  RxList<DthtabData> planTabs = <DthtabData>[].obs;
  RxList<SearchDthData> searchdthList = <SearchDthData>[].obs;
   Rx<DthRecharge?> rechargeResponse = Rx<DthRecharge?>(null);
Rx<ConfirmDth?> confirmdth = Rx<ConfirmDth?>(null);
  RxString selectedPlanType = ''.obs;
    final String productdetid = Get.arguments?['productId'] ?? '';
  RxString enteredAmount = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getPlanTabs();
  }

  /// ✅ GET TABS
  Future<void> getPlanTabs() async {
    isLoading.value = true;

    AppLogger.debugPrint("🚀 getPlanTabs API calling...");

    final result = await dthtabUseCase();

    result.fold(
      (failure) {
        AppLogger.logError("❌ Tab API Error: ${failure.message}");
        Get.snackbar('Error', failure.message);
      },
      (response) {
        planTabs.value = response.data ?? [];

        AppLogger.debugPrint("✅ Tab API Success");
        AppLogger.debugPrint("Tabs Count: ${planTabs.length}");

        if (planTabs.isNotEmpty) {
          selectedPlanType.value = planTabs.first.planType ?? "";
        }
      },
    );

    isLoading.value = false;
  }

  /// ✅ SEARCH DTH
 Future<void> searchDth(String planId, {String? amount}) async {
  isLoading.value = true;

  final result = await searchdthusecase.searchdth(planId, amount ?? "");

  result.fold(
    (failure) {
      searchdthList.clear(); // Clear old plans
      Get.snackbar('Info', 'No plans found');
    },
    (response) {
      searchdthList.value = response.data ?? [];
    },
  );

  isLoading.value = false;
}


 Future<void> getconfirmdth(String prodcutdetid) async {
    AppLogger.logError("🚀 [CONFIRM TRANS] Started");
    AppLogger.logError("🆔 Product Detail ID: $prodcutdetid");

    isLoading.value = true;
    AppLogger.logError("⏳ Loading started...");

    final result = await confirmdthUsecase(prodcutdetid: prodcutdetid);

    result.fold(
      (failure) {
        AppLogger.debugPrint("❌ [CONFIRM TRANS FAILED]");
        AppLogger.debugPrint("📄 Error Message: ${failure.message}");

        isLoading.value = false;
        AppLogger.debugPrint("⏹️ Loading stopped");

        Get.snackbar('Error', failure.message);
      },
      (data) {
        AppLogger.logError("✅ [CONFIRM TRANS SUCCESS]");
        AppLogger.logError("📦 Response Data: $data");

        confirmdth.value = data;

        isLoading.value = false;
        AppLogger.debugPrint("⏹️ Loading stopped");
        AppLogger.debugPrint("🎉 Transaction Confirmation Completed");
      },
    );
  }

   Future<bool> dthrecharge(
    String productdetid,
    String mobile,
    String amount,
    String paymentstatus,
  ) async {
    try {
      AppLogger.logError("👉 Recharge API CALL STARTED");

      if (isRechargeLoading.value) {
        AppLogger.logError("⛔ Already loading - duplicate click blocked");
        return false;
      }

      isRechargeLoading.value = true;

      AppLogger.logError("👉 Request Data:");
      AppLogger.logError("productdetid: $productdetid");
      AppLogger.logError("mobile: $mobile");
      AppLogger.logError("amount: $amount");
         AppLogger.logError("paymentstatus: $paymentstatus");

      final stopwatch = Stopwatch()..start();

      AppLogger.logError("🚀 API CALL START");

      final result = await dthrechargeusecase(productdetid, mobile, amount,paymentstatus);

      AppLogger.logError("✅ API RESPONSE RECEIVED in ${stopwatch.elapsedMilliseconds} ms");

      AppLogger.logError("👉 API RESPONSE RECEIVED");

      return result.fold(
        (failure) {
          AppLogger.logError("❌ FAILURE RESPONSE");
          AppLogger.logError("Error message: ${failure.message}");

          CustomToast.error(failure.message);
          return false;
        },
        (response) {
          rechargeResponse.value = response;
          AppLogger.logError("✅ SUCCESS RESPONSE OBJECT");
          AppLogger.logError("Full response: $response");

          final status =
    response.data?.data?.status?.toLowerCase();
          AppLogger.logError("👉 Parsed status: $status");

          final isSuccess = status == "success";

          AppLogger.logError("👉 isSuccess: $isSuccess");

          if (isSuccess) {
            AppLogger.logError("🎉 Recharge SUCCESS");
            CustomToast.success(response.message ?? "Success");
            return true;
          } else {
            AppLogger.logError("⚠️ Recharge FAILED");
            CustomToast.error(response.message ?? "Recharge Failed");
            return false;
          }
        },
      );
    } catch (e, stack) {
      AppLogger.logError("🔥 EXCEPTION OCCURRED: $e");
      AppLogger.logError("STACKTRACE: $stack");

      CustomToast.error("Something went wrong");
      return false;
    } finally {
      isRechargeLoading.value = false;
      AppLogger.logError("👉 Loading set to false (finally block)");
    }
  }


  Future<void> getCustomerInfo(String productId, String customerId) async {
    if (productId.isEmpty || customerId.isEmpty) {
      Get.snackbar('Error', 'Product ID and Customer ID are required');
      return;
    }

    isCustomerInfoLoading.value = true;
    customerInfo.value = null;

    AppLogger.logError("🚀 [CUSTOMER INFO] Request => productId: $productId, customerId: $customerId");

    final result = await customerInfoUsecase(
      productId,
      customerId,
    );

    result.fold(
      (failure) {
        AppLogger.logError("❌ Customer Info Error: ${failure.message}");
        Get.snackbar('Error', failure.message);
      },
      (response) {
        customerInfo.value = response;

        AppLogger.logError("✅ [CUSTOMER INFO SUCCESS]");
        AppLogger.logError("📦 Full response: ${response.toJson()}");

        final records = response.data?.records;
        AppLogger.logError("📋 Records count: ${records?.length ?? 0}");

        if (records != null && records.isNotEmpty) {
          final first = records.first;
          AppLogger.logError("🪪 First record => ${first.toJson()}");
          AppLogger.logError("🏷️ planname value => ${first.planname}");
        } else {
          AppLogger.logError("⚠️ Records list is empty or null");
        }
      },
    );

    isCustomerInfoLoading.value = false;
  }
}
