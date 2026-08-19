import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/colors_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/ui/event_details/wigdets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.eventDetails),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).colorScheme.onPrimary,
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            child: SvgPicture.asset(
              AssetsManager.back,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onTertiary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        actions: [
          Btn(onClick: () {}, icon: AssetsManager.edit),
          SizedBox(width: 8),
          Btn(onClick: () {}, icon: AssetsManager.delete),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    AssetsManager.birthday_dark,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "We’re going to play football ",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadiusGeometry.circular(16),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                child: Row(
                  spacing: 16,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                      child: SvgPicture.asset(AssetsManager.date),
                    ),
                    Column(
                      children: [
                        Text(
                          "21 January ",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                          "12:12 PM",
                          style: TextStyle(
                            color: ColorsManager.unselectedTab,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    StringsManager.description,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  TextFormField(
                    enabled: false,
                    initialValue:
                        "Lorem ipsum dolor sit amet consectetur. Vulputate eleifend suscipit eget neque senectus a. Nulla at non malesuada odio duis lectus amet nisi sit. Risus hac enim maecenas auctor et. At cras massa diam porta facilisi lacus purus. Iaculis eget quis ut amet. Sit ac malesuada nisi quis  feugiat.",
                    maxLines: null,
                    style: Theme.of(context).textTheme.bodySmall,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onPrimary,
                      contentPadding: const EdgeInsets.all(16),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: BorderSide(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
