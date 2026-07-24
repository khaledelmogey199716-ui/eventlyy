import 'package:evently_c19/core/resources/assets_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  String hint;
  String prefixPath;
  TextInputType keyboard;
  TextEditingController controller;
  bool isObscure;
  String? Function(String?) validation;
  CustomField({
    required this.validation,
    this.isObscure = false,
    required this.controller,
    required this.hint,
    required this.prefixPath,
    required this.keyboard,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validation,
      obscureText: widget.isObscure
          ?!isVisible
          :false,
      obscuringCharacter: '*',
      controller: widget.controller,
      keyboardType: widget.keyboard,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.onPrimary,
        filled: true,
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.labelSmall,
        suffixIcon: widget.isObscure?IconButton(
            onPressed: () {
          setState(() {
            isVisible = !isVisible;
          });
        }, icon: SvgPicture.asset(isVisible?AssetsManager.visibleOn:AssetsManager.visibleOff,height: 24,width: 24,))
        :null,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16, top: 12, bottom: 12),
          child: SvgPicture.asset(widget.prefixPath),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        )
      ),
    );
  }
}
