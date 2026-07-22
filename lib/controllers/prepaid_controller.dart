import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart'
    show ExtensionSnackbar, GetNavigation;
import 'package:get/get_navigation/src/root/parse_route.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:maxpay/core/constants/snackbar.dart';
import 'package:maxpay/core/data/model/mobile_recharge.dart'
    show MobileRecharge;
import 'package:maxpay/core/data/model/plan_detail_model.dart';
import 'package:maxpay/core/data/model/plan_model.dart';
import 'package:maxpay/core/data/model/plan_tab_model.dart';
import 'package:maxpay/core/data/model/rehcarge_offer_model.dart';
import 'package:maxpay/core/data/model/search_plan_model.dart';
import 'package:maxpay/core/data/model/tab_detail.dart';
import 'package:maxpay/core/data/model/trans_confirm_model.dart';
import 'package:maxpay/core/domain/usecase/check_operator_usecase.dart';
import 'package:maxpay/core/domain/usecase/downlaod_usecase.dart';
import 'package:maxpay/core/domain/usecase/mobile_recharge_usecase.dart';
import 'package:maxpay/core/domain/usecase/offer_rechdarge_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_tab_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/tab_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_confirm_usecase.dart';
import 'package:maxpay/core/utils/logg_helper.dart';

class PrePaidController extends GetxController {
  final PlanUseCase planUseCase;
  final SearchPlanUsecase searchPlanUsecase;
  final PlanDetailUseCase planDetailUseCase;
  final TransConfirmUseCase transConfirmUseCase;
  final MobileRechargeUsecase mobileRechargeUseCase;
  final CheckOperatorUsecase checkOperatorUsecase;
  final PlanTabUseCase plantabusecase;
  final TabDetailUsecase tabdetailusecase;
  final DownloadUsecase downloadusecase;
  final OfferRechargeUsecase offerRechargeUsecase;
  final String productdetid = Get.arguments?['productId'] ?? '';

  PrePaidController({
    required this.planUseCase,
    required this.searchPlanUsecase,
    required this.planDetailUseCase,
    required this.transConfirmUseCase,
    required this.mobileRechargeUseCase,
    required this.checkOperatorUsecase,
    required this.plantabusecase,
    required this.tabdetailusecase,
    required this.downloadusecase,
    required this.offerRechargeUsecase,
  });
  RxBool isSearching = false.obs;
  RxBool isLoading = false.obs;
  Rx<MobileRecharge?> rechargeResponse = Rx<MobileRecharge?>(null);
  RxList<Data> plans = <Data>[].obs;
  RxList<PlanDetailData> plandetail = <PlanDetailData>[].obs;
  RxString operatorName = "".obs;
  RxString productId = "".obs;
  RxList<PlanData> searchPlansList = <PlanData>[].obs;
  RxString defaultOperator = "".obs;
  final operatorWebsite = "".obs;
  RxList<OfferRecords> offerList = <OfferRecords>[].obs;
  RxBool isOfferLoading = false.obs;

  RxList<PlanDetailData> planDetailList = <PlanDetailData>[].obs;
  RxList<TabDetailData> filteredTabPlans = <TabDetailData>[].obs;
  RxList<PlanData> filteredSearchPlans = <PlanData>[].obs;
  RxString errorMessage = ''.obs;
  RxBool isRechargeLoading = false.obs;
  Rx<TransConfirm?> transConfirmData = Rx<TransConfirm?>(null);

  RxList<PlantabData> planTabs = <PlantabData>[].obs;
  Rx<Data?> selectedPlan = Rx<Data?>(null);
  Rx<PlanDetailData?> selectplandetail = Rx<PlanDetailData?>(null);

