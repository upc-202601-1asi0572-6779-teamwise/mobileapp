import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/ParcelaDetailEntity.dart';
import '../repositories/ParcelaRepository.dart';

class GetParcelaByIdParams extends Equatable {
  final int id;
  const GetParcelaByIdParams(this.id);
  @override
  List<Object?> get props => [id];
}

class GetParcelaByIdUseCase extends UseCase<ParcelaDetailEntity, GetParcelaByIdParams> {
  final ParcelaRepository _repository;
  GetParcelaByIdUseCase(this._repository);

  @override
  Future<Either<Failure, ParcelaDetailEntity>> call(GetParcelaByIdParams params) =>
      _repository.getParcelaById(params.id);
}
