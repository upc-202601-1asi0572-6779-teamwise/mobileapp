import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/SensorEntity.dart';
import '../repositories/SensorRepository.dart';

class GetSensorsUseCase extends UseCase<List<SensorEntity>, NoParams> {
  final SensorRepository _repository;
  GetSensorsUseCase(this._repository);

  @override
  Future<Either<Failure, List<SensorEntity>>> call(NoParams params) =>
      _repository.getSensors();
}
