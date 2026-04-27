import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:maxpay/core/utils/colors.dart';
import 'package:maxpay/core/utils/responsive.dart';
import 'package:maxpay/core/utils/routes_path.dart';
import 'package:maxpay/view/login/widgets/cutom_elevated_button.dart';
import 'package:maxpay/view/login/widgets/login_textfield.dart';

class LoginPhoneNamePage extends StatefulWidget {
  const LoginPhoneNamePage({super.key});

  @override
  State<LoginPhoneNamePage> createState() => _LoginPhoneNamePageState();
}

class _LoginPhoneNamePageState extends State<LoginPhoneNamePage> {
  bool _isAccepted = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: colorScheme.onSurface,
            size: 20.sp,
          ),
        ),
        title: Text(
          'Login',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: isTablet ? 24.sp : 18.sp,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isTablet ? 500 : double.infinity),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isTablet ? 60.h : 40.h),

                  // Phone Number Field
                  const PhoneNUmberField(),

                  SizedBox(height: 16.h),

                  // Name Field
                  const LoginTextField(hintText: 'Enter Your Name'),

                  SizedBox(height: 16.h),

                  // Pincode Field
                  const LoginTextField(
                    hintText: 'Enter Pincode',
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: 24.h),

                  // Terms Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24.h,
                        width: 24.w,
                        child: Checkbox(
                          value: _isAccepted,
                          onChanged: (value) {
                            setState(() {
                              _isAccepted = value ?? false;
                            });
                          },
                          activeColor: Colors.black,
                          checkColor: colorScheme.onSurface,
                          side: BorderSide(
                            color: colorScheme.onSurface,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: isTablet ? 16.sp : 13.sp,
                              color: colorScheme.onSurface,
                              height: 1.5,
                            ),
                            children: [
                              const TextSpan(
                                text: 'Registration implies acceptance of the ',
                              ),
                              const TextSpan(
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: AppColors.clrPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              const TextSpan(
                                text: 'Privacy Policy.',
                                style: TextStyle(
                                  color: AppColors.clrPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Login Button
                  Center(
                    child: CustomElevatedButton(
                      text: 'Login',
                      width: isTablet ? 300.w : 222.w,
                      height: isTablet ? 70.h : 60.h,
                      backgroundColor: AppColors.clrPrimary,
                      borderRadius: 12.r,
                      onPressed: () {
                        context.push(AppRoutes.otpVerification);
                      },
                    ),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PhoneNUmberField extends StatelessWidget {
  const PhoneNUmberField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isTablet = Responsive.isTablet(context);
    
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: isTablet ? 12.h : 4.h),
      child: Row(
        children: [
          Image.network(
            'https://flagcdn.com/w40/in.png',
            width: isTablet ? 32.w : 24.w,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.flag, size: isTablet ? 32.w : 24.w),
          ),
          SizedBox(width: 8.w),
          Text(
            '+91 |',
            style: TextStyle(
              fontFamily: 'Lufga',
              fontWeight: FontWeight.w500,
              fontSize: isTablet ? 20.sp : 16.sp,
              color: theme.colorScheme.onSurface,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              style: TextStyle(
                fontFamily: 'Lufga',
                color: theme.colorScheme.onSurface,
                fontSize: isTablet ? 20.sp : 16.sp,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: 'Your phone no',
                hintStyle: TextStyle(
                  fontFamily: 'Lufga',
                  color: theme.colorScheme.onSurface,
                  fontSize: isTablet ? 20.sp : 16.sp,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
        ],
      ),
    );
  }
}
