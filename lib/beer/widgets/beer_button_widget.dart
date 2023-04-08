
import 'package:flutter/material.dart';

class BeerButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const BeerButtonWidget({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(title));
  }
}