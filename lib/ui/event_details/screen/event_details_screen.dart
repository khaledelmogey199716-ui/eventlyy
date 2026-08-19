import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c19/core/resources/app_constants.dart';
import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/colors_manager.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/model/event.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:evently_c19/providers/user_provider.dart';
import 'package:evently_c19/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c19/ui/event_details/wigdets/btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  late Event event;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    event = ModalRoute.of(context)!.settings.arguments as Event;
  }

  @override
  Widget build(BuildContext context) {


    final userProvider = Provider.of<UserProvider>(context);
    final isMyEvent = event.userId == userProvider.user?.id;

    final date = event.dateTime!.toDate();
    final themeProvider = Provider.of<ThemeProvider>(context);
    final imagePath = themeProvider.selectedTheme == ThemeMode.dark
        ? AppConstants.darkEventTypeImage[event.type!]!
        : AppConstants.lightEventTypeImage[event.type!]!;

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
        actions: isMyEvent
            ? [
          Btn(
            onClick: () async {
              final updatedEvent = await Navigator.push<Event>(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEventScreen(
                    event: event,
                  ),
                ),
              );

              if (updatedEvent != null && mounted) {
                setState(() {
                  event = updatedEvent;
                });
              }
            },
            icon: AssetsManager.edit,
          ),


          const SizedBox(width: 8),
                Btn(
                  onClick: () async {
                    await deleteEvent(event);
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  icon: AssetsManager.delete,
                ),
                const SizedBox(width: 16),
              ]
            : null,
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
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              Text(
                event.title ?? "",
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
                          DateFormat('dd MMMM').format(date),
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Text(
                          DateFormat('hh:mm a').format(date),
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
                    initialValue: event.description ?? "",
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

  static Future<void> deleteEvent(Event event) async {
    await FirebaseFirestore.instance.collection('Event').doc(event.id).delete();
  }
}
