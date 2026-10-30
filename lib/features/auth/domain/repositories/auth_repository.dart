import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  /// Returns `Right(null)` when there is no active session.
  Future<Either<Failure, UserEntity?>> getCurrentUser();
}
