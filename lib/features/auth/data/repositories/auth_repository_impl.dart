import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/local/hive_helper.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.login(email, password);
        final userBox = await HiveHelper.init<UserModel>(
          'user',
          adapter: UserModelAdapter(),
        );
        await userBox.add('user', userModel);
        return Right(userModel);
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      } on ServerException {
        return Left(ServerFailure(
          'Server error occurred while logging in.',
        ));
      } on NetworkException {
        return Left(NetworkFailure(
          'Network error occurred while logging in.',
        ));
      }
    } else {
      return Left(NetworkFailure(
        'No internet connection. Please check your network settings.',
      ));
    }
  }

  @override
  Future<Either<Failure, User>> signup(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.signup(email, password);
        final userBox = await HiveHelper.init<UserModel>(
          'user',
          adapter: UserModelAdapter(),
        );
        await userBox.add('user', userModel);
        return Right(userModel);
      } on AuthException catch (e) {
        return Left(AuthFailure(e.message));
      } on ServerException {
        return Left(ServerFailure(
          'Server error occurred while signing up.',
        ));
      } on NetworkException {
        return Left(NetworkFailure(
          'Network error occurred while signing up.',
        ));
      }
    } else {
      return Left(NetworkFailure(
        'No internet connection. Please check your network settings.',
      ));
    }
  }
}
