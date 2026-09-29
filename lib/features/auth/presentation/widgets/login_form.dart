import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';
import 'package:smart_task_manger/core/theme/pp_validators.dart';
import 'package:smart_task_manger/features/auth/presentation/provider/auth_provider.dart';
import 'package:smart_task_manger/widgets/app_button.dart';
import 'package:smart_task_manger/widgets/app_text_field.dart';

/// Displays the login form and handles user authentication.
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Handles the login action when the user presses the login button.
  Future<void> _login() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ref.read(authProvider.notifier).login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _emailController,
            label: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.validateEmail,
          ),

          const SizedBox(height: AppSpacing.md),

          AppTextField(
            controller: _passwordController,
            label: 'Password',
            maxLines: 1,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            validator: AppValidators.validateLoginPassword,
            onToggleObscured: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // TODO: Navigate to forgot password.
              },
              child: const Text('Forgot password?'),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authProvider);
              return AppButton(
                isLoading: authState.isLoading,
                label: 'Login',
                onPressed: authState.isLoading ? null : _login,
              );
            }
          ),
        ],
      ),
    );
  }
}