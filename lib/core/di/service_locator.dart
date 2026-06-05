import 'package:get_it/get_it.dart';
import 'package:maxpay/core/data/repsoitory/add_staff_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/compalint_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/create_pin_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/credit_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/earning_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/finger_print_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/get_bank_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/get_profile_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/get_support_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/login_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/mobile_rehcarge_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/news_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/otp_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/plan_detail_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/plan_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/plan_tab_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/popup_message_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/product_type_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/search_earning_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/search_plan_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/search_staff_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/staff_lsit_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/tabdetail_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/trans_confirm_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/trans_fsuc_fail.dart';
import 'package:maxpay/core/data/repsoitory/wallet_bal_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_request_repo_impl.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/domain/repository/compalints_repository.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/domain/repository/credit_repository.dart';
import 'package:maxpay/core/domain/repository/earning_repository.dart';
import 'package:maxpay/core/domain/repository/finger_print_repository.dart';
import 'package:maxpay/core/domain/repository/get_bank_repository.dart';
import 'package:maxpay/core/domain/repository/get_profile_repository.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/repository/mobile_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/domain/repository/plan_detail_repository.dart';
import 'package:maxpay/core/domain/repository/plan_repository.dart';
import 'package:maxpay/core/domain/repository/plan_tab_repository.dart';
import 'package:maxpay/core/domain/repository/popup_message_repository.dart';
import 'package:maxpay/core/domain/repository/product_type_repository.dart';
import 'package:maxpay/core/domain/repository/search_earnings_repository.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/domain/repository/search_staff_repository.dart';
import 'package:maxpay/core/domain/repository/staff_list_repository.dart';
import 'package:maxpay/core/domain/repository/support_repository.dart';
import 'package:maxpay/core/domain/repository/tab_detail_repository.dart';
import 'package:maxpay/core/domain/repository/trans_confirm_repository.dart';
import 'package:maxpay/core/domain/repository/transaction_suc_fail_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_request_repository.dart';
import 'package:maxpay/core/domain/usecase/addd_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/complaints_usecase.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/credit_usecase.dart';
import 'package:maxpay/core/domain/usecase/earning_usecase.dart';
import 'package:maxpay/core/domain/usecase/finger_print_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_bank_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_support_usecase.dart';
import 'package:maxpay/core/domain/usecase/login_usecase.dart';
import 'package:maxpay/core/domain/usecase/mobile_recharge_usecase.dart';
import 'package:maxpay/core/domain/usecase/news_usecase.dart';
import 'package:maxpay/core/domain/usecase/otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_tab_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/popup_message_usecase.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_earnings_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/staff_list_usecase.dart';
import 'package:maxpay/core/domain/usecase/tab_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_confirm_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_suc_fail_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_request_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_usecase.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {


  
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  await LocalStorageService().init();
  if (!sl.isRegistered<SharedPreferences>())
    sl.registerSingleton<SharedPreferences>(prefs);

  

  // Core services
  if (!sl.isRegistered<ApiService>())
    sl.registerLazySingleton(() => ApiService());



    //Repository
      sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
      sl.registerLazySingleton<OtpRepository>(() => OtpRepoImpl(sl()));
      sl.registerLazySingleton<GetNewsRepository>(() => GetNewsRepoImpl(sl()));
      sl.registerLazySingleton<CreatePinRepository>(() => CreatePinRepoImpl(sl()));
      sl.registerLazySingleton<WalletBalanceRepository>(() => WalletBalanceRepoImpl(sl()));
      sl.registerLazySingleton<TransactionSucFailRepository>(() => TransactionSucFailRepoImpl(sl()));
      sl.registerLazySingleton<GetProfileRepository>(() => GetProfileRepoImpl(sl()));
      sl.registerLazySingleton<FingerPrintRepository>(() => FingerPrintRepoImpl(sl()));
      sl.registerLazySingleton<ProductTypeRepository>(() => ProductTypeRepoImpl(sl()));
      sl.registerLazySingleton<PlanRepository>(() => PlanRepoImpl(sl()));
      sl.registerLazySingleton<ComplaintsRepository>(() => ComplaintsRepoImpl(sl()));
      sl.registerLazySingleton<GetBankRepository>(() => GetBankRepoImpl(sl()));
      sl.registerLazySingleton<WalletRequestRepository>(() => WalletRequestRepoImpl(sl()));
      sl.registerLazySingleton<AddStaffRepository>(() => AddStaffRepoImpl(sl()));
      sl.registerLazySingleton<StaffListRepository>(() => StaffListRepoImpl(sl()));
      sl.registerLazySingleton<PopupMessageRepository>(() => PopupMessageRepoImpl(sl()));
      sl.registerLazySingleton<EarningsRepository>(() => EarningsRepoImpl(sl()));
      sl.registerLazySingleton<CreditRepository>(() => CreditRepoImpl(sl()));
      sl.registerLazySingleton<SearchEarningsRepository>(() => SearchEarningsRepoImpl(sl()));
      sl.registerLazySingleton<SupportRepository>(() => SupportRepoImpl(sl()));
      sl.registerLazySingleton<SearchPlanRepository>(() => SearchPlanRepoImpl(sl()));
      sl.registerLazySingleton<PlanDetailRepository>(() => PlanDetailRepoImpl(sl()));
      sl.registerLazySingleton<TransConfirmRepository>(() => TransConfirmRepoImpl(sl()));
      sl.registerLazySingleton<MobileRechargeRepository>(() => MobileRechargeRepoImpl(sl()));
      sl.registerLazySingleton<SearchStaffRepository>(() => SearchStaffRepoImpl(sl()));
      sl.registerLazySingleton<PlanTabRepository>(() => PlanTabRepoImpl(sl()));
      sl.registerLazySingleton<TabDetailRepository>(() => TabdetailRepoImpl(sl()));





        //usecase
        sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
        sl.registerLazySingleton<OtpUsecase>(() => OtpUsecase(sl()));
        sl.registerLazySingleton<GetNewsUseCase>(() => GetNewsUseCase(sl()));
        sl.registerLazySingleton<CreatePinUsecase>(() => CreatePinUsecase(sl()));
        sl.registerLazySingleton<GetWalletBalanceUseCase>(() => GetWalletBalanceUseCase(sl()));
        sl.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(sl()));
        sl.registerLazySingleton<TransSucFailUsecase>(() => TransSucFailUsecase(sl()));
        sl.registerLazySingleton<FingerPrintUsecase>(() => FingerPrintUsecase(sl()));
        sl.registerLazySingleton<ProductTypeUseCase>(() => ProductTypeUseCase(sl()));
        sl.registerLazySingleton<PlanUseCase>(() => PlanUseCase(sl()));
        sl.registerLazySingleton<ComplaintsUseCase>(() => ComplaintsUseCase(sl()));
        sl.registerLazySingleton<GetBankUseCase>(() => GetBankUseCase(sl()));
        sl.registerLazySingleton<WalletRequestUsecase>(() => WalletRequestUsecase(sl()));
        sl.registerLazySingleton<AddStaffUsecase>(() => AddStaffUsecase(sl()));
        sl.registerLazySingleton<StaffListUseCase>(() => StaffListUseCase(sl()));
        sl.registerLazySingleton<GetPopupMessageUseCase>(() => GetPopupMessageUseCase(sl()));
        sl.registerLazySingleton<GetEarningsUseCase>(() => GetEarningsUseCase(sl()));
        sl.registerLazySingleton<GetCreditUseCase>(() => GetCreditUseCase(sl()));
        sl.registerLazySingleton<SearchEarningsUsecase>(() => SearchEarningsUsecase(sl()));
        sl.registerLazySingleton<GetSupportUsecase>(() => GetSupportUsecase(sl()));
        sl.registerLazySingleton<SearchPlanUsecase>(() => SearchPlanUsecase(sl()));
        sl.registerLazySingleton<PlanDetailUseCase>(() => PlanDetailUseCase(sl()));
        sl.registerLazySingleton<TransConfirmUseCase>(() => TransConfirmUseCase(sl()));
        sl.registerLazySingleton<MobileRechargeUsecase>(() => MobileRechargeUsecase(sl()));
        sl.registerLazySingleton<SearchStaffUsecase>(() => SearchStaffUsecase(sl()));
        sl.registerLazySingleton<PlanTabUseCase>(() => PlanTabUseCase(sl()));
        sl.registerLazySingleton<TabDetailUsecase>(() => TabDetailUsecase(sl()));
}