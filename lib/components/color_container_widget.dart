import 'package:flutter/material.dart';

class ColorContainnerWidget extends StatelessWidget {
  final int level;
  final int difficulty;

  const ColorContainnerWidget(this.level, this.difficulty, {super.key});

  Color typeColor(int level, int difficulty) {
    if ((level / difficulty) < 10) {
      return Colors.blue;
    } else if ((level / difficulty) < 20) {
      return Colors.green;
    } else if ((level / difficulty) < 30) {
      return Colors.amber;
    } else if ((level / difficulty) < 40) {
      return Colors.brown;
    } else if ((level / difficulty) <= 50) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.5),
        color: typeColor(level, difficulty),
      ),
      height: 140,
    );
  }
}
