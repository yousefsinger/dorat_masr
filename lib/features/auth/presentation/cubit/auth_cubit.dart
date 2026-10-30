import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _login = loginUseCase,
       _register = registerUseCase,
       _logout = logoutUseCase,
       _getCurrentUser = getCurrentUserUseCase,
       super(const AuthInitial());

  final LoginUseCase _login;
  final RegisterUseCase _register;
  final LogoutUseCase _logout;
  final GetCurrentUserUseCase _getCurrentUser;

  /// Called once on app start to restore a persisted session.
  Future<void> checkAuthStatus() async {
    final result = await _getCurrentUser(const NoParams());
    result.fold(
      (_) => emit(const Unauthenticated()),
      (user) =>
          emit(user == null ? const Unauthenticated() : Authenticated(user)),
    );
  }

  Future<void> login({required String email, required String password}) async {
    if (state is AuthLoading) return;
    emit(const AuthLoading());
    final result = await _login(LoginParams(email: email, password: password));
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    if (state is AuthLoading) return;
    emit(const AuthLoading());
    final result = await _register(
      RegisterParams(fullName: fullName, email: email, password: password),
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(Authenticated(user)),
    );
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    final result = await _logout(const NoParams());
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(const Unauthenticated()),
    );
  }
}
