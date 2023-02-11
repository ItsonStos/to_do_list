import 'package:flutter/material.dart';

class DifficultyWidget extends StatelessWidget {
  final int difficultyLevel;

  const DifficultyWidget(this.difficultyLevel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          size: 15,
          color: Colors.blue,
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (difficultyLevel > 1) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (difficultyLevel > 2) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (difficultyLevel > 3) ? Colors.blue : Colors.blue[100],
        ),
        Icon(
          Icons.star,
          size: 15,
          color: (difficultyLevel > 4) ? Colors.blue : Colors.blue[100],
        ),
      ],
    );
  }
}
