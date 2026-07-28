import 'package:evently_c19/core/reusable_components/event_item.dart';
import 'package:flutter/material.dart';

class AllTabView extends StatelessWidget {
  const AllTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => EventItem(),
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemCount: 10,
    );
  }
}
