import 'package:flutter/material.dart';

class ErrorPageWidget extends StatelessWidget {
  const ErrorPageWidget({
    super.key,
    required this.onTapButton,
  });

  final VoidCallback onTapButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Um erro aconteceu ao buscar os dados :/',
          ),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: onTapButton,
          child: Text('Tente Novamente'),
        )
      ],
    );
  }
}
