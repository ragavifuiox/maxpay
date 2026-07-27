import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/repsoitory/wallet_remote_data_source.dart';
import 'package:maxpay/core/data/model/wallet_balance_model.dart';
import 'package:maxpay/core/domain/repository/wallet_repository.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, WalletBalanceModel>> getWalletBalance() async {
    try {
      final response = await remoteDataSource.getWalletBalance();
      return Right(response);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }
}
