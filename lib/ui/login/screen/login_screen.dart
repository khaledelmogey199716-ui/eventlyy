import 'package:evently_c19/core/resources/app_constants.dart';
import 'package:evently_c19/core/resources/dialog_utils.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/core/reusable_components/custom_btn.dart';
import 'package:evently_c19/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/reusable_components/custom_field.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          height: 27,
          fit: BoxFit.fitHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManager.loginToYourAccount,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24),
                CustomField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.emailEmpty;
                    }
                    if (!RegExp(AppConstants.emailRegex).hasMatch(value)) {
                      return StringsManager.emailInvalid;
                    }
                    return null;
                  },
                  controller: emailController,
                  hint: StringsManager.emailHint,
                  prefixPath: AssetsManager.email,
                  keyboard: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                CustomField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.passwordEmpty;
                    }
                    if (value.length < 8) {
                      return StringsManager.passwordWeak;
                    }
                    return null;
                  },
                  isObscure: true,
                  controller: passwordController,
                  hint: StringsManager.passwordHint,
                  prefixPath: AssetsManager.lock,
                  keyboard: TextInputType.visiblePassword,
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        RoutesManager.forgetpassRouteName,
                      );
                    },
                    child: Text(
                      StringsManager.forgetPassAsk,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                SizedBox(height: 48),
                Container(
                  width: double.infinity,
                  child: CustomBtn(
                    title: StringsManager.login,
                    onClick: () {
                      if (formKey.currentState?.validate() ?? false) {
                        login();
                      }
                    },
                  ),
                ),
                SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${StringsManager.dontHaveAcc} ",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.signupRouteName,
                        );
                      },
                      child: Text(
                        StringsManager.signup,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32),
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    Text(
                      StringsManager.or,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none,
                          ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    loginWithGoogle();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 11),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Row(
                      spacing: 16,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsManager.google,
                          width: 24,
                          height: 24,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          StringsManager.loginWithGoogle,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.none,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    print(
      "Firebase project: ${Firebase.app().options.projectId}",
    );

    try {
      DialogUtils.showLoadingDialog(context);

      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );

      await userProvider.fetchUser();

      if (!mounted) return;

      Navigator.of(context).pop();

      Navigator.pushReplacementNamed(
        context,
        RoutesManager.homeRouteName,
      );

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      Navigator.of(context).pop();

      print("LOGIN FAILED");
      print("CODE: ${e.code}");
      print("MESSAGE: ${e.message}");

      String message;

      switch (e.code) {
        case 'user-not-found':
          message = "No user found for that email.";
          break;

        case 'wrong-password':
        case 'invalid-credential':
          message = "Incorrect email or password.";
          break;

        default:
          message = e.message ?? "Login failed.";
      }

      DialogUtils.showMessageDialog(
        context: context,
        content: message,
        actionTitle: "Ok",
        actionPress: () {
          Navigator.of(context).pop();
        },
      );
    }
  }


  Future<void> loginWithGoogle() async {
    try {
      DialogUtils.showLoadingDialog(context);
      final GoogleSignInAccount googleUser =
      await GoogleSignIn.instance.authenticate();
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;
      final AuthCredential googleCredential =
      GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(
        googleCredential,
      );
      final userProvider = Provider.of<UserProvider>(
        context,
        listen: false,
      );
      await userProvider.fetchUser();
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(
        context,
        RoutesManager.homeRouteName,
      );
      print("Google login SUCCESS: ${userCredential.user?.email}");
      print("UID: ${userCredential.user?.uid}");
    } on GoogleSignInException catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      DialogUtils.showMessageDialog(
        context: context,
        content: e.description ?? "Google login failed.",
        actionTitle: "Ok",
        actionPress: () {
          Navigator.of(context).pop();
        },
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      DialogUtils.showMessageDialog(
        context: context,
        content: e.message ?? "Google login failed.",
        actionTitle: "Ok",
        actionPress: () {
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      DialogUtils.showMessageDialog(
        context: context,
        content: "Google login exception: $e",
        actionTitle: "Ok",
        actionPress: () {
          Navigator.of(context).pop();
        },
      );
    }
  }

}
