import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/ReportEntity.dart';
import '../repositories/ReportRepository.dart';

class GenerateReportParams extends Equatable {
  final ReportType type;
  final int? blockId;
  const GenerateReportParams({required this.type, this.blockId});
  @override
  List<Object?> get props => [type, blockId];
}

class GenerateReportUseCase extends UseCase<ReportEntity, GenerateReportParams> {
  final ReportRepository _repository;
  GenerateReportUseCase(this._repository);

  @override
  Future<Either<Failure, ReportEntity>> call(GenerateReportParams params) =>
      _repository.generateReport(params.type, blockId: params.blockId);
}
