import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../entities/EdgeGatewayEntity.dart';
import '../entities/IotDeviceEntity.dart';
import '../entities/SensorReadingEntity.dart';

abstract class GatewayRepository {
  /// Gateways del usuario autenticado (o todos, si es Administrator) —
  /// el backend decide el filtro a partir del JWT.
  Future<Either<Failure, List<EdgeGatewayEntity>>> getMyGateways();

  Future<Either<Failure, List<IotDeviceEntity>>> getGatewayDevices(String gatewayMac);

  Future<Either<Failure, List<SensorReadingEntity>>> getDeviceReadings(String deviceMac);
}
