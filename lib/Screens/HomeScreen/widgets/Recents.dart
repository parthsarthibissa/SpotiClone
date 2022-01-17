import 'package:flutter/material.dart';
import 'package:spoticlone/Constants/AppColors.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      children: const [
        RecentItem(),
        RecentItem(),
        RecentItem(),
        RecentItem(),
        RecentItem(),
        RecentItem(),
      ],
    );
  }
}

class RecentItem extends StatelessWidget {
  const RecentItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ApplicationColors.mainGreen.withOpacity(0.5),
                    offset: Offset(5, 0)),
              ],
              border:
                  Border.all(color: ApplicationColors.mainGreen, width: 0.2),
              shape: BoxShape.circle,
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      ApplicationColors.mainBlack.withOpacity(0.5),
                      BlendMode.darken),
                  image: const AssetImage('assets/images/moosetape.jpg'))),
          child: const Icon(
            Icons.play_circle,
            color: ApplicationColors.mainGreen,
          ),
        ),
        const Text(
          'Moosetape',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
        )
      ],
    );
  }
}