  String selectedTabId = "";
  Future<void> getPlans({required String productid}) async {
    try {
      productId.value = productid; // ✅ ADD THIS
      isLoading.value = true;

      plans.clear();

      print("GET PLAN PRODUCT ID => $productid");

      final result = await planUseCase(productid: productid);

      //       result.fold(
      //         (failure) {
      //           CustomToast.error(failure.message);
      //         },
      //         (response) {
      //           print(
      //             "API RESPONSE PRODUCT IDS => ${response.data?.map((e) => e.id).toList()}",
      //           );
      //           response.data?.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));

      //          plans.assignAll(response.data ?? []);

      // if (plans.isNotEmpty) {
      //   selectedPlan.value = plans.first;

      //   defaultOperator.value = plans.first.name ?? "";
      //   operatorName.value = defaultOperator.value;
      // }

      //           if (plans.isNotEmpty) {
      //             selectedPlan.value = plans.first;
      //           }
      //         },
      //       );

      result.fold(
        (failure) {
          CustomToast.error(failure.message);
        },
        (response) {
          print(
            "API RESPONSE PRODUCT IDS => ${response.data?.map((e) => e.id).toList()}",
          );

          response.data?.sort((a, b) => (a.name ?? "").compareTo(b.name ?? ""));

          plans.assignAll(response.data ?? []);

          selectedPlan.value = null;
          defaultOperator.value = "";
          operatorName.value = "";
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetOperatorSelection() {
    operatorName.value = "";
    operatorWebsite.value = "";
    selectedPlan.value = null; // ✅ null → dropdown shows "Select" hint

    searchPlansList.clear();
    filteredSearchPlans.clear();

    update();
  }
  // Future<void> checkOperator(String mobile) async {
  //   final result = await checkOperatorUsecase(mobile);

  //   result.fold(
  //     (failure) {
  //       CustomToast.error(failure.message);
  //     },
  //     (response) async {
  //       // Use product name instead of lookup operator
  //       final backendOperator = response.product?.name?.trim() ?? "";

  //       operatorName.value = backendOperator;
  //       operatorWebsite.value = response.product?.description ?? "";

  //       print("Backend Operator : $backendOperator");

  //       // Find matching operator in dropdown
  //       final operator = plans.firstWhereOrNull(
  //         (e) =>
  //             (e.name ?? "").trim().toLowerCase() ==
  //             backendOperator.toLowerCase(),
  //       );

  //       if (operator != null) {
  //         print("Matched : ${operator.name}");

  //         // Change dropdown
  //         selectedPlan.value = operator;

  //         // Load plans
  //         await searchPlans(operator.id.toString(), "");

  //         applyTabFilter();

  //         update(); // Refresh UI if using GetBuilder
  //       } else {
  //         print("No Matching Operator");

  //         for (final item in plans) {
  //           print("Dropdown : ${item.name}");
  //         }
  //       }
  //     },
  //   );
  // }
  Future<void> getOffers(String mobile) async {
    try {
      print("Offer Loading Started");

      isOfferLoading.value = true;
      offerList.clear();

      final result = await offerRechargeUsecase(mobile);

      print("Offer API Response Received");

      result.fold(
        (failure) {
          print("Offer Failed");
          CustomToast.error(failure.message);
        },
        (response) {
          print("Offer Success");
          offerList.assignAll(response.offers?.records ?? []);
        },
      );
    } catch (e) {
      print(e);
    } finally {
      print("Offer Loading End");
      isOfferLoading.value = false;
    }
  }

  Future<void> checkOperator(String mobile) async {
    try {
      isLoading.value = true;

      if (plans.isEmpty) {
        await getPlans(productid: productId.value);
      }

      final result = await checkOperatorUsecase(mobile);

      result.fold(
        (failure) {
          CustomToast.error(failure.message);
        },
        (response) async {
          final backendOperator =
    response.lookup?.records?.operator?.trim() ?? "";

          operatorName.value = backendOperator;
          operatorWebsite.value = response.product?.description ?? "";

          print("Backend Operator : $backendOperator");

          final operator = plans.firstWhereOrNull(
            (e) =>
                (e.name ?? "").trim().toLowerCase() ==
                backendOperator.toLowerCase(),
          );

          if (operator != null) {
            print("Matched : ${operator.name}");

            selectedPlan.value = operator;

            await searchPlans(operator.id.toString(), "");

            applyTabFilter();

            update();
          } else {
            print("No Matching Operator");

            for (final item in plans) {
              print("Dropdown : ${item.name}");
            }
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchPlans(String planId, String amount) async {
    AppLogger.debugPrint("========== SEARCH API ==========");
    AppLogger.debugPrint("PlanId : $planId");
    AppLogger.debugPrint("Amount : $amount");

    final result = await searchPlanUsecase(planId, amount);

    result.fold(
      (failure) {
        AppLogger.debugPrint("SEARCH FAILED");
        AppLogger.debugPrint("Message : ${failure.message}");

        CustomToast.error(failure.message);
      },
      (response) {
        AppLogger.debugPrint("SEARCH SUCCESS");
        AppLogger.debugPrint("Response : $response");
        AppLogger.debugPrint("Data Count : ${response.data?.length}");

        searchPlansList.value = response.data ?? [];

        applyTabFilter();
      },
    );
  }

  void applyTabFilter() {
    AppLogger.debugPrint("============== FILTER START ==============");

    AppLogger.debugPrint("Selected Tab ID : $selectedTabId");

    final selectedTab = planTabs.firstWhereOrNull(
      (e) => e.id.toString() == selectedTabId,
    );

    if (selectedTab == null) {
      AppLogger.debugPrint("No matching tab found");

      filteredSearchPlans.value = searchPlansList;
      return;
    }

    final tabName = (selectedTab.planType ?? "").toLowerCase().trim();

    AppLogger.debugPrint("Selected Tab Name : $tabName");

    AppLogger.debugPrint("Search Plan Count : ${searchPlansList.length}");

    for (final p in searchPlansList) {
      AppLogger.logError("PlanType => ${p.planType}");
    }

    filteredSearchPlans.value = searchPlansList.where((plan) {
      return (plan.planType ?? "").toLowerCase().trim() == tabName;
    }).toList();

    AppLogger.debugPrint(
      "Filtered Count : ${filteredSearchPlans.length} ${filteredSearchPlans.map((e) => e.toJson())}",
    );

    AppLogger.debugPrint("============== FILTER END ==============");
  }
  // Future<void> searchPlans(String planId, String amount) async {
  //   try {
  //     AppLogger.debugPrint("🔍 [SEARCH PLANS] Started");
  //     AppLogger.debugPrint("📦 PlanId: $planId | 💰 Amount: $amount");

  //     isLoading.value = true;
  //     AppLogger.debugPrint("⏳ Loading started...");

  //     final result = await searchPlanUsecase(planId, amount);

  //     result.fold(
  //       (failure) {
  //         AppLogger.logError("❌ API Failed");
  //         AppLogger.logError("⚠️ Error: ${failure.message}");

  //         CustomToast.error(failure.message);
  //       },
  //       (response) {
  //         AppLogger.logError("✅ API Success");

  //         if (response.success == true) {
  //           AppLogger.logError("📊 Data received: ${response.data}");

  //           searchPlansList.value = response.data ?? [];

  //           AppLogger.debugPrint("📌 Plans count: ${searchPlansList.length}");
  //         } else {
  //           AppLogger.debugPrint("⚠️ Response success = false");
  //           searchPlansList.clear();
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     AppLogger.logError("🔥 Exception occurred: $e");
  //   } finally {
  //     isLoading.value = false;
  //     AppLogger.logError("🏁 Loading finished");
  //   }
  // }

  Future<void> confirmtrans(String prodcutdetid) async {
    try {
      AppLogger.logError("🚀 [CONFIRM TRANS] Started");
      AppLogger.logError("🆔 Product Detail ID: $prodcutdetid");

      isLoading.value = true;
      AppLogger.logError("⏳ Loading started...");

      final result = await transConfirmUseCase(prodcutdetid: prodcutdetid);

      result.fold(
        (failure) {
          AppLogger.debugPrint("❌ [CONFIRM TRANS FAILED]");
          AppLogger.debugPrint("📄 Error Message: ${failure.message}");

          Get.snackbar('Error', failure.message);
        },
        (data) {
          AppLogger.logError("✅ [CONFIRM TRANS SUCCESS]");
          AppLogger.logError("📦 Response Data: ${data.toJson()}");

          transConfirmData.value = data;

          AppLogger.debugPrint("🎉 Transaction Confirmation Completed");
        },
      );
    } finally {
      isLoading.value = false;
      AppLogger.debugPrint("⏹️ Loading stopped");
    }
  }

  Future<void> getPlanTabs() async {
    try {
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getDownload() async {
    try {
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> mobilerecharge(
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

      final stopwatch = Stopwatch()..start();

      AppLogger.logError("🚀 API CALL START");

      final result = await mobileRechargeUseCase(
        productdetid,
        mobile,
        amount,
        paymentstatus,
      );

      AppLogger.logError(
        "✅ API RESPONSE RECEIVED in ${stopwatch.elapsedMilliseconds} ms",
      );

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

  final status = response.data?.recharge?.status?.toLowerCase();

  AppLogger.logError("👉 Parsed status: $status");

  final isSuccess = status == "success";

  AppLogger.logError("👉 isSuccess: $isSuccess");


  if (isSuccess) {
    AppLogger.logError("🎉 Recharge SUCCESS");

    // Backend message only
    CustomToast.success(
      response.message ?? "Success",
    );

    return true;
  } else {
    AppLogger.logError("⚠️ Recharge FAILED");

    // Backend error message only
    CustomToast.error(
      response.message ?? "Recharge Failed",
    );

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
}
