import 'package:flutter/material.dart';
import 'package:music_dictionary/shared/style/app_text_styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: AppTextStyles.montserrat16w500,
      ),
      trailing: Icon(Icons.arrow_right),
      onTap: onTap,
    );
  }
}
