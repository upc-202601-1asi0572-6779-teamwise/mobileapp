import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/EdgeGatewayEntity.dart';
import '../repositories/GatewayRepository.dart';

class GetMyGatewaysUseCase extends UseCase<List<EdgeGatewayEntity>, NoParams> {
  final GatewayRepository _repository;
  GetMyGatewaysUseCase(this._repository);

  @override
  Future<Either<Failure, List<EdgeGatewayEntity>>> call(NoParams params) =>
      _repository.getMyGateways();
}
