import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_dictionary/domain/entities/chord.dart';

class ChordDetailsPage extends StatelessWidget {
  const ChordDetailsPage({super.key, required this.chord});
  final Chord chord;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chord.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.memory(base64Decode(chord.images.first)),
              SizedBox(height: 16.0),
              Text(chord.description)
            ],
          ),
        ),
      ),
    );
  }
}
