import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task_manger/core/theme/app_spacings.dart';
import 'package:smart_task_manger/core/utils/app_validators.dart';
import 'package:smart_task_manger/features/auth/presentation/provider/auth_provider.dart';
import 'package:smart_task_manger/widgets/app_button.dart';
import 'package:smart_task_manger/widgets/app_text_field.dart';

/// Displays the signup form and handles user authentication.
class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  /// Handles the signup action when the user presses the signup button.
  Future<void> _signup() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    ref.read(authProvider.notifier).signUp(
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
            controller: _nameController,
            label: 'Name',
            hintText: 'Enter your name',
            prefixIcon: Icons.person,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: AppValidators.validateName,
          ),

          const SizedBox(height: AppSpacing.md),

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
            validator: AppValidators.validatePassword,
            onToggleObscured: () => setState(
              () => _obscurePassword = !_obscurePassword,
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          AppTextField(
            controller: _confirmPasswordController,
            label: 'Confirm Password',
            maxLines: 1,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscureConfirmPassword,
            validator: (value) => AppValidators.confirmPassword(
              value, 
              _passwordController.text
            ),
            onToggleObscured: () => setState(() =>
                _obscureConfirmPassword = !_obscureConfirmPassword)
          ),

          const SizedBox(height: AppSpacing.sm),

          Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authProvider);
              return AppButton(
                isLoading: authState.isLoading,
                label: 'Sign Up',
                onPressed: authState.isLoading ? null : _signup,
              );
            }
          ),
        ],
      ),
    );
  }
}