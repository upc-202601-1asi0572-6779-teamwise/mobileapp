import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/Failure.dart';
import '../../../core/usecases/UseCase.dart';
import '../entities/AuthUserEntity.dart';
import '../repositories/AuthRepository.dart';

class SignInParams extends Equatable {
  final String username;
  final String password;
  const SignInParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class SignInUseCase extends UseCase<AuthUserEntity, SignInParams> {
  final AuthRepository _repository;
  SignInUseCase(this._repository);

  @override
  Future<Either<Failure, AuthUserEntity>> call(SignInParams params) =>
      _repository.signIn(username: params.username, password: params.password);
}
