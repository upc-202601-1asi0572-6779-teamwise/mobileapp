import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/PlantationEntity.dart';
import '../repositories/PlantationRepository.dart';

class GetMyPlantationsUseCase extends UseCase<List<PlantationEntity>, NoParams> {
  final PlantationRepository _repository;
  GetMyPlantationsUseCase(this._repository);

  @override
  Future<Either<Failure, List<PlantationEntity>>> call(NoParams params) =>
      _repository.getMyPlantations();
}
