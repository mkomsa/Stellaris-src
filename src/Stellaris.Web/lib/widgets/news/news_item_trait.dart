import 'package:flutter/material.dart';

class NewsItemTrait extends StatelessWidget {
  const NewsItemTrait({
    super.key,
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 14,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
