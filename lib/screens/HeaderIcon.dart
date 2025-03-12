import 'package:flutter/material.dart';
import 'package:sumitrecordingsapp/globals.dart';

class HeaderIcon extends StatelessWidget {
  const HeaderIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: GlobalColors.orange),
          height: 120.0,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: 60.0,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: GlobalColors.background,

              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
          ),
        ),

        Positioned(
          bottom: 20,
          width: MediaQuery.of(context).size.width,

          child: Center(
            child: CircleAvatar(
              minRadius: 40,
              maxRadius: 40,
              backgroundImage: AssetImage('assets/sumit_logo.png'),
            ),
          ),
        ),
      ],
    );
  }
}

