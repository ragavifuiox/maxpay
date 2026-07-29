import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:maxpay/controllers/grade_controller.dart';
import 'package:maxpay/core/constants/colors.dart';
import 'package:maxpay/global_widget/custom_app.dart';

class GradeScreen extends GetView<GradeController> {
  const GradeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }

      final grade = controller.gradeData.value;

      if (grade == null || grade.data == null) {
        return const Scaffold(
          body: Center(
            child: Text("No Data Found"),
          ),
        );
      }

      final item = grade.data!;

      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: const CommonAppBar(
            title: "Grade",
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30.h),

                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Congratulations!",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "This month grade is",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        SizedBox(height: 25.h),

                        Text(
                          item.displayCard?.grade ??
                              item.currentMonth?.grade ??
                              "-",
                          style: TextStyle(
                            fontSize: 110.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.clrPrimary,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  Text(
                    "Details",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 15.h),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.brightness == Brightness.light
                          ? Colors.white
                          : theme.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.r),
                            topRight: Radius.circular(10.r),
                          ),
                          child: Row(
                            children: [
                              _headerCell(
                                context,
                                title: "Grade",
                                color: const Color(0xFFFFE1B4),
                              ),
                              _headerCell(
                                context,
                                title: "Daily Average\nBalance",
                                color: AppColors.box1,
                              ),
                              _headerCell(
                                context,
                                title: "Monthly\nCashback",
                                color: const Color(0xFFC6E5FF),
                                isLast: true,
                              ),
                            ],
                          ),
                        ),

                        /// Dynamic Rows
                        ...(item.gradeSlabs ?? []).map(
                          (slab) => _tableRow(
                            context,
                            slab.grade ?? "-",
                            slab.dailyAverageBalance?.toString() ?? "0",
                            slab.monthlyCashBack?.toString() ?? "0",
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _headerCell(
    BuildContext context, {
    required String title,
    required Color color,
    bool isLast = false,
  }) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        height: 70.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          border: Border(
            right: isLast
                ? BorderSide.none
                : BorderSide(
                    color: theme.colorScheme.outline,
                  ),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _tableRow(
    BuildContext context,
    String grade,
    String balance,
    String cashback,
  ) {
    return Row(
      children: [
        _bodyCell(context, grade),
        _bodyCell(context, balance),
        _bodyCell(
          context,
          cashback,
          isLast: true,
        ),
      ],
    );
  }

  Widget _bodyCell(
    BuildContext context,
    String text, {
    bool isLast = false,
  }) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outline,
            ),
            right: isLast
                ? BorderSide.none
                : BorderSide(
                    color: theme.colorScheme.outline,
                  ),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}