abstract final class AppStrings {
  // App
  static const String appName = 'دورات مصر';
  static const String appTagline = 'فانتازي الدورات الشعبية';

  // Login
  static const String loginTitle = 'أهلاً بيك تاني!';
  static const String loginSubtitle = 'سجّل دخولك وكمّل تشكيلتك في الدورة';
  static const String loginButton = 'تسجيل الدخول';
  static const String noAccount = 'معندكش حساب؟';
  static const String createAccount = 'اعمل حساب جديد';

  // Register
  static const String registerTitle = 'انضم للدورة';
  static const String registerSubtitle = 'اعمل حسابك وابدأ كوّن فريق أحلامك';
  static const String registerButton = 'إنشاء الحساب';
  static const String haveAccount = 'عندك حساب بالفعل؟';
  static const String goToLogin = 'سجّل دخول';

  // Fields
  static const String fullNameLabel = 'الاسم بالكامل';
  static const String fullNameHint = 'مثال: محمد أحمد';
  static const String emailLabel = 'البريد الإلكتروني';
  static const String emailHint = 'name@example.com';
  static const String passwordLabel = 'كلمة المرور';
  static const String passwordHint = '8 حروف على الأقل';
  static const String confirmPasswordLabel = 'تأكيد كلمة المرور';
  static const String confirmPasswordHint = 'اكتب كلمة المرور تاني';

  // Validation
  static const String fullNameRequired = 'من فضلك اكتب اسمك';
  static const String fullNameTooShort = 'الاسم لازم يكون 3 حروف على الأقل';
  static const String emailRequired = 'من فضلك اكتب البريد الإلكتروني';
  static const String emailInvalid = 'البريد الإلكتروني غير صحيح';
  static const String passwordRequired = 'من فضلك اكتب كلمة المرور';
  static const String passwordTooShort =
      'كلمة المرور لازم تكون 8 حروف على الأقل';
  static const String passwordNeedsLetter =
      'كلمة المرور لازم تحتوي على حرف واحد على الأقل';
  static const String passwordNeedsDigit =
      'كلمة المرور لازم تحتوي على رقم واحد على الأقل';
  static const String confirmPasswordRequired = 'من فضلك أكد كلمة المرور';
  static const String passwordsDoNotMatch = 'كلمتين المرور مش متطابقين';

  // Errors
  static const String errorInvalidCredentials =
      'البريد الإلكتروني أو كلمة المرور غلط';
  static const String errorEmailNotConfirmed =
      'لازم تأكد بريدك الإلكتروني الأول';
  static const String errorUserAlreadyExists =
      'البريد الإلكتروني ده مسجل قبل كده';
  static const String errorWeakPassword = 'كلمة المرور ضعيفة، جرّب واحدة أقوى';
  static const String errorInvalidEmail = 'البريد الإلكتروني غير صالح';
  static const String errorTooManyRequests =
      'محاولات كتير، استنى شوية وجرّب تاني';
  static const String errorEmailConfirmationSent =
      'تم إنشاء الحساب! افتح بريدك الإلكتروني وأكد الحساب وبعدين سجّل دخول';
  static const String errorAuthGeneric =
      'حصلت مشكلة في تسجيل الدخول، حاول تاني';
  static const String errorProfile = 'مقدرناش نجيب بيانات حسابك، حاول تاني';
  static const String errorNetwork = 'تأكد من اتصالك بالإنترنت وحاول تاني';
  static const String errorUnexpected = 'حصل خطأ غير متوقع، حاول تاني';
  static const String errorSupabaseNotConfigured =
      'Supabase is not configured. Run with --dart-define-from-file=env.json '
      '(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY)';

  // Home
  static const String welcome = 'أهلاً،';
  static const String budget = 'الميزانية';
  static const String totalPoints = 'إجمالي النقاط';
  static const String currencySuffix = 'مليون';
  static const String pointsSuffix = 'نقطة';
  static const String logout = 'تسجيل الخروج';
}
