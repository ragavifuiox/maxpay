import 'package:dartz/dartz.dart';
import 'package:maxpay/core/error/failure.dart';
import 'package:maxpay/core/data/repsoitory/profile_remote_data_source.dart';
import 'package:maxpay/core/data/model/profile_model.dart';
import 'package:maxpay/core/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final response = await remoteDataSource.getProfile();
      return Right(response);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await remoteDataSource.updateProfile(data);
      return Right(response);
    } catch (e) {
      if (e.toString().contains('Network Error')) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(ServerFailure(e is Exception ? e.toString().replaceFirst('Exception: ', '') : e.toString()));
    }
  }
}
