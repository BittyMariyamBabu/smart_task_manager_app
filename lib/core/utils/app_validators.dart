/// Provides reusable form validation methods used throughout the application.
abstract final class AppValidators {
  /// Validates an email address.
  ///
  /// Returns an error message when the email is empty or invalid.
  /// Returns `null` when the value is valid.
  static String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) return 'Enter your email';

    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }
  
  /// Validates login password.
  static String? validateLoginPassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter your password';

    return null;
  }

  /// Validates a sign up password.
  ///
  /// Requires at least one uppercase letter, one lowercase letter, 
  /// one number, and one special character.
  static String? validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) return 'Create a password';

    final strongPasswordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>_\-\\[\]~/])',
    );

    if (!strongPasswordRegex.hasMatch(password)) {
    return 'Password must contain uppercase, lowercase, number, and special character';
  }

    return null;
  }

  /// Validates a required name field.
  static String? validateName(String? value) {
    if ((value?.trim() ?? '').isEmpty) return 'Enter your name';

    return null;
  }

  /// Validates that a field contains a value.
  static String? validateField(String? value) {
    if ((value?.trim() ?? '').isEmpty) {
      return 'Enter your $value';
    }

    return null;
  }

  /// Validates that a confirmation password matches the original password.
  static String? confirmPassword(
    String? value,
    String password,
  ) {
    final confirmation = value ?? '';

    if (confirmation.isEmpty) return 'Re-enter your password';

    if (confirmation != password) return 'Passwords do not match';

    return null;
  }
}

