import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trapo_care/controller/color.dart';

class NothingFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        type: MaterialType.transparency,
        elevation: 10.0,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: 250,
            width: 250,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: blueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(900),
            ),
            child: Lottie.asset(
              'assets/animation/searching.json',
              repeat: true,
              reverse: true,
              animate: true,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Shimmer.fromColors(
              baseColor: blueColor,
              highlightColor: Colors.grey[100],
              enabled: true,
              child: Text('Nothing found...',
                  style: TextStyle(
                    color: blueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))),
        ]),
      ),
    );
  }
}
