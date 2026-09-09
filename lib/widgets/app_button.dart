import 'package:flutter/material.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';
import 'package:smart_task_manger/widgets/app_loader.dart';

/// A reusable primary action button with an optional icon and loading indicator.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false, 
    this.icon,
  });

  /// Called when the button is pressed.
  ///
  /// If [isLoading] is true, this callback is disabled.
  final VoidCallback? onPressed;

  /// The text displayed when the button is not loading.
  final String label;

    /// The optional icon displayed before the button label.
  final IconData? icon;

  /// Whether the button is currently performing an operation.
  ///
  /// When true, the button is disabled and displays a progress indicator.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
          ? AppLoader(size: AppSpacing.md)
          : icon == null
              ? Text(label)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(label),
                  ],
              ),
      ),
    );
  }
}