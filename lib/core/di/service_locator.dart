import 'package:get_it/get_it.dart';
import 'package:maxpay/core/data/repsoitory/create_pin_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/finger_print_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/get_profile_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/login_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/news_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/otp_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/plan_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/product_type_repo_impl.dart';
import 'package:maxpay/core/data/repsoitory/trans_fsuc_fail.dart';
import 'package:maxpay/core/data/repsoitory/wallet_bal_repo_impl.dart';
import 'package:maxpay/core/domain/repository/create_pin_repository.dart';
import 'package:maxpay/core/domain/repository/finger_print_repository.dart';
import 'package:maxpay/core/domain/repository/get_profile_repository.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/repository/news_repository.dart';
import 'package:maxpay/core/domain/repository/otp_repository.dart';
import 'package:maxpay/core/domain/repository/plan_repository.dart';
import 'package:maxpay/core/domain/repository/product_type_repository.dart';
import 'package:maxpay/core/domain/repository/transaction_suc_fail_repository.dart';
import 'package:maxpay/core/domain/repository/wallet_bal_repository.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/finger_print_usecase.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/login_usecase.dart';
import 'package:maxpay/core/domain/usecase/news_usecase.dart';
import 'package:maxpay/core/domain/usecase/otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/plan_usecase.dart';
import 'package:maxpay/core/domain/usecase/product_type_usecase.dart';
import 'package:maxpay/core/domain/usecase/trans_suc_fail_usecase.dart';
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
}