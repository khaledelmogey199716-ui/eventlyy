import 'package:evently_c19/core/resources/app_constants.dart';
import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.25,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer),
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(themeProvider.selectedTheme == ThemeMode.dark
                  ?AppConstants.darkEventTypeImage["birthday"]!
                  :AppConstants.lightEventTypeImage["birthday"]!))
      ),
      padding:EdgeInsets.all(8) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer)
            ),
            child: Text("21 Jan",style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              decoration: TextDecoration.none,
              fontSize: 16
            ),),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Theme.of(context).colorScheme.onPrimaryContainer)
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text("This is a Birthday Party",style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),),
                ),
                InkWell(
                  onTap: () {

                  },
                  child: SvgPicture.asset(AssetsManager.heart_selected,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),),
                )
              ],
            ),
          )
      ],),
    );
  }
}
