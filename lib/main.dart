import 'package:evently_c19/core/remote/local/prefs_manager.dart';
import 'package:evently_c19/core/resources/app_theme.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:evently_c19/providers/user_provider.dart';
import 'package:evently_c19/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c19/ui/event_details/screen/event_details_screen.dart';
import 'package:evently_c19/ui/forget_pass/screen/forget_pass_screen.dart';
import 'package:evently_c19/ui/home/screen/home_screen.dart';
import 'package:evently_c19/ui/login/screen/login_screen.dart';
import 'package:evently_c19/ui/onboarding/screen/onboarding_screen.dart';
import 'package:evently_c19/ui/signup/screen/signup_screen.dart';
import 'package:evently_c19/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PrefsManager.init();
  await GoogleSignIn.instance.initialize();

  String initialRoute;

  if (!PrefsManager.isOnboardingCompleted) {
    initialRoute = RoutesManager.startRouteName;
  } else if (FirebaseAuth.instance.currentUser != null) {
    initialRoute = RoutesManager.homeRouteName;
  } else {
    initialRoute = RoutesManager.loginRouteName;
  }

  final userProvider = UserProvider();

  if (FirebaseAuth.instance.currentUser != null) {
    await userProvider.fetchUser();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider()..init(),
        ),
        ChangeNotifierProvider.value(
          value: userProvider,
        ),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}


class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({
    required this.initialRoute,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      themeMode:themeProvider.selectedTheme,
      theme: AppTheme.lightTheme ,
      darkTheme:AppTheme.darkTheme ,
      debugShowCheckedModeBanner: false,
      routes: {
        RoutesManager.startRouteName:(_)=>StartScreen(),
        RoutesManager.loginRouteName:(_)=>LoginScreen(),
        RoutesManager.homeRouteName: (_) => HomeScreen(),
        RoutesManager.signupRouteName:(_)=>SignupScreen(),
        RoutesManager.forgetpassRouteName:(_)=>ForgetPassScreen(),
        RoutesManager.addEventRouteName:(_)=>AddEventScreen(),
        RoutesManager.onboardingRouteName:(_)=>OnboardingScreen(),
        RoutesManager.eventDetailsRouteName:(_)=>EventDetailsScreen(),
      },
      initialRoute: initialRoute

    );
  }
}

