import 'package:get_it/get_it.dart';
import 'package:maxpay/core/data/repsoitory/delete_staff_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/active_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/add_kyc_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/add_staff_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/advertisement_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/all_plan_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/banner_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/cash_back_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/check_operator_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/compalint_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/confirm_dth_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/create_pin_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/credit_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/customer_info_repo_iml.dart';
import 'package:maxpay/core/data/repsoitory/dispute_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/download_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/dth_recharge_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/retailor_search_repo_impl.dart';
import 'package:maxpay/core/domain/repository/retailor_search_repository.dart';
import 'package:maxpay/core/domain/repository/bank_detail_repository.dart';
import 'package:maxpay/core/data/repsoitory/bank_detail_repoo_impl.dart';
import 'package:maxpay/core/domain/usecase/bank_detail_usecase.dart';
import 'package:maxpay/core/data/repsoitory/dth_tab_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/due_amount_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/earning_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/faq_reply_rep_impl.dart';
import 'package:maxpay/core/data/repsoitory/faq_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/finger_print_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/get_bank_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/get_kyc_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/get_profile_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/get_support_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/grade_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/graph_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/ip_address_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/login_history_impl.dart';
import 'package:maxpay/core/data/repsoitory/login_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/mobile_rehcarge_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/news_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/offer_recharge_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/otp_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/payment_status_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/payment_status_type_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/plan_detail_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/plan_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/plan_tab_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/popup_message_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/product_type_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/refund_count_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/refund_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/seach_dth_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/search_earning_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/search_plan_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/search_staff_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/staff_lsit_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/staff_wallet_reverse_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/statement_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/submit_dispute_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/tabdetail_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/today_credit_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/terms_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/today_transaction_repo_imppl.dart';
import 'package:maxpay/core/data/repsoitory/total_transaction_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/trans_confirm_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/trans_fsuc_fail.dart';
import 'package:maxpay/core/data/repsoitory/trans_report_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/update_otp_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/update_payment_status_impl.dart';
import 'package:maxpay/core/data/repsoitory/update_pin_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/update_profile_otp_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/update_profile_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/update_send_otp_impl.dart';
import 'package:maxpay/core/data/repsoitory/verify_pin_repo_Impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_bal_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_create_qr_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_credit_search_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_credit_type_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_report_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_request_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_transfer_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/wallet_trnasfer_detail_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/web_login_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/web_logout_repo_impl.dart';
import 'package:maxpay/core/domain/repository/active_user_reposiotry.dart';
import 'package:maxpay/core/domain/repository/delete_staff_repository.dart';
import 'package:maxpay/core/domain/repository/add_staff_repository.dart';
import 'package:maxpay/core/domain/repository/advertisement_repository.dart';
import 'package:maxpay/core/domain/repository/all_plan_repository.dart';
import 'package:maxpay/core/domain/repository/banner_repository.dart';
import 'package:maxpay/core/domain/repository/cash_back_repository.dart';
import 'package:maxpay/core/domain/repository/check_operator_repository.dart';
import 'package:maxpay/core/domain/repository/compalints_repository.dart';
import 'package:maxpay/core/domain/repository/confirm_dth_repository.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/domain/repository/credit_repository.dart';
import 'package:maxpay/core/domain/repository/customer_info_repository.dart';
import 'package:maxpay/core/domain/repository/dispute_repository.dart';
import 'package:maxpay/core/domain/repository/downlaod_repository.dart';
import 'package:maxpay/core/domain/repository/dth_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/dth_tab_repository.dart';
import 'package:maxpay/core/domain/repository/due_amount_repository.dart';
import 'package:maxpay/core/domain/repository/earning_repository.dart';
import 'package:maxpay/core/domain/repository/faq_reply_repository.dart';
import 'package:maxpay/core/domain/repository/faq_repsoitory.dart';
import 'package:maxpay/core/domain/repository/finger_print_repository.dart';
import 'package:maxpay/core/domain/repository/get_bank_repository.dart';
import 'package:maxpay/core/domain/repository/get_kyc_repository.dart';
import 'package:maxpay/core/domain/repository/get_profile_repository.dart';
import 'package:maxpay/core/domain/repository/grade_repository.dart';
import 'package:maxpay/core/domain/repository/graph_repository.dart';
import 'package:maxpay/core/domain/repository/ip_address_repository.dart';
import 'package:maxpay/core/domain/repository/kyc_repository.dart';
import 'package:maxpay/core/domain/repository/login_history_repository.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/repository/mobile_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/offer_recharge_repository.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/domain/repository/payment_status_type_repository.dart';
import 'package:maxpay/core/domain/repository/paymnet_status_repository.dart';
import 'package:maxpay/core/domain/repository/plan_detail_repository.dart';
import 'package:maxpay/core/domain/repository/plan_repository.dart';
import 'package:maxpay/core/domain/repository/plan_tab_repository.dart';
import 'package:maxpay/core/domain/repository/popup_message_repository.dart';
import 'package:maxpay/core/domain/repository/product_type_repository.dart';
import 'package:maxpay/core/domain/repository/profile_update_repository.dart';
import 'package:maxpay/core/domain/repository/refund_count_repository.dart';
import 'package:maxpay/core/domain/repository/refund_repository.dart';
import 'package:maxpay/core/domain/repository/search_dth_repository.dart';
import 'package:maxpay/core/domain/repository/search_earning_repository.dart';
import 'package:maxpay/core/domain/repository/search_plan_repository.dart';
import 'package:maxpay/core/domain/repository/search_staff_repository.dart';
import 'package:maxpay/core/domain/repository/staff_list_repository.dart';
import 'package:maxpay/core/domain/repository/staff_wallet_reverse_repository.dart';
import 'package:maxpay/core/domain/repository/statement_repository.dart';
import 'package:maxpay/core/domain/repository/submit_dsipute_repository.dart';
import 'package:maxpay/core/domain/repository/support_repository.dart';
import 'package:maxpay/core/domain/repository/tab_detail_repository.dart';
import 'package:maxpay/core/domain/repository/today_credit_repository.dart';
import 'package:maxpay/core/domain/repository/terms_repository.dart';
import 'package:maxpay/core/domain/repository/today_trnsaction_repsoitory.dart';
import 'package:maxpay/core/domain/repository/total_transaction_repository.dart';
import 'package:maxpay/core/domain/repository/trans_confirm_repository.dart';
import 'package:maxpay/core/domain/repository/trans_report_repository.dart';
import 'package:maxpay/core/domain/repository/transaction_suc_fail_repository.dart';
import 'package:maxpay/core/domain/repository/update_otp_repository.dart';
import 'package:maxpay/core/domain/repository/update_payment_status_repository.dart';
import 'package:maxpay/core/domain/repository/update_pin_repository.dart';
import 'package:maxpay/core/domain/repository/update_profile_otp_repository.dart';
import 'package:maxpay/core/domain/repository/update_send_otp_repository.dart';
import 'package:maxpay/core/domain/repository/verify_pin_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_create_qr_repo.dart';
import 'package:maxpay/core/domain/repository/wallet_credit_search_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_credit_type_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_report_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_request_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_transfer_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_trnsfer_detail_repository.dart';
import 'package:maxpay/core/domain/repository/web_login_repository.dart';
import 'package:maxpay/core/domain/repository/web_logout_repository.dart';
import 'package:maxpay/core/domain/usecase/active_user_usecase.dart';
import 'package:maxpay/core/domain/usecase/delete_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/addd_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/advertisement_usecase.dart';
import 'package:maxpay/core/domain/usecase/all_plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/banner_usecase.dart';
import 'package:maxpay/core/domain/usecase/cash_back_usecase.dart';
import 'package:maxpay/core/domain/usecase/check_operator_usecase.dart';
import 'package:maxpay/core/domain/usecase/complaints_usecase.dart';
import 'package:maxpay/core/domain/usecase/confirm_dth_usecase.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/credit_usecase.dart';
import 'package:maxpay/core/domain/usecase/customer_info_usecase.dart';
import 'package:maxpay/core/domain/usecase/dispute_usecase.dart';
import 'package:maxpay/core/domain/usecase/downlaod_usecase.dart';
import 'package:maxpay/core/domain/usecase/dth_recharge_usecase.dart';
import 'package:maxpay/core/domain/usecase/dth_tab_usecase.dart';
import 'package:maxpay/core/domain/usecase/due_amount_usecase.dart';
import 'package:maxpay/core/domain/usecase/earning_usecase.dart';
import 'package:maxpay/core/domain/usecase/faq_reply_usecase.dart';
import 'package:maxpay/core/domain/usecase/faq_usecase.dart';
import 'package:maxpay/core/domain/usecase/finger_print_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_bank_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_kyc_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_support_usecase.dart';
import 'package:maxpay/core/domain/usecase/grade_usecase.dart';
import 'package:maxpay/core/domain/usecase/graph_usecase.dart';
import 'package:maxpay/core/domain/usecase/ip_address_usecase.dart';
import 'package:maxpay/core/domain/usecase/kyc_usecase.dart';
import 'package:maxpay/core/domain/usecase/login_history_usecase.dart';
import 'package:maxpay/core/domain/usecase/login_usecase.dart';
import 'package:maxpay/core/domain/usecase/mobile_recharge_usecase.dart';
import 'package:maxpay/core/domain/usecase/news_usecase.dart';
import 'package:maxpay/core/domain/usecase/offer_rechdarge_usecase.dart';
import 'package:maxpay/core/domain/usecase/otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/payment_status_type_usecase.dart';
import 'package:maxpay/core/domain/usecase/payment_status_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_tab_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/popup_message_usecase.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';
import 'package:maxpay/core/domain/usecase/profile_update_usecase.dart';
import 'package:maxpay/core/domain/usecase/refund_count_usecase.dart';
import 'package:maxpay/core/domain/usecase/refund_usecase.dart';
import 'package:maxpay/core/domain/usecase/retailor_search_usecase.dart';
import 'package:maxpay/core/domain/usecase/satff_wallet_reverse_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_dth_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_earnings_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/search_staff_usecase.dart';
import 'package:maxpay/core/domain/usecase/staff_list_usecase.dart';
import 'package:maxpay/core/domain/usecase/statment_usecase.dart';
import 'package:maxpay/core/domain/usecase/submit_dispute_usecase.dart';
import 'package:maxpay/core/domain/usecase/tab_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/today_credit_usecase.dart';
import 'package:maxpay/core/domain/usecase/terms_usecase.dart';
import 'package:maxpay/core/domain/usecase/today_trnsaction_usecase.dart';
import 'package:maxpay/core/domain/usecase/total_transaction_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_confirm_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_report_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_suc_fail_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_payment_status_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_profile_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_send_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/verify_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_create_qr_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_credit_search_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_credit_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_report_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_request_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_transfer_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_trnasfer_detail_usecase.dart';
import 'package:maxpay/core/domain/usecase/wallet_usecase.dart';
import 'package:maxpay/core/domain/usecase/web_login_usecase.dart';
import 'package:maxpay/core/domain/usecase/web_logout_usecase.dart';
import 'package:maxpay/core/services/api_services.dart';
import 'package:maxpay/core/services/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  /*-------------------       SHARED PREFERENCES     --------------------------*/
  final prefs = await SharedPreferences.getInstance();
  await LocalStorageService().init();
  if (!sl.isRegistered<SharedPreferences>()) {
    sl.registerSingleton<SharedPreferences>(prefs);
  }

  /*-------------------       CORE SERVICES   --------------------------*/
  if (!sl.isRegistered<ApiService>()) {
    sl.registerLazySingleton(() => ApiService());
  }

  sl.registerLazySingleton<ActiveUserRepository>(() => ActiveRepoImpl(sl()));
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(sl()));
  sl.registerLazySingleton<OtpRepository>(() => OtpRepoImpl(sl()));
  sl.registerLazySingleton<GetNewsRepository>(() => GetNewsRepoImpl(sl()));
  sl.registerLazySingleton<CreatePinRepository>(() => CreatePinRepoImpl(sl()));
  sl.registerLazySingleton<WalletBalanceRepository>(
    () => WalletBalanceRepoImpl(sl()),
  );
  sl.registerLazySingleton<TransactionSucFailRepository>(
    () => TransactionSucFailRepoImpl(sl()),
  );
  sl.registerLazySingleton<TodayTrnsactionRepsoitory>(
    () => TodayTransactionRepoImppl(sl()),
  );

  sl.registerLazySingleton<CheckOperatorRepository>(
    () => CheckOperatorRepoImpl(sl()),
  );

  sl.registerLazySingleton<DownloadRepository>(() => DownloadRepoImpl(sl()));
  sl.registerLazySingleton<RetailorSearchRepository>(
    () => RetailorSearchRepoImpl(sl()),
  );

  sl.registerLazySingleton<GetProfileRepository>(
    () => GetProfileRepoImpl(sl()),
  );
  sl.registerLazySingleton<FingerPrintRepository>(
    () => FingerPrintRepoImpl(sl()),
  );
  sl.registerLazySingleton<ProductTypeRepository>(
    () => ProductTypeRepoImpl(sl()),
  );
  sl.registerLazySingleton<PlanRepository>(() => PlanRepoImpl(sl()));
  sl.registerLazySingleton<ComplaintsRepository>(
    () => ComplaintsRepoImpl(sl()),
  );
  sl.registerLazySingleton<GetBankRepository>(() => GetBankRepoImpl(sl()));
  sl.registerLazySingleton<WalletRequestRepository>(
    () => WalletRequestRepoImpl(sl()),
  );
  sl.registerLazySingleton<AddStaffRepository>(() => AddStaffRepoImpl(sl()));
  sl.registerLazySingleton<DeleteStaffRepository>(
    () => DeleteStaffRepoImpl(sl()),
  );
  sl.registerLazySingleton<StaffListRepository>(() => StaffListRepoImpl(sl()));
  sl.registerLazySingleton<PopupMessageRepository>(
    () => PopupMessageRepoImpl(sl()),
  );
  sl.registerLazySingleton<BankDetailRepository>(
    () => BankDetailRepooImpl(sl()),
  );

  sl.registerLazySingleton<UpdateProfileOtpRepository>(
    () => UpdateProfileOtpRepoImpl(sl()),
  );
  sl.registerLazySingleton<EarningsRepository>(() => EarningsRepoImpl(sl()));
  sl.registerLazySingleton<CreditRepository>(() => CreditRepoImpl(sl()));
  sl.registerLazySingleton<SearchEarningsRepository>(
    () => SearchEarningsRepoImpl(sl()),
  );
  sl.registerLazySingleton<SupportRepository>(() => SupportRepoImpl(sl()));
  sl.registerLazySingleton<SearchPlanRepository>(
    () => SearchPlanRepoImpl(sl()),
  );
  sl.registerLazySingleton<PlanDetailRepository>(
    () => PlanDetailRepoImpl(sl()),
  );
  sl.registerLazySingleton<TransConfirmRepository>(
    () => TransConfirmRepoImpl(sl()),
  );
  sl.registerLazySingleton<MobileRechargeRepository>(
    () => MobileRechargeRepoImpl(sl()),
  );
  sl.registerLazySingleton<SearchStaffRepository>(
    () => SearchStaffRepoImpl(sl()),
  );

  sl.registerLazySingleton<OfferRechargeRepository>(
    () => OfferRechargeRepoImpl(sl()),
  );

  sl.registerLazySingleton<PlanTabRepository>(() => PlanTabRepoImpl(sl()));
  sl.registerLazySingleton<TabDetailRepository>(() => TabdetailRepoImpl(sl()));
  sl.registerLazySingleton<KycRepository>(() => AddKycRepoImpl(sl()));
  sl.registerLazySingleton<VerifyPinRepository>(() => VerifyPinRepoImpl(sl()));
  sl.registerLazySingleton<DthTabRepository>(() => DthTabRepoImpl(sl()));
  sl.registerLazySingleton<SearchDthRepository>(() => SearchDthRepoImpl(sl()));
  sl.registerLazySingleton<DueAmountRepository>(() => DueAmountRepoImpl(sl()));
  sl.registerLazySingleton<GraphRepository>(() => GraphRepoImpl(sl()));
  sl.registerLazySingleton<TotalTransactionRepsoitory>(
    () => TotalTransactionRepoImppl(sl()),
  );

  sl.registerLazySingleton<ConfirmDthRepository>(
    () => ConfirmDthRepoImpl(sl()),
  );

  sl.registerLazySingleton<DthRechargeRepository>(
    () => DthRechargeRepoImpl(sl()),
  );

  sl.registerLazySingleton<GetKycRepository>(() => GetKycRepoImpl(sl()));
  sl.registerLazySingleton<TransReportRepository>(
    () => TransReportRepoImpl(sl()),
  );

  sl.registerLazySingleton<GradeRepository>(() => GradeRepoImpl(sl()));
  sl.registerLazySingleton<DisputeRepository>(() => DisputeRepoImpl(sl()));
  sl.registerLazySingleton<PaymnetStatusRepository>(
    () => PaymentStatusRepoImpl(sl()),
  );

  sl.registerLazySingleton<RefundRepository>(() => RefundRepoImpl(sl()));
  sl.registerLazySingleton<AllPlanRepository>(() => AllPlanRepoImpl(sl()));
  sl.registerLazySingleton<UpdatePinRepository>(() => UpdatePinRepoImpl(sl()));
  sl.registerLazySingleton<WalletCreditSearchRepository>(
    () => WalletCreditSearchRepoImpl(sl()),
  );

  sl.registerLazySingleton<WalletCreditTypeRepository>(
    () => WalletCreditTypeRepoImpl(sl()),
  );
  sl.registerLazySingleton<SubmitDsiputeRepository>(
    () => SubmitDisputeRepoImpl(sl()),
  );
  sl.registerLazySingleton<WalletTransferRepository>(
    () => WalletTransferRepoImpl(sl()),
  );
  sl.registerLazySingleton<WalletReportRepository>(
    () => WalletReportRepoImpl(sl()),
  );

  sl.registerLazySingleton<FaqReplyRepository>(() => FaqReplyRepImpl(sl()));
  sl.registerLazySingleton<ProfileUpdateRepository>(
    () => UpdateProfileRepoImpl(sl()),
  );
  sl.registerLazySingleton<StatementRepository>(() => StatementRepoImpl(sl()));
  sl.registerLazySingleton<BannerRepository>(() => BannerRepoImpl(sl()));
  sl.registerLazySingleton<AdvertisementRepository>(
    () => AdvertisementRepoImpl(sl()),
  );
  sl.registerLazySingleton<IpAddressRepository>(() => IpAddressRepoImpl(sl()));
  sl.registerLazySingleton<LoginHistoryRepository>(
    () => LoginHistoryImpl(sl()),
  );
  sl.registerLazySingleton<WebLoginRepository>(() => WebLoginRepoImpl(sl()));
  sl.registerLazySingleton<CashBackRepository>(() => CashBackRepoImpl(sl()));
  sl.registerLazySingleton<WebLogoutRepository>(() => WebLogoutRepoImpl(sl()));
  sl.registerLazySingleton<RefundCountRepository>(
    () => RefundCountRepoImpl(sl()),
  );
  sl.registerLazySingleton<TodayCreditRepository>(
    () => TodayCreditRepoImpl(sl()),
  );
  sl.registerLazySingleton<TermsRepository>(() => TermsRepoImpl(sl()));
  sl.registerLazySingleton<CustomerInfoRepository>(
    () => CustomerInfoRepoImpl(sl()),
  );
  sl.registerLazySingleton<UpdateSendOtpRepository>(
    () => UpdateSendOtpImpl(sl()),
  );
  sl.registerLazySingleton<UpdateOtpRepository>(() => UpdateOtpRepoImpl(sl()));
  sl.registerLazySingleton<CashbackTypeRepository>(
    () => CashbackTypeRepoImpl(sl()),
  );
  sl.registerLazySingleton<FaqRepsoitory>(() => FaqRepoImpl(sl()));
  sl.registerLazySingleton<UpdatePaymentStatusRepository>(
    () => UpdatePaymentStatusImpl(sl()),
  );
  sl.registerLazySingleton<WalletTrnsferDetailRepository>(
    () => WalletTrnasferDetailRepoImpl(sl()),
  );
  sl.registerLazySingleton<StaffWalletReverseRepository>(
    () => StaffWalletReverseRepoImpl(sl()),
  );

  sl.registerLazySingleton<WalletCreateQrRepo>(
    () => WalletCreateQrRepoImpl(sl()),
  );

  /*-------------------       USECASE    ---------------------------------*/
  sl.registerLazySingleton<ActiveUserUsecase>(() => ActiveUserUsecase(sl()));
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerLazySingleton<OtpUsecase>(() => OtpUsecase(sl()));
  sl.registerLazySingleton<GetNewsUseCase>(() => GetNewsUseCase(sl()));
  sl.registerLazySingleton<CreatePinUsecase>(() => CreatePinUsecase(sl()));
  sl.registerLazySingleton<DueAmountUsecase>(() => DueAmountUsecase(sl()));
  sl.registerLazySingleton<UpdateProfileOtpUsecase>(
    () => UpdateProfileOtpUsecase(sl()),
  );
  sl.registerLazySingleton<GetWalletBalanceUseCase>(
    () => GetWalletBalanceUseCase(sl()),
  );
  sl.registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton<TransSucFailUsecase>(
    () => TransSucFailUsecase(sl()),
  );
  sl.registerLazySingleton<FingerPrintUsecase>(() => FingerPrintUsecase(sl()));
  sl.registerLazySingleton<ProductTypeUseCase>(() => ProductTypeUseCase(sl()));
  sl.registerLazySingleton<PlanUseCase>(() => PlanUseCase(sl()));
  sl.registerLazySingleton<ComplaintsUseCase>(() => ComplaintsUseCase(sl()));
  sl.registerLazySingleton<GetBankUseCase>(() => GetBankUseCase(sl()));
  sl.registerLazySingleton<WalletRequestUsecase>(
    () => WalletRequestUsecase(sl()),
  );
  sl.registerLazySingleton<AddStaffUsecase>(() => AddStaffUsecase(sl()));
  sl.registerLazySingleton<DeleteStaffUsecase>(() => DeleteStaffUsecase(sl()));
  sl.registerLazySingleton<StaffListUseCase>(() => StaffListUseCase(sl()));
  sl.registerLazySingleton<StaffTrnsTeportListUseCase>(
    () => StaffTrnsTeportListUseCase(sl()),
  );
  sl.registerLazySingleton<GetPopupMessageUseCase>(
    () => GetPopupMessageUseCase(sl()),
  );
  sl.registerLazySingleton<BankDetailUsecase>(() => BankDetailUsecase(sl()));
  sl.registerLazySingleton<RetailorSearchUsecase>(
    () => RetailorSearchUsecase(sl()),
  );
  sl.registerLazySingleton<GetEarningsUseCase>(() => GetEarningsUseCase(sl()));
  sl.registerLazySingleton<GetCreditUseCase>(() => GetCreditUseCase(sl()));
  sl.registerLazySingleton<SearchEarningsUsecase>(
    () => SearchEarningsUsecase(sl()),
  );
  sl.registerLazySingleton<GetSupportUsecase>(() => GetSupportUsecase(sl()));
  sl.registerLazySingleton<TotalTransactionUsecase>(
    () => TotalTransactionUsecase(sl()),
  );
  sl.registerLazySingleton<SearchPlanUsecase>(() => SearchPlanUsecase(sl()));
  sl.registerLazySingleton<PlanDetailUseCase>(() => PlanDetailUseCase(sl()));
  sl.registerLazySingleton<TransConfirmUseCase>(
    () => TransConfirmUseCase(sl()),
  );
  sl.registerLazySingleton<MobileRechargeUsecase>(
    () => MobileRechargeUsecase(sl()),
  );
  sl.registerLazySingleton<SearchStaffUsecase>(() => SearchStaffUsecase(sl()));
  sl.registerLazySingleton<TodayTrnsactionUsecase>(
    () => TodayTrnsactionUsecase(sl()),
  );
  sl.registerLazySingleton<PlanTabUseCase>(() => PlanTabUseCase(sl()));
  sl.registerLazySingleton<TabDetailUsecase>(() => TabDetailUsecase(sl()));
  sl.registerLazySingleton<AddKycUsecase>(() => AddKycUsecase(sl()));
  sl.registerLazySingleton<VerifyPinUsecase>(() => VerifyPinUsecase(sl()));
  sl.registerLazySingleton<DthTabUsecase>(() => DthTabUsecase(sl()));
  sl.registerLazySingleton<CheckOperatorUsecase>(
    () => CheckOperatorUsecase(sl()),
  );
  sl.registerLazySingleton<SearchDthUsecase>(() => SearchDthUsecase(sl()));
  sl.registerLazySingleton<ConfirmDthUsecase>(() => ConfirmDthUsecase(sl()));
  sl.registerLazySingleton<DthRechargeUsecase>(() => DthRechargeUsecase(sl()));
  sl.registerLazySingleton<GetKycUsecase>(() => GetKycUsecase(sl()));
  sl.registerLazySingleton<TransReportUsecase>(() => TransReportUsecase(sl()));
  sl.registerLazySingleton<GradeUsecase>(() => GradeUsecase(sl()));
  sl.registerLazySingleton<DisputeUsecase>(() => DisputeUsecase(sl()));
  sl.registerLazySingleton<RefundCountUsecase>(() => RefundCountUsecase(sl()));
  sl.registerLazySingleton<UpdateSendOtpUsecase>(
    () => UpdateSendOtpUsecase(sl()),
  );
  sl.registerLazySingleton<UpdateOtpUsecase>(() => UpdateOtpUsecase(sl()));
  sl.registerLazySingleton<SatffWalletReverseUsecase>(
    () => SatffWalletReverseUsecase(sl()),
  );
  sl.registerLazySingleton<PaymentStatusUsecase>(
    () => PaymentStatusUsecase(sl()),
  );
  sl.registerLazySingleton<RefundUsecase>(() => RefundUsecase(sl()));
  sl.registerLazySingleton<AllPlanUsecase>(() => AllPlanUsecase(sl()));
  sl.registerLazySingleton<UpdatePinUsecase>(() => UpdatePinUsecase(sl()));
  sl.registerLazySingleton<OfferRechargeUsecase>(
    () => OfferRechargeUsecase(sl()),
  );
  sl.registerLazySingleton<CustomerInfoUsecase>(
    () => CustomerInfoUsecase(sl()),
  );
  sl.registerLazySingleton<GraphUsecase>(() => GraphUsecase(sl()));
  sl.registerLazySingleton<FaqUsecase>(() => FaqUsecase(sl()));
  sl.registerLazySingleton<WalletCreditSearchUsecase>(
    () => WalletCreditSearchUsecase(sl()),
  );
  sl.registerLazySingleton<WalletCreditTypeUsecase>(
    () => WalletCreditTypeUsecase(sl()),
  );
  sl.registerLazySingleton<SubmitDisputeUsecase>(
    () => SubmitDisputeUsecase(sl()),
  );
  sl.registerLazySingleton<WalletTransferUsecase>(
    () => WalletTransferUsecase(sl()),
  );
  sl.registerLazySingleton<WalletReportUsecase>(
    () => WalletReportUsecase(sl()),
  );
  
  sl.registerLazySingleton<ProfileUpdateUsecase>(
    () => ProfileUpdateUsecase(sl()),
  );
  sl.registerLazySingleton<DownloadUsecase>(() => DownloadUsecase(sl()));
  sl.registerLazySingleton<FaqReplyUsecase>(() => FaqReplyUsecase(sl()));

  sl.registerLazySingleton<StatementUsecase>(() => StatementUsecase(sl()));
  sl.registerLazySingleton<BannerUsecase>(() => BannerUsecase(sl()));
  sl.registerLazySingleton<AdvertisementUsecase>(
    () => AdvertisementUsecase(sl()),
  );
  sl.registerLazySingleton<IpAddressUsecase>(() => IpAddressUsecase(sl()));
  sl.registerLazySingleton<LoginHistoryUsecase>(
    () => LoginHistoryUsecase(sl()),
  );

  sl.registerLazySingleton<WebLoginUsecase>(() => WebLoginUsecase(sl()));
  sl.registerLazySingleton<CashBackUsecase>(() => CashBackUsecase(sl()));
  sl.registerLazySingleton<WebLogoutUsecase>(() => WebLogoutUsecase(sl()));
  sl.registerLazySingleton<CashbackTypeUsecase>(
    () => CashbackTypeUsecase(sl()),
  );
  sl.registerLazySingleton<UpdatePaymentStatusUsecase>(
    () => UpdatePaymentStatusUsecase(sl()),
  );
  sl.registerLazySingleton<WalletTrnasferDetailUsecase>(
    () => WalletTrnasferDetailUsecase(sl()),
  );
  sl.registerLazySingleton<WalletCreateQrUsecase>(
    () => WalletCreateQrUsecase(sl()),
  );
  sl.registerLazySingleton<TermsUsecase>(() => TermsUsecase(sl()));
  sl.registerLazySingleton<TodayCreditUsecase>(() => TodayCreditUsecase(sl()));
  // sl.registerLazySingleton<GetPrivacyPolicyUseCase>(
  //   () => GetPrivacyPolicyUseCase(sl()),
  // );
}
