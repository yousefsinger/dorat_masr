import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/supabase_config.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> logout();

  /// Returns `null` when there is no active session.
  Future<UserModel?> getCurrentUser();
}

/// Talks directly to Supabase Auth and the `profiles` table.
/// Every Supabase error is translated into an [AppException].
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this._client});

  final SupabaseClient _client;

  @override
  Future<UserModel> login({required String email, required String password}) {
    return _guard(() async {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final user = response.user;
      if (user == null) {
        throw const AuthenticationException(AppStrings.errorInvalidCredentials);
      }
      return _fetchOrCreateProfile(user);
    });
  }

  @override
  Future<UserModel> register({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        // Read by the `handle_new_user` trigger to fill profiles.full_name.
        data: {'full_name': fullName},
      );
      final user = response.user;
      if (user == null) {
        throw const AuthenticationException(AppStrings.errorAuthGeneric);
      }
      // "Confirm email" is enabled in the Supabase project: no session until
      // the user clicks the link, so the profile cannot be read yet (RLS).
      if (response.session == null) {
        throw const AuthenticationException(
          AppStrings.errorEmailConfirmationSent,
        );
      }
      return _fetchOrCreateProfile(user, fullName: fullName);
    });
  }

  @override
  Future<void> logout() {
    return _guard(() => _client.auth.signOut());
  }

  @override
  Future<UserModel?> getCurrentUser() {
    return _guard(() async {
      final user = _client.auth.currentUser;
      if (user == null) return null;
      return _fetchOrCreateProfile(user);
    });
  }

  /// The profile row is normally created by the database trigger; this
  /// fallback covers projects where the trigger was not installed.
  Future<UserModel> _fetchOrCreateProfile(User user, {String? fullName}) async {
    final existing = await _client
        .from(SupabaseConfig.profilesTable)
        .select()
        .eq('id', user.id)
        .maybeSingle();

    if (existing != null) return UserModel.fromJson(existing);

    final created = await _client
        .from(SupabaseConfig.profilesTable)
        .insert({
          'id': user.id,
          'full_name':
              fullName ?? (user.userMetadata?['full_name'] as String?) ?? '',
          'email': user.email ?? '',
        })
        .select()
        .single();

    return UserModel.fromJson(created);
  }

  Future<T> _guard<T>(Future<T> Function() body) async {
    try {
      return await body();
    } on AppException {
      rethrow;
    } on AuthRetryableFetchException {
      throw const NetworkException(AppStrings.errorNetwork);
    } on AuthException catch (e) {
      throw AuthenticationException(_mapAuthError(e));
    } on PostgrestException {
      throw const ServerException(AppStrings.errorProfile);
    } catch (_) {
      throw const ServerException(AppStrings.errorUnexpected);
    }
  }

  String _mapAuthError(AuthException e) {
    switch (e.code) {
      case 'invalid_credentials':
        return AppStrings.errorInvalidCredentials;
      case 'email_not_confirmed':
        return AppStrings.errorEmailNotConfirmed;
      case 'user_already_exists':
      case 'email_exists':
        return AppStrings.errorUserAlreadyExists;
      case 'weak_password':
        return AppStrings.errorWeakPassword;
      case 'email_address_invalid':
        return AppStrings.errorInvalidEmail;
      case 'over_request_rate_limit':
      case 'over_email_send_rate_limit':
        return AppStrings.errorTooManyRequests;
    }
    // Older GoTrue servers don't send `code`.
    if (e.statusCode == '400' &&
        e.message.toLowerCase().contains('invalid login credentials')) {
      return AppStrings.errorInvalidCredentials;
    }
    if (e.statusCode == '429') return AppStrings.errorTooManyRequests;
    return AppStrings.errorAuthGeneric;
  }
}
