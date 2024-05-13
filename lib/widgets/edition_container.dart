import 'package:flutter/material.dart';

class EditionContainer extends StatelessWidget {
  const EditionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.yellow,
        child: const Text('Edition area'),
      ),
    );
  }
}
