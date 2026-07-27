import 'package:get_it/get_it.dart';
import 'package:maxpay/core/data/repsoitory/login_remote_data_source_impl.dart';
import 'package:maxpay/core/data/repsoitory/login_repository_impl.dart';
import 'package:maxpay/core/domain/repository/login_repository.dart';
import 'package:maxpay/core/domain/usecase/send_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/verify_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/create_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/verify_pin_usecase.dart';
import 'package:maxpay/core/domain/usecase/signup_send_otp_usecase.dart';
import 'package:maxpay/core/domain/usecase/logout_usecase.dart';
import 'package:maxpay/core/domain/usecase/update_fingerprint_usecase.dart';
import 'package:maxpay/controllers/auth/auth_controller.dart';
import 'package:maxpay/core/services/api_services.dart';

import 'package:maxpay/core/data/repsoitory/profile_remote_data_source.dart';
import 'package:maxpay/core/data/repsoitory/profile_repository_impl.dart';
import 'package:maxpay/core/domain/repository/profile_repository.dart';
import 'package:maxpay/core/domain/usecase/get_profile_usecase.dart';
import 'package:maxpay/core/domain/usecase/profile_update_usecase.dart';

import 'package:maxpay/core/data/repsoitory/wallet_remote_data_source.dart';
import 'package:maxpay/core/data/repsoitory/wallet_repository_impl.dart';
import 'package:maxpay/core/domain/repository/wallet_repository.dart';
import 'package:maxpay/core/domain/usecase/get_wallet_balance_usecase.dart';

import 'package:maxpay/core/data/repsoitory/support_remote_data_source.dart';
import 'package:maxpay/core/data/repsoitory/support_repository_impl.dart';
import 'package:maxpay/core/domain/repository/support_repository.dart';
import 'package:maxpay/core/domain/usecase/get_support_usecase.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Controllers
  sl.registerFactory(
    () => AuthController(
      sendOtpUseCase: sl(),
      verifyOtpUseCase: sl(),
      createPinUseCase: sl(),
      verifyPinUseCase: sl(),
      signupSendOtpUseCase: sl(),
      logoutUseCase: sl(),
      updateFingerprintUseCase: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SendOtpUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => CreatePinUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPinUseCase(sl()));
  sl.registerLazySingleton(() => SignupSendOtpUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => UpdateFingerprintUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => ProfileUpdateUseCase(sl()));
  sl.registerLazySingleton(() => GetWalletBalanceUseCase(sl()));
  sl.registerLazySingleton(() => GetSupportUseCase(sl()));

  // Repository
  sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<SupportRepository>(
    () => SupportRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(apiService: sl()),
  );
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiService: sl()),
  );
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(apiService: sl()),
  );
  sl.registerLazySingleton<SupportRemoteDataSource>(
    () => SupportRemoteDataSourceImpl(apiService: sl()),
  );

  // External
  sl.registerLazySingleton(() => ApiService());
}
