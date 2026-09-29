import 'package:flutter/material.dart';

/// Provides standardized snackbar messages for the app.
abstract final class AppSnackbar {
  /// Displays a standard snackbar message.
  static void show(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  /// Displays a success snackbar.
  static void success(
    BuildContext context,
    String message,
  ) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_outline,
    );
  }

  /// Displays an error snackbar.
  static void error(
    BuildContext context,
    String message,
  ) {
    _show(
      context,
      message: message,
      icon: Icons.error_outline,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                icon,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(message),
              ),
            ],
          ),
        ),
      );
  }
}