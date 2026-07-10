import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/IotDeviceEntity.dart';
import '../repositories/GatewayRepository.dart';

class GatewayMacParams extends Equatable {
  final String gatewayMac;
  const GatewayMacParams(this.gatewayMac);

  @override
  List<Object?> get props => [gatewayMac];
}

class GetGatewayDevicesUseCase extends UseCase<List<IotDeviceEntity>, GatewayMacParams> {
  final GatewayRepository _repository;
  GetGatewayDevicesUseCase(this._repository);

  @override
  Future<Either<Failure, List<IotDeviceEntity>>> call(GatewayMacParams params) =>
      _repository.getGatewayDevices(params.gatewayMac);
}
