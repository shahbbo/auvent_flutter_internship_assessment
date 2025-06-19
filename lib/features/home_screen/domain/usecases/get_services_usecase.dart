import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/home_item.dart';
import '../repositories/home_repository.dart';

class GetServicesUseCase {
  final HomeRepository repository;

  GetServicesUseCase(this.repository);

  Future<Either<Failure, List<HomeItem>>> call() {
    return repository.getServices();
  }
}
