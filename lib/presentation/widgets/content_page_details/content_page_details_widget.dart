import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_dictionary/app/di/injection_container.dart';
import 'package:music_dictionary/presentation/pages/content_page/bloc/content_page_bloc.dart';
import 'package:music_dictionary/shared/style/app_text_styles.dart';

class ContentPageDetailsWidget extends StatefulWidget {
  const ContentPageDetailsWidget({super.key});

  @override
  State<ContentPageDetailsWidget> createState() =>
      _ContentPageDetailsWidgetState();
}

class _ContentPageDetailsWidgetState extends State<ContentPageDetailsWidget> {
  late final ContentPageBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bloc = getIt<ContentPageBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: bloc.selectedChordNotifier,
      builder: (_, chord, __) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.memory(base64Decode(chord.images.first)),
            SizedBox(height: 16.0),
            Text(
              chord.description,
              style: AppTextStyles.montserrat16w500,
            ),
          ],
        ),
      ),
    );
  }
}
