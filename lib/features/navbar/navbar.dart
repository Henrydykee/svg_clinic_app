import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Import your screens correctly here
import 'package:savouge/features/appointments/presentation/appointment_screen.dart';
import 'package:savouge/features/home/presentation/home_screen.dart';
import 'package:savouge/features/services/presentation/services_screen.dart';
import 'package:savouge/features/profile/presenatation/profile_screen.dart';

class Navbar extends StatefulWidget {
  final int selectedTab;

  const Navbar({super.key, this.selectedTab = 0});

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  late int selectedTab;

  @override
  void initState() {
    super.initState();
    selectedTab = widget.selectedTab;
  }

  void _onTabSelected(int index) {
    setState(() {
      selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Design Colors
    const Color activeGold = Color(0xFFC7A054);
    const Color inactiveGray = Color(0xFF9E9E9E);
    const Color pillBgColor = Color(0xFFFAF3E7);

    return Scaffold(
      backgroundColor: Colors.white,
      // 1. The Body: This is where your screens live. 
      // IndexedStack ensures they fill the available space above the navbar.
      body: IndexedStack(
        index: selectedTab,
        children: const [
          HomeScreen(),
          AppointmentScreen(),
          ServicesScreen(),
          ProfileScreen(),
        ],
      ),

      // 2. The Bottom Navigation Bar Slot
      bottomNavigationBar: Container(
        height: 100, // Explicit height to prevent it from taking over the screen
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Padding(padding: const EdgeInsets.only(top: 10),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, "assets/images/home_icon.svg", "Home", activeGold, inactiveGray, pillBgColor),
                _buildNavItem(1, "assets/images/appointment_icon.svg", "Appointments", activeGold, inactiveGray, pillBgColor),
                _buildNavItem(2, "assets/images/services_icon.svg", "Services", activeGold, inactiveGray, pillBgColor),
                _buildNavItem(3, "assets/images/profile_icon.svg", "Profile", activeGold, inactiveGray, pillBgColor),
              ],
            ),
          ),
        ),)
      ),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label, Color activeColor, Color inactiveColor, Color bgColor) {
    final isSelected = selectedTab == index;

    return GestureDetector(
      onTap: () => _onTabSelected(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? bgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconPath,
              height: isSelected ? 26 : 22,
              width: isSelected ? 26 : 22,
              colorFilter: ColorFilter.mode(
                isSelected ? activeColor : inactiveColor,
                BlendMode.srcIn,
              ),
            ),
            ClipRect(
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                alignment: Alignment.centerLeft,
                curve: Curves.easeInOut,
                widthFactor: isSelected ? 1.0 : 0.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: activeColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Sora',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}