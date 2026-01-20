import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:savouge/core/utils/data/color_utils.dart';
import 'package:savouge/features/auth/presentation/create_account/create_account_screen.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/router.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../auth/presentation/login_flow/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: "#fff7f7".toColor(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Gap(16),
              Flexible(
                flex: 3,
                child: Image.asset(
                  "assets/images/Screenshot_2026-01-17_at_12.53.14_PM-removebg-preview.png",
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
              const Gap(12),
              _buildWelcomeSection(),
              const Gap(8),
              Flexible(
                flex: 4,
                child: _buildFeatureCards(),
              ),
              const Gap(8),
              _buildGetStartedButton(),
              const Gap(8),
              _buildSignInLink(),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextHolder(
          title: 'Welcome to Savouge',
          align: TextAlign.center,
          size: 28,
          fontWeight: FontWeight.w700,
          color: Colors.black,
          textStyle: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
        const Gap(8),
        TextHolder(
          title: 'Experience beauty and wellness like never before',
          align: TextAlign.center,
          size: 14,
          color: "#666D80".toColor(),
          fontHeight: 1.4,
        ),
      ],
    );
  }

  Widget _buildFeatureCards() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: _buildFeatureCard(
            iconPath: 'assets/images/calendar.png',
            title: 'Book Instantly',
            description: 'Schedule appointments 24/7',
          ),
        ),
        const Gap(8),
        Flexible(
          child: _buildFeatureCard(
            iconPath: 'assets/images/tiime.png',
            title: 'Track Treatments',
            description: 'View your beauty journey',
          ),
        ),
        const Gap(8),
        Flexible(
          child: _buildFeatureCard(
            iconPath: 'assets/images/reward.png',
            title: 'Earn Rewards',
            description: 'Get points with every visit',
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureCard({
    required String iconPath,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            fit: BoxFit.contain,
            height: 40,
            width: 40,
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextHolder(
                  title: title,
                  fontWeight: FontWeight.w600,
                  size: 15,
                  color: const Color(0xFF2D2D2D),
                ),
                TextHolder(
                  title: description,
                  size: 12,
                  color: Colors.grey.shade500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return CustomButtom(
      title: 'Get Started',
      btnColor: const Color(0xFFC5A35E),
      textColor: Colors.white,
      onTap: () {
        // Navigate to registration or home
        router.push(const CreateAccountScreen());
      },
    );
  }

  Widget _buildSignInLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextHolder(
          title: 'Already have an account? ',
          color: Colors.grey.shade600,
          size: 15,
        ),
        TextHolder(
          title: 'Sign in',
          color: const Color(0xFFC5A35E),
          fontWeight: FontWeight.bold,
          size: 15,
          onTap: () => router.push(const LoginScreen()),
        ),
      ],
    );
  }
}
