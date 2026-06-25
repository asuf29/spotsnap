import 'package:flutter/material.dart';

class ColorHarmonyRow extends StatelessWidget {
  const ColorHarmonyRow({super.key, required this.colors});

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < colors.length; i++) ...[
              if (i > 0)
                Container(
                  width: 20,
                  height: 2,
                  color: colors[i - 1].withValues(alpha: 0.5),
                ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors[i],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.8),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors[i].withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
