import 'package:flutter/material.dart';

class CategoryContainter extends StatelessWidget {
  const CategoryContainter({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
        border: Border.all(),
      ),
      child: Text(name),
    );
  }
}
