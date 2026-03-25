import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/primary_button.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'widgets/auth_divider.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/social_sign_in_button.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeInOut);
    _fadeCtrl.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fadeCtrl.dispose();
    super.dispose();
  }

  void _switchMode() {
    _fadeCtrl.reverse().then((_) {
      setState(() => _isLogin = !_isLogin);
      _fadeCtrl.forward();
    });
  }

  Future<void> _handleEmailAction() async {
    if (!_formKey.currentState!.validate()) return;
    final vm = ref.read(authViewModelProvider.notifier);
    if (_isLogin) {
      await vm.signInWithEmail(_emailController.text.trim(), _passwordController.text);
    } else {
      await vm.signUpWithEmail(_emailController.text.trim(), _passwordController.text);
    }
    if (!mounted) return;
    _showErrorIfNeeded();
  }

  Future<void> _handleGoogleSignIn() async {
    await ref.read(authViewModelProvider.notifier).signInWithGoogle();
    if (!mounted) return;
    _showErrorIfNeeded();
  }

  void _showErrorIfNeeded() {
    final authState = ref.read(authViewModelProvider).valueOrNull;
    if (authState == null) return;
    if (authState.status == AuthStatus.error && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authState.errorMessage ?? 'Błąd logowania'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authAsync = ref.watch(authViewModelProvider);
    final isLoading = authAsync.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),

              // --- Logo / brand ---
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.primaryText,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                        child: Text(
                          '🥦',
                          style: TextStyle(fontSize: 38),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Brocco',
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Twój asystent w kuchni',
                      style: TextStyle(
                        color: AppColors.greyText,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // --- Animated mode title ---
              FadeTransition(
                opacity: _fadeAnim,
                child: Text(
                  _isLogin ? 'Zaloguj się' : 'Utwórz konto',
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // --- Google button ---
              SocialSignInButton(
                isLoading: isLoading,
                onPressed: isLoading ? null : _handleGoogleSignIn,
              ),
              const SizedBox(height: 24),

              // --- Divider ---
              const AuthDivider(),
              const SizedBox(height: 24),

              // --- Email/Password form ---
              FadeTransition(
                opacity: _fadeAnim,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthTextField(
                        label: 'Email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v == null || v.isEmpty) return 'Podaj email';
                          if (!v.contains('@')) return 'Nieprawidłowy email';
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      AuthTextField(
                        label: 'Hasło',
                        controller: _passwordController,
                        isPassword: true,
                        validator: (v) {
                          if (v == null || v.length < 6) return 'Hasło musi mieć min. 6 znaków';
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // --- Primary button ---
              PrimaryButton(
                text: _isLogin ? 'Zaloguj się' : 'Zarejestruj się',
                onPressed: isLoading ? null : _handleEmailAction,
              ),

              const SizedBox(height: 20),

              // --- Toggle login/register ---
              Center(
                child: GestureDetector(
                  onTap: isLoading ? null : _switchMode,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: AppColors.greyText),
                      children: [
                        TextSpan(
                          text: _isLogin
                              ? 'Nie masz konta? '
                              : 'Masz już konto? ',
                        ),
                        TextSpan(
                          text: _isLogin ? 'Zarejestruj się' : 'Zaloguj się',
                          style: const TextStyle(
                            color: AppColors.primaryText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
