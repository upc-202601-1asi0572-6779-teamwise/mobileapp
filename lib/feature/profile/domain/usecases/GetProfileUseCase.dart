import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/ProfileEntity.dart';
import '../repositories/ProfileRepository.dart';

class GetProfileUseCase extends UseCase<ProfileEntity, NoParams> {
  final ProfileRepository _repository;
  GetProfileUseCase(this._repository);

  @override
  Future<Either<Failure, ProfileEntity>> call(NoParams params) =>
      _repository.getProfile();
}
