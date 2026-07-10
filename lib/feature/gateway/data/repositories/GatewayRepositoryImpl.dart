import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../domain/entities/EdgeGatewayEntity.dart';
import '../../domain/entities/IotDeviceEntity.dart';
import '../../domain/entities/SensorReadingEntity.dart';
import '../../domain/repositories/GatewayRepository.dart';
import '../datasource/GatewayRemoteDataSource.dart';

class GatewayRepositoryImpl implements GatewayRepository {
  final GatewayRemoteDataSource _dataSource;

  GatewayRepositoryImpl({required GatewayRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<EdgeGatewayEntity>>> getMyGateways() async {
    try {
      return Right(await _dataSource.getMyGateways());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<IotDeviceEntity>>> getGatewayDevices(String gatewayMac) async {
    try {
      return Right(await _dataSource.getGatewayDevices(gatewayMac));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<SensorReadingEntity>>> getDeviceReadings(String deviceMac) async {
    try {
      return Right(await _dataSource.getDeviceReadings(deviceMac));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
