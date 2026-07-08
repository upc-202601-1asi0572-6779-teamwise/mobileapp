import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/ParcelaEntity.dart';
import '../repositories/ParcelaRepository.dart';

class GetParcelasUseCase extends UseCase<List<ParcelaEntity>, NoParams> {
  final ParcelaRepository _repository;
  GetParcelasUseCase(this._repository);

  @override
  Future<Either<Failure, List<ParcelaEntity>>> call(NoParams params) =>
      _repository.getParcelas();
}
