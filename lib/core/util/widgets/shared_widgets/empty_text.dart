import 'package:flutter/material.dart';

class EmptyText extends StatelessWidget {
  final String emptyText;

  const EmptyText({
    super.key,
    this.emptyText = 'No Images',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        emptyText,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}