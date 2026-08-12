import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveTheme(ThemeMode theme){
    if(theme == ThemeMode.dark){
      sharedPreferences.setString("theme", "dark");
    }else{
      sharedPreferences.setString("theme", "light");
    }
  }

  static ThemeMode getTheme(){
    String savedTheme = sharedPreferences.getString("theme")??"light";
    if(savedTheme == "dark"){
      return ThemeMode.dark;
    }else{
      return ThemeMode.light;
    }
  }


  static const String _onboardingCompletedKey = 'onboarding_completed';

  static Future<void> resetOnboarding() async {
    await sharedPreferences.remove(_onboardingCompletedKey);
  }


  static bool get isOnboardingCompleted {
    return sharedPreferences.getBool(_onboardingCompletedKey) ?? false;
  }
  static Future<void> setOnboardingCompleted() async {
    await sharedPreferences.setBool(_onboardingCompletedKey, true);
  }


}