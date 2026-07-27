import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/repsoitory/support_remote_data_source.dart';
import 'package:maxpay/core/data/model/support_model.dart';
import 'package:maxpay/core/domain/repository/support_repository.dart';

class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteDataSource remoteDataSource;

  SupportRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SupportModel>> getSupport() async {
    try {
      final response = await remoteDataSource.getSupport();
      return Right(response);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }
}
