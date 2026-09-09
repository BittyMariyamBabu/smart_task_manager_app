import 'package:flutter/material.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';
import 'package:smart_task_manger/core/theme/app_typography.dart';

/// Displays a message when the device has no internet connection.
class AppNoInternet extends StatelessWidget {
  const AppNoInternet({
    super.key,
    this.onRetry,
  });

  /// Called when the user taps the retry button.
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.wifi_off_outlined,
            size: 48,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No internet connection',
            style: AppTypography.textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Please check your connection and try again.',
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