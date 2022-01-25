// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:spoticlone/Constants/AppColors.dart';

class OptionButton extends StatelessWidget {
  final String? title;
  const OptionButton({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 0.5, color: ApplicationColors.mainGreen)),
      child: Text(
        title!,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
