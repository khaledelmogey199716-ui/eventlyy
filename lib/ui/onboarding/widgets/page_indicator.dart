import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

   PageIndicator({required this.currentPage,required this.pageCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
            (index) {
          final isActive = index == currentPage;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isActive ? 21 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondaryContainer,
              borderRadius: BorderRadius.circular(36),
            ),
          );
        },
      ),
    );
  }
}
