import 'package:flutter/material.dart';
import 'package:ticketbooking/custom/customtextstyle.dart';
import 'package:ticketbooking/custom/screensizeconfig.dart';

class customtextformfiled extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final IconData? iconData;
  final bool isPassword;
  final FocusNode? focusNode;
  final VoidCallback? onSuffixTap;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;  // Add validator parameter

  customtextformfiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconData,
    this.isPassword = false,
    this.onSuffixTap,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,  // Add validator parameter
  });

  @override
  State<customtextformfiled> createState() => _customtextformfiledState();
}

class _customtextformfiledState extends State<customtextformfiled> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? obscureText : false,
      focusNode: widget.focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: subtittletextindigo,
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(14, 14, 14, 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: ScreenSizeConfig.primarycolor,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
        prefixIcon: Icon(
          widget.iconData,
          size: 25,
          color: ScreenSizeConfig.primarycolor,
        ),
        filled: true,
        fillColor: ScreenSizeConfig.customwhite,
        enabledBorder: commonBorder,
        focusedBorder: commonBorder,
        errorBorder: commonBorder,
        disabledBorder: commonBorder,
        focusedErrorBorder: commonBorder,
      ),
      keyboardType: TextInputType.emailAddress,
      validator: widget.validator,  // Use the passed validator function
      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }

  final OutlineInputBorder commonBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(
      color: Colors.transparent,
      width: 1.0,
    ),
  );
}
