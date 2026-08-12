import 'package:evently_c19/core/remote/local/prefs_manager.dart';
import 'package:evently_c19/core/resources/app_theme.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:evently_c19/providers/user_provider.dart';
import 'package:evently_c19/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c19/ui/forget_pass/screen/forget_pass_screen.dart';
import 'package:evently_c19/ui/home/screen/home_screen.dart';
import 'package:evently_c19/ui/login/screen/login_screen.dart';
import 'package:evently_c19/ui/onboarding/screen/onboarding_screen.dart';
import 'package:evently_c19/ui/signup/screen/signup_screen.dart';
import 'package:evently_c19/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefsManager.init();

  // await PrefsManager.resetOnboarding(); ///////// MAKE SURE TO REMOVE BEFORE RELEASE

  String initialRoute;

  if (!PrefsManager.isOnboardingCompleted) {
    initialRoute = RoutesManager.onboardingRouteName;
  } else if (FirebaseAuth.instance.currentUser != null) {
    initialRoute = RoutesManager.homeRouteName;
  } else {
    initialRoute = RoutesManager.loginRouteName;
  }

  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider()..init(),
      child: MyApp(initialRoute: initialRoute,)));
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
      themeMode: themeProvider.selectedTheme,
      theme: AppTheme.lightTheme ,
      darkTheme:AppTheme.darkTheme ,
      debugShowCheckedModeBanner: false,
      routes: {
        RoutesManager.startRouteName:(_)=>StartScreen(),
        RoutesManager.loginRouteName:(_)=>LoginScreen(),
        RoutesManager.homeRouteName:(_)=>ChangeNotifierProvider(
            create: (context) => UserProvider()..fetchUser(),
            child: HomeScreen()),
        RoutesManager.signupRouteName:(_)=>SignupScreen(),
        RoutesManager.forgetpassRouteName:(_)=>ForgetPassScreen(),
        RoutesManager.addEventRouteName:(_)=>AddEventScreen(),
        RoutesManager.onboardingRouteName:(_)=>OnboardingScreen(),
      },
      initialRoute: initialRoute
      // FirebaseAuth.instance.currentUser!=null
      //     ?RoutesManager.homeRouteName
      //     :RoutesManager.loginRouteName,
    );
  }
}

