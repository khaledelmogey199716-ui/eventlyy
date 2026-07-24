import 'package:evently_c19/core/remote/local/prefs_manager.dart';
import 'package:evently_c19/core/resources/app_theme.dart';
import 'package:evently_c19/core/resources/colors_manager.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/providers/theme_provider.dart';
import 'package:evently_c19/ui/forget_pass/screen/forget_pass_screen.dart';
import 'package:evently_c19/ui/home/screen/home_screen.dart';
import 'package:evently_c19/ui/login/screen/login_screen.dart';
import 'package:evently_c19/ui/signup/screen/signup_screen.dart';
import 'package:evently_c19/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsManager.init();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider()..init(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        RoutesManager.homeRouteName:(_)=>HomeScreen(),
        RoutesManager.signupRouteName:(_)=>SignupScreen(),
        RoutesManager.forgetpassRouteName:(_)=>ForgetPassScreen(),
      },
      initialRoute: RoutesManager.loginRouteName,
    );
  }
}

