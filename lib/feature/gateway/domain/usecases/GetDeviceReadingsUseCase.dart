import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/SensorReadingEntity.dart';
import '../repositories/GatewayRepository.dart';

class DeviceMacParams extends Equatable {
  final String deviceMac;
  const DeviceMacParams(this.deviceMac);

  @override
  List<Object?> get props => [deviceMac];
}

class GetDeviceReadingsUseCase extends UseCase<List<SensorReadingEntity>, DeviceMacParams> {
  final GatewayRepository _repository;
  GetDeviceReadingsUseCase(this._repository);

  @override
  Future<Either<Failure, List<SensorReadingEntity>>> call(DeviceMacParams params) =>
      _repository.getDeviceReadings(params.deviceMac);
}
