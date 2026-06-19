import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/DashboardSummaryEntity.dart';
import '../repositories/DashboardRepository.dart';

class GetDashboardSummaryUseCase extends UseCase<DashboardSummaryEntity, NoParams> {
  final DashboardRepository _repository;
  GetDashboardSummaryUseCase(this._repository);

  @override
  Future<Either<Failure, DashboardSummaryEntity>> call(NoParams params) =>
      _repository.getDashboardSummary();
}
