import 'package:flutter/material.dart';

import '../../../../../core/reusable_components/event_item.dart';

class SportTabView extends StatelessWidget {
  const SportTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => EventItem(),
      separatorBuilder: (context, index) => SizedBox(height: 16),
      itemCount: 10,
    );
  }
}
