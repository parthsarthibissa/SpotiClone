import 'package:flutter/material.dart';
import 'package:spoticlone/Constants/AppColors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: ApplicationColors.mainBlack),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.home,
            color: ApplicationColors.mainGreen,
          ),
          Icon(Icons.search, color: ApplicationColors.mainGreen),
          Icon(Icons.library_books, color: ApplicationColors.mainGreen),
        ],
      ),
    );
  }
}
