import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../entities/ProfileEntity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile();
}
