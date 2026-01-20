import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:savouge/core/utils/data/color_utils.dart';
import 'package:savouge/features/onboarding/presentation/pages/onboarding_screen.dart';

import '../../../../core/presentation/widgets/router.dart';
import '../../../../core/utils/color.dart';
import '../../../../features/getting_started/get_started_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 2), () {
      if (mounted) {
       router.pushAndRemoveUntil(OnboardingScreen(), (route) => false);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SavogueColor.deep_green,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: "#C7A054".toColor(),
      )
    );
  }
}

