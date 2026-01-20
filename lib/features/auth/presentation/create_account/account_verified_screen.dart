import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:savouge/core/presentation/widgets/router.dart';
import 'package:savouge/features/auth/presentation/create_account/complete_profile_screen.dart';
import '../../../../core/presentation/widgets/app_bar.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../../core/utils/data/color_utils.dart';

class AccountVerifiedScreen extends StatelessWidget {
  const AccountVerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '',
        showBackIcon: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                 
                  children: [
                    Image.asset(
                      "assets/images/succesful.gif",
                      width: 120,
                      height: 120,
                    ),
                    Gap(32),
                    TextHolder(
                      title: 'Account Verified',
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      align: TextAlign.center,
                    ),
                    Gap(16),
                    TextHolder(
                      title: 'You\'re in! Your registration was completed\nsuccessfully.',
                      size: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey.shade600,
                      align: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: CustomButtom(
                  title: 'Proceed',
                  btnColor: "#C5A35E".toColor(),
                  textColor: Colors.white,
                  onTap: () {
                    router.push(const CompleteProfileScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
