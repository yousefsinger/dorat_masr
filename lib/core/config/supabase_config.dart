/// Static Supabase settings.
///
/// The URL and publishable (anon) key are injected at build time so they
/// never live in source control:
///
/// flutter run --dart-define-from-file=env.json
///
/// env.json:
/// { "SUPABASE_URL": "https://xxxx.supabase.co", "SUPABASE_PUBLISHABLE_KEY": "sb_publishable_..." }
abstract final class SupabaseConfig {
  static const String url = String.fromEnvironment('SUPABASE_URL');
  static const String publishableKey = String.fromEnvironment(
    'SUPABASE_PUBLISHABLE_KEY',
  );

  static const String profilesTable = 'profiles';

  static bool get isConfigured => url.isNotEmpty && publishableKey.isNotEmpty;
}
