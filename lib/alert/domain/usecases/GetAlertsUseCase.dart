import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/AlertEntity.dart';
import '../repositories/AlertRepository.dart';

class GetAlertsUseCase extends UseCase<List<AlertEntity>, NoParams> {
  final AlertRepository _repository;
  GetAlertsUseCase(this._repository);

  @override
  Future<Either<Failure, List<AlertEntity>>> call(NoParams params) =>
      _repository.getAlerts();
}
