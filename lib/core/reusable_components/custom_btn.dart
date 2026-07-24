import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  String title;
  void Function() onClick;

  CustomBtn({required this.title, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        )
      ),
      child: Text(title, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}
