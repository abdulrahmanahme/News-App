import 'package:flutter/material.dart';

class Text_Form_Widget extends StatelessWidget {
  String lableText;
  String hintText;
  Widget prefixIcon;
  Function onTap;
  Function validator;
  Function onChanged;
  TextInputType keyboardType;
  TextEditingController controller;
  Text_Form_Widget(
      {this.lableText,
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
          // backgroundColor: Colors.white,
        ),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: lableText,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 20,
          ),
          fillColor: Colors.grey,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).cardColor),
            borderRadius: BorderRadius.circular(10),
            gapPadding: 10,
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
