import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


Widget defaultFormField({
  TextEditingController controller,
  TextInputType type,
  ValueChanged<String> onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  String label,
  IconData prefix,
  TextStyle style,
  IconData suffix,
  Function suffixpress,
  Widget suffixIcon,
  int maxLines = 1,
  String hintText,
}) =>
    Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        style: style,
        onTap: onTap,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(
              color: Color(0xff9D9491),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          hintText: hintText,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );

Widget errorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/image/bad_request_error.png'),
                const SizedBox(height: 20.0),
                Text(
                  'There something happened please try later',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.fade),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  };
}

class ConvertToTimeAgo {
  static String convertToTimeAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inDays} ${('day').tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inDays} ${'day'.tr()}';
    } else if (diff.inHours == 2 || diff.inHours <= 10) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inHours} ${'hours'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inHours} ${'hours'.tr()}';
    } else if (diff.inHours == 1 || diff.inHours >= 11) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inHours} ${'hour'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inHours} ${'hour'.tr()}';
    } else if (diff.inMinutes >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inMinutes} ${'minute'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inMinutes} ${'minute'.tr()}';
    } else if (diff.inSeconds >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inSeconds} ${'second'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inSeconds} ${'second'.tr()}';
    } else {
      return 'just now'.tr();
    }
  }
}

class Text_Form_Widget extends StatelessWidget {
  String labelText;
  String hintText;
  Widget prefixIcon;
  Function onTap;
  Function validator;
  Function onChanged;
  TextInputType keyboardType;
  TextEditingController controller;
  Text_Form_Widget(
      {this.labelText,
      this.hintText,
      this.prefixIcon,
      this.onTap,
      this.validator,
      this.keyboardType,
      this.controller,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextFormField(
        keyboardType: keyboardType,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
            hintStyle: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.w400,
              fontSize: 18.sp),
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 10,
          ),
          fillColor: Colors.grey[200],
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
        onTap: onTap,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
