import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/presentation/widgets/app_bar.dart';
import '../../../../core/presentation/widgets/button.dart';
import '../../../../core/presentation/widgets/text_field.dart';
import '../../../../core/presentation/widgets/text_holder.dart';
import '../../../../core/platform/color.dart';
import '../../../../core/utils/data/color_utils.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _dobController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;
  
  String? _selectedSkinType;
  final Set<String> _selectedSkinConcerns = {};
  
  final List<String> _skinTypes = [
    'Normal',
    'Dry',
    'Oily',
    'Combination',
    'Sensitive',
    'Mature',
  ];
  
  final List<String> _skinConcerns = [
    'Acne',
    'Dark Spots',
    'Wrinkles',
    'Dryness',
    'Large Pores',
    'Uneven Tone',
    'Scars',
    'Redness',
  ];

  @override
  void dispose() {
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    if (Platform.isIOS) {
      _showCupertinoDatePicker();
      return;
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _showCupertinoDatePicker() {
    DateTime selectedDate = DateTime.now();
    
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 250,
        padding: EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    child: Text('Done'),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _dobController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
                      });
                    },
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime date) {
                    selectedDate = date;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Complete Your Profile',
        showBackIcon: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(32),
                      _buildProfilePhotoSection(),
                      Gap(32),
                      _buildDateOfBirthField(),
                      Gap(24),
                      _buildSkinTypeSection(),
                      Gap(24),
                      _buildSkinConcernsSection(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 30),
                child: Column(
                  children: [
                    CustomButtom(
                      title: 'Complete Profile',
                      btnColor: "#C5A35E".toColor(),
                      textColor: Colors.white,
                      onTap: () {
                        // TODO: Handle profile completion
                      },
                    ),
                    Gap(16),
                    GestureDetector(
                      onTap: () {
                        // TODO: Handle skip
                      },
                      child: TextHolder(
                        title: 'Skip for Now',
                        size: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePhotoSection() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: ClipOval(
                child: _profileImage != null
                    ? Image.file(
                        _profileImage!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Colors.grey.shade100,
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.grey.shade400,
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: "#C5A35E".toColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        Gap(12),
        TextHolder(
          title: 'Upload Profile Photo',
          size: 16,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildDateOfBirthField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextHolder(
          title: 'Date of Birth',
          color: newprojectColor.grey_2,
          size: 15,
          fontWeight: FontWeight.w500,
        ),
        Gap(8),
        CustomTextField(
          hinttitle: '16/01/2026',
          controller: _dobController,
          readOnly: true,
          suffix: Icon(
            Icons.calendar_today,
            color: Colors.grey.shade600,
            size: 20,
          ),
          onTap: () {
            if (Platform.isIOS) {
              _showCupertinoDatePicker();
            } else {
              _selectDate(context);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSkinTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextHolder(
          title: 'Skin Type',
          color: newprojectColor.grey_2,
          size: 15,
          fontWeight: FontWeight.w500,
        ),
        Gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _skinTypes.map((type) {
            final isSelected = _selectedSkinType == type;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSkinType = isSelected ? null : type;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? "#C5A35E".toColor() : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? "#C5A35E".toColor() : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextHolder(
                      title: type,
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    Gap(6),
                    Icon(
                      isSelected ? Icons.check : Icons.add,
                      size: 18,
                      color: isSelected ? Colors.white : "#C5A35E".toColor(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSkinConcernsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextHolder(
          title: 'Skin Concerns (Select all that apply)',
          color: newprojectColor.grey_2,
          size: 15,
          fontWeight: FontWeight.w500,
        ),
        Gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _skinConcerns.map((concern) {
            final isSelected = _selectedSkinConcerns.contains(concern);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedSkinConcerns.remove(concern);
                  } else {
                    _selectedSkinConcerns.add(concern);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? "#C5A35E".toColor() : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? "#C5A35E".toColor() : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextHolder(
                      title: concern,
                      size: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                    Gap(6),
                    Icon(
                      isSelected ? Icons.check : Icons.add,
                      size: 18,
                      color: isSelected ? Colors.white : "#C5A35E".toColor(),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
