import 'package:flutter/material.dart';
import 'package:smart_task_manger/core/theme/app_colors.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';

/// Displays a centered loading indicator using the app's standard styling.
class AppLoader extends StatelessWidget {
  const AppLoader({
    super.key,
    this.size = AppSpacing.lg,
  });

  /// The size of the loading indicator.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: size,
        child: const CircularProgressIndicator(
          backgroundColor: AppColors.primary,
          strokeWidth: 2
        ),
      ),
    );
  }
}