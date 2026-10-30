import 'package:dorat_masr/core/constants/app_strings.dart';
import 'package:dorat_masr/core/utils/validators.dart';
import 'package:dorat_masr/features/auth/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    test('email', () {
      expect(Validators.email(''), AppStrings.emailRequired);
      expect(Validators.email('ahmed@'), AppStrings.emailInvalid);
      expect(Validators.email(' ahmed@mail.com '), isNull);
    });

    test('password', () {
      expect(Validators.password(''), AppStrings.passwordRequired);
      expect(Validators.password('abc12'), AppStrings.passwordTooShort);
      expect(Validators.password('12345678'), AppStrings.passwordNeedsLetter);
      expect(Validators.password('abcdefgh'), AppStrings.passwordNeedsDigit);
      expect(Validators.password('abcd1234'), isNull);
    });

    test('confirmPassword', () {
      expect(
        Validators.confirmPassword('abcd1234', 'abcd12345'),
        AppStrings.passwordsDoNotMatch,
      );
      expect(Validators.confirmPassword('abcd1234', 'abcd1234'), isNull);
    });
  });

  group('UserModel', () {
    test('fromJson handles numeric budget as string or int', () {
      final fromString = UserModel.fromJson({
        'id': 'u1',
        'full_name': 'محمد',
        'email': 'm@mail.com',
        'budget': '100.0',
        'total_points': 12,
      });
      final fromInt = UserModel.fromJson({
        'id': 'u1',
        'full_name': 'محمد',
        'email': 'm@mail.com',
        'budget': 100,
        'total_points': 12,
      });
      expect(fromString, fromInt);
      expect(fromString.budget, 100.0);
      expect(fromString.toJson()['total_points'], 12);
    });
  });
}
