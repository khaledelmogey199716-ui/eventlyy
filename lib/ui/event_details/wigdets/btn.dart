import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Btn extends StatelessWidget {
  String icon;
  Function() onClick;
  Btn({required this.icon,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.onPrimary,
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary,)
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
