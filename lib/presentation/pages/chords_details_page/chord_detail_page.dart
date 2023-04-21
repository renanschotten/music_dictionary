import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_dictionary/domain/entities/chord.dart';
import 'package:music_dictionary/presentation/widgets/app_bar/custom_app_bar.dart';
import 'package:music_dictionary/shared/style/app_text_styles.dart';

class ChordDetailsPage extends StatelessWidget {
  const ChordDetailsPage({super.key, required this.chord});
  final Chord chord;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: chord.name),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.memory(base64Decode(chord.images.first)),
              SizedBox(height: 16.0),
              Text(
                chord.description,
                style: AppTextStyles.montserrat16w500,
              )
            ],
          ),
        ),
      ),
    );
  }
}
