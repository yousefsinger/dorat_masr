import 'package:fpdart/fpdart.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
    : _remote = remoteDataSource;

  final AuthRemoteDataSource _remote;

  @override
  Future<Either<Failure, UserEntity>> login({
    required String email,
    required String password,
  }) {
    return _handle(() => _remote.login(email: email, password: password));
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _handle(
      () => _remote.register(
        fullName: fullName,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, Unit>> logout() {
    return _handle(() async {
      await _remote.logout();
      return unit;
    });
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() {
    return _handle(_remote.getCurrentUser);
  }

  Future<Either<Failure, T>> _handle<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } on AuthenticationException catch (e) {
      return Left(AuthFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (_) {
      return const Left(UnexpectedFailure(AppStrings.errorUnexpected));
    }
  }
}
