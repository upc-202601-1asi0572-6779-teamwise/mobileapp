import 'package:dartz/dartz.dart';
import '../../../feature/core/error/Failure.dart';
import '../../../feature/core/usecases/UseCase.dart';
import '../entities/ReportEntity.dart';
import '../repositories/ReportRepository.dart';

class GetReportsUseCase extends UseCase<List<ReportEntity>, NoParams> {
  final ReportRepository _repository;
  GetReportsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ReportEntity>>> call(NoParams params) =>
      _repository.getReports();
}
