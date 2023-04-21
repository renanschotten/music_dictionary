import 'package:flutter/material.dart';
import 'package:music_dictionary/shared/style/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppTextStyles.montserrat24w900,
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, 56);
}
