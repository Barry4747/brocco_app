import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/buttons/main_back_button.dart';
import '../../auth/viewmodels/auth_viewmodel.dart';
import '../viewmodels/settings_viewmodel.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(settingsViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF2FAF5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  MainBackButton(onPressed: () => context.pop()),
                  const SizedBox(width: 16),
                  const Text(
                    'Ustawienia Kuchni',
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Premium Banner
              _buildPremiumBanner(),
              const SizedBox(height: 32),

              settingsAsync.when(
                data: (settings) {
                  if (settings == null) {
                    return const Center(child: Text('Błąd ładowania ustawień'));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section: Podczas gotowania
                      _buildSectionHeader('Podczas gotowania'),
                      _buildSectionCard([
                        _buildSwitchTile(
                          title: 'Ekran zawsze włączony',
                          subtitle: 'Nie gaś ekranu podczas gotowania',
                          value: settings.keepScreenOn,
                          onChanged: (val) => ref
                              .read(settingsActionProvider.notifier)
                              .updatePreference('keep_screen_on', val),
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          title: 'Alarmy timera',
                          subtitle: 'Dźwięk po zakończeniu odliczania',
                          value: settings.timerAlarms,
                          onChanged: (val) => ref
                              .read(settingsActionProvider.notifier)
                              .updatePreference('timer_alarms', val),
                        ),
                        _buildDivider(),
                        _buildSwitchTile(
                          title: 'Dźwięki maskotki',
                          subtitle: 'Brokułek komentuje Twoje postępy',
                          value: settings.mascotSounds,
                          onChanged: (val) => ref
                              .read(settingsActionProvider.notifier)
                              .updatePreference('mascot_sounds', val),
                        ),
                      ]),
                      const SizedBox(height: 32),

                      // Section: Preferencje
                      _buildSectionHeader('Preferencje'),
                      _buildSectionCard([
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Zasady dietetyczne',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Alergie, wegetarianizm i więcej',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.greyText,
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    // Placeholder for edit diet
                                  },
                                  icon: const Icon(Icons.lock_outline, size: 18),
                                  label: const Text('Edytuj diety'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryOrange,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                      const SizedBox(height: 32),

                      // Section: Konto
                      _buildSectionHeader('Konto'),
                      _buildSectionCard([
                        ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.accentGreen.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.refresh, color: AppColors.accentGreen),
                          ),
                          title: const Text(
                            'Przywróć zakupy',
                            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryText),
                          ),
                          subtitle: const Text(
                            'Odzyskaj subskrypcje Pro',
                            style: TextStyle(fontSize: 12, color: AppColors.greyText),
                          ),
                          trailing: const Icon(Icons.chevron_right, color: AppColors.greyText, size: 16),
                          onTap: () {},
                        ),
                      ]),
                    ],
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Błąd: $e')),
              ),

              const SizedBox(height: 40),

              // Logout Button
              Center(
                child: TextButton.icon(
                  onPressed: () => ref.read(authViewModelProvider.notifier).signOut(),
                  icon: const Icon(Icons.logout, color: Colors.redAccent),
                  label: const Text(
                    'Wyloguj się',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF7941D), Color(0xFFFFC200)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PREMIUM',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Odblokuj tryb Pro Chef',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Wszystkie światy kulinarne, bez limitów gwiazdek!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Uaktualnij',
              style: TextStyle(
                color: AppColors.accentGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryText,
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: AppColors.accentGreen.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.greyText,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.accentGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: AppColors.accentGreen.withOpacity(0.1),
      indent: 20,
      endIndent: 20,
    );
  }
}
