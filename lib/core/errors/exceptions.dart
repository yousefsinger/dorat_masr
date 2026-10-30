/// Exceptions are thrown by the data layer and converted into [Failure]s
/// by repository implementations. The message is already user-facing Arabic.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Supabase / database errors (PostgREST, unexpected responses).
class ServerException extends AppException {
  const ServerException(super.message);
}

/// Supabase Auth errors (wrong credentials, user exists, weak password...).
class AuthenticationException extends AppException {
  const AuthenticationException(super.message);
}

/// The request could not reach the server.
class NetworkException extends AppException {
  const NetworkException(super.message);
}
