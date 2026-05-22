// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:maxpay/core/constants/routes_path.dart';
// import 'package:maxpay/global_widget/custom_app.dart';
// import 'package:maxpay/view/login/widgets/select_sim_widget.dart';

// class SelectSimPage extends StatelessWidget {
//   const SelectSimPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context);

//     final theme = Theme.of(context);
//     final colorScheme = theme.colorScheme;

//     return Scaffold(
//       backgroundColor: colorScheme.surface,
//       appBar: CommonAppBar(title: "Select Sim"),
        
     

//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           horizontal: 24.w,
//           vertical: 50.h,
//         ),
//         child: Column(
//           children: [
//             SimCardWidget(
//               number: "987 0215 1214",
//               simText: "SIM 1",

//               /// Light/Dark adaptive color
//               cardColor: theme.brightness == Brightness.dark
//                   ? const Color(0xFF1E88E5)
//                   : const Color(0xFF00BCD4),

//               onTap: () {
//                 Get.toNamed(AppRoutes.loginPhoneName);
//               },
//             ),

//             SizedBox(height: 28.h),

//             SimCardWidget(
//               number: "887 0215 1214",
//               simText: "SIM 2",

//               /// Light/Dark adaptive color
//               cardColor: theme.brightness == Brightness.dark
//                   ? const Color(0xFF3949AB)
//                   : const Color(0xFF001C73),

//               onTap: () {
//                 Get.toNamed(AppRoutes.loginPhoneName);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }