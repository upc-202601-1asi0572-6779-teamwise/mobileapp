import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/SectorEntity.dart';
import '../repositories/PlantationRepository.dart';

class PlantationIdParams extends Equatable {
  final int plantationId;
  const PlantationIdParams(this.plantationId);

  @override
  List<Object?> get props => [plantationId];
}

class GetPlantationDetailUseCase extends UseCase<PlantationDetailEntity, PlantationIdParams> {
  final PlantationRepository _repository;
  GetPlantationDetailUseCase(this._repository);

  @override
  Future<Either<Failure, PlantationDetailEntity>> call(PlantationIdParams params) =>
      _repository.getPlantationDetail(params.plantationId);
}
