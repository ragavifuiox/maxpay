import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_ionicons/flutter_ionicons.dart';
import 'package:maxpay/core/constants/colors.dart';

class ScreenProfileEdit extends StatefulWidget {
  const ScreenProfileEdit({super.key});

  @override
  State<ScreenProfileEdit> createState() => _ScreenProfileEditState();
}

class _ScreenProfileEditState extends State<ScreenProfileEdit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  final List<String> _selectedLanguages = ['English', 'Hindi'];
  final List<String> _selectedInterests = ['Cricket', 'Music', 'Movies'];
  String? _profileImagePath;

  @override
  void initState() {
    super.initState();
    _nameController.text = "Aswanth";
    _dobController.text = "01-01-1995";
    _designationController.text = "Developer";
    _phoneNumberController.text = "+91 9876543210";
    _bioController.text = "Flutter developer with a passion for clean UI.";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _designationController.dispose();
    _phoneNumberController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// 🔹 HEADER
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 45.w,
                        height: 45.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                          color: theme.colorScheme.surface,
                        ),
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios, size: 18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Manage Profile",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 45.w),
                  ],
                ),
                SizedBox(height: 25.h),

                /// 🔹 PROFILE IMAGE
                Stack(
                  children: [
                    Container(
                      width: 130.w,
                      height: 130.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withValues(alpha: 0.2),
                        image: _profileImagePath != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(_profileImagePath!)),
                              )
                            : null,
                      ),
                      child: _profileImagePath == null
                          ? Icon(Icons.person, size: 60.sp, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: GestureDetector(
                        onTap: () {
                          // Handle image selection
                        },
                        child: Container(
                          height: 35.w,
                          width: 35.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.clrPrimary,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Ionicons.camera_outline,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                /// 🔹 FORM FIELDS
                _buildTextField('Full name', _nameController, isDark),
                _buildTextField('Date of birth', _dobController, isDark),
                _buildTextField('Designation', _designationController, isDark),
                _buildTextField(
                  'Phone number',
                  _phoneNumberController,
                  isDark,
                  isReadOnly: true,
                ),
                _buildTextField(
                  'Bio/About me',
                  _bioController,
                  isDark,
                  maxLines: 4,
                ),

                SizedBox(height: 20.h),

                /// 🔹 LANGUAGES SECTION
                _buildTagsSection(
                  context,
                  "Languages",
                  _selectedLanguages,
                  isDark,
                  onEditTap: () {},
                ),
                SizedBox(height: 20.h),

                /// 🔹 INTERESTS SECTION
                _buildTagsSection(
                  context,
                  "Interests",
                  _selectedInterests,
                  isDark,
                  onEditTap: () {},
                ),

                SizedBox(height: 40.h),

                /// 🔹 SAVE BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.clrPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Save Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.h),

                /// 🔹 DELETE BUTTON
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    bool isDark, {
    int maxLines = 1,
    bool isReadOnly = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkplceholder
                  : AppColors.clrplceholder,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: controller,
              readOnly: isReadOnly,
              maxLines: maxLines,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? Colors.white : Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagsSection(
    BuildContext context,
    String title,
    List<String> tags,
    bool isDark, {
    required VoidCallback onEditTap,
  }) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkplceholder : AppColors.clrplceholder,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              GestureDetector(
                onTap: onEditTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: tags.map((tag) => _buildTagChip(tag, isDark)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String label, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.clrPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.clrPrimary.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.clrPrimary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
