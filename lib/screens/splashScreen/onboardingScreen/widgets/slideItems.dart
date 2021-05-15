import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/splashScreen/onboardingScreen/constants/constants.dart';
import 'package:trapo_care/screens/splashScreen/onboardingScreen/model/sliderModel.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height - 300;
    double _width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              direction: Axis.vertical,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 30, top: 50),
                    child: Material(
                      type: MaterialType.transparency,
                      elevation: 10.0,
                      child: Column(children: [
                        Image.asset(
                          trapocarebluered,
                          height: _height * 0.1,
                          width: _width * 0.4,
                          fit: BoxFit.fitWidth,
                        ),
                      ]),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      sliderArrayList[index].sliderHeading,
                      style: TextStyle(
                        fontFamily: OnboardingConstants.POPPINS,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Center(
                child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.99,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage(
                        sliderArrayList[index].sliderImageUrl,
                      ))),
            )),
            SizedBox(
              height: 60.0,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  sliderArrayList[index].sliderSubHeading,
                  style: TextStyle(
                    fontFamily: OnboardingConstants.OPEN_SANS,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ));
  }
}
