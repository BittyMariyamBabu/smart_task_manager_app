import 'package:flutter/material.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';

/// Displays an error message with an optional retry action.
class AppError extends StatelessWidget {
  const AppError({
    super.key,
    required this.message,
    this.onRetry,
  });

  /// The error message to display.
  final String message;

  /// Called when the user chooses to retry.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            message,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}