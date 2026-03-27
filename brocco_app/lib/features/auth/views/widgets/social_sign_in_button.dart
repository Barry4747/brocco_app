import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import '../../../../core/theme/app_colors.dart';

class SocialSignInButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const SocialSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryText),
            )
          : SignInButton(
              Buttons.google,
              text: 'Kontynuuj z Google',
              onPressed: onPressed ?? () {},
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(
                  color: AppColors.accentGreen,
                  width: 1.5,
                ),
              ),
            ),
    );
  }
}
