import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MaterialApp(
    home: ProfileSetupScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _birthdayController = TextEditingController();
  
  // Pre-selecting the concerns shown in the screenshot
  final Set<String> _selectedConcerns = {
    'Acne & Breakouts',
    'Anti-Aging',
    'Hyperpigmentation'
  };

  final List<String> _skinConcerns = [
    'Acne & Breakouts',
    'Anti-Aging',
    'Hyperpigmentation',
    'Dry Skin',
    'Oily Skin',
    'Sensitive Skin',
    'Fine Lines',
    'Dark Circles',
  ];

  // UI Color Palette from Screenshot
  final Color _darkBrown = const Color(0xFF3D2817);
  final Color _softBrown = const Color(0xFF8B7355);
  final Color _rosePink = const Color(0xFFC58295);
  final Color _scaffoldBg = const Color(0xFFF8F7F7);
  final Color _inputBg = const Color(0xFFF2EDED);

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _inputBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back, color: _darkBrown, size: 20),
                ),
              ),
              const SizedBox(height: 32),
              // Header Section
              Text(
                'Complete Your Profile',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: _darkBrown,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Help us personalize your experience',
                style: TextStyle(
                  fontSize: 16,
                  color: _softBrown,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 40),
              // Profile Photo Circle
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 110,
                          height: 110,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEBE3E3),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _rosePink,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Add a profile photo',
                      style: TextStyle(color: _darkBrown, fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Birthday Input
              Text(
                'Birthday',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _darkBrown,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _birthdayController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'dd/mm/yyyy',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: _inputBg,
                  suffixIcon: Icon(Icons.calendar_today_outlined,
                      color: _darkBrown, size: 18),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('🎂', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 8),
                  Text(
                    'Get special rewards on your birthday!',
                    style: TextStyle(color: _softBrown, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Skin Concerns
              Text(
                'What are your skin concerns?',
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: _darkBrown,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Select all that apply for personalized recommendations',
                style: TextStyle(color: _softBrown, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _skinConcerns.map((concern) {
                  final isSelected = _selectedConcerns.contains(concern);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedConcerns.remove(concern);
                        } else {
                          _selectedConcerns.add(concern);
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? _rosePink : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected ? _rosePink : const Color(0xFFE8E8E8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isSelected) ...[
                            const Icon(Icons.check, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            concern,
                            style: TextStyle(
                              color: isSelected ? Colors.white : _darkBrown,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              // Recommendations Box
              if (_selectedConcerns.isNotEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFF0F0F0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('✨', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Based on your concerns, we recommend:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _darkBrown,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _bulletPoint('HydraFacial treatments'),
                      _bulletPoint('LED Light Therapy'),
                      _bulletPoint('Chemical Peels'),
                    ],
                  ),
                ),
              const SizedBox(height: 32),
              // Buttons
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _rosePink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Complete Setup',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Skip for now',
                    style: TextStyle(color: _softBrown, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: _softBrown, fontSize: 18)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: _darkBrown, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}