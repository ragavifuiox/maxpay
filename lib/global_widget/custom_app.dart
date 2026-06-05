import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;

  const CommonAppBar({super.key, required this.title, this.showBack = true});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      titleSpacing: 0,

      centerTitle: false,

      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,

      backgroundColor:
          theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,

      foregroundColor: theme.colorScheme.onSurface,

      iconTheme: IconThemeData(color: theme.colorScheme.onSurface),

      title: Text(
        title,

        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
      ),

      leading: showBack
          ? Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 23),

                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}