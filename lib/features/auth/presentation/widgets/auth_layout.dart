import 'package:flutter/material.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';

/// Provides the common layout used by authentication screens. 
/// 
/// Handles safe areas, scrolling, keyboard dismissal, responsive width 
/// constraints.
///
/// Authentication pages such as [LoginPage] and [RegisterPage] provide 
/// their form content through the [child] parameter while sharing the 
/// same overall layout.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.child,
    super.key,
  });

  /// The authentication form content displayed inside the layout.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              // used to automatically hide the keyboard when the user starts scrolling.
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 440,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.xl,
                    ),
                    child: child,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}