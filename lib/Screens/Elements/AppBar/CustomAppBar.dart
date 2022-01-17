import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spoticlone/Constants/AppColors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: const [
          Icon(
            FontAwesomeIcons.cloudSun,
            color: ApplicationColors.mainGreen,
          ),
          SizedBox(
            width: 14,
          ),
          Text(
            'Good Afternoon',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          Spacer(),
          Icon(Icons.notifications, color: ApplicationColors.mainGreen),
          SizedBox(
            width: 10,
          ),
          Icon(Icons.settings, color: ApplicationColors.mainGreen),
        ],
      ),
    );
  }
}
