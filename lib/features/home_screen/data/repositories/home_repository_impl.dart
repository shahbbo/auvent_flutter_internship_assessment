import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/home_item.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../datasources/home_local_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<HomeItem>>> getServices() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteServices = await remoteDataSource.getServices();
        await localDataSource.cacheServices(remoteServices);
        return Right(remoteServices);
      } on Exception catch (e) {
        return _handleException(e);
      }
    } else {
      try {
        final localServices = localDataSource.getCachedServices();
        return Right(localServices);
      } catch (_) {
        return Left(CacheFailure('No cached services found.'));
      }
    }
  }

  @override
  Future<Either<Failure, List<HomeItem>>> getAds() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteAds = await remoteDataSource.getAds();
        await localDataSource.cacheAds(remoteAds);
        return Right(remoteAds);
      } on Exception catch (e) {
        return _handleException(e);
      }
    } else {
      try {
        final localAds = localDataSource.getCachedAds();
        return Right(localAds);
      } catch (_) {
        return Left(CacheFailure('No cached ads found.'));
      }
    }
  }

  @override
  Future<Either<Failure, List<HomeItem>>> getRestaurants() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRestaurants = await remoteDataSource.getRestaurants();
        await localDataSource.cacheRestaurants(remoteRestaurants);
        return Right(remoteRestaurants);
      } on Exception catch (e) {
        return _handleException(e);
      }
    } else {
      try {
        final localRestaurants = localDataSource.getCachedRestaurants();
        return Right(localRestaurants);
      } catch (_) {
        return Left(CacheFailure('No cached restaurants found.'));
      }
    }
  }

  Either<Failure, List<HomeItem>> _handleException(Exception e) {
    if (e is AuthException) return Left(AuthFailure(e.message));
    if (e is ServerException) return Left(ServerFailure(e.message));
    if (e is NetworkException)
      return Left(NetworkFailure('Network error occurred.'));
    if (e is NotFoundFailureException)
      return Left(NotFoundFailure('Resource not found.'));
    return Left(ServerFailure('Unexpected error occurred.'));
  }
}
