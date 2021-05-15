import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/screens/splashScreen/onboardingScreen/constants/constants.dart';
import 'dart:async';

import 'package:trapo_care/screens/splashScreen/onboardingScreen/model/sliderModel.dart';
import 'package:trapo_care/screens/splashScreen/onboardingScreen/widgets/slideDots.dart';
import 'package:trapo_care/screens/splashScreen/onboardingScreen/widgets/slideItems.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black87,
    primary: Colors.grey[300],
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) => topSliderLayout();

  Widget topSliderLayout() => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: <Widget>[
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: sliderArrayList.length,
                itemBuilder: (ctx, i) => SlideItem(i),
              ),
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (_currentPage < 2) {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        _currentPage++;
                      } else if (_currentPage == 2) {
                        Navigator.pushReplacementNamed(context, '/home');
                      } else {
                        _currentPage = 0;
                      }
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0, bottom: 15.0),
                        child: Text(
                          OnboardingConstants.NEXT,
                          style: TextStyle(
                            fontFamily: OnboardingConstants.OPEN_SANS,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 15.0, bottom: 15.0),
                        child: GestureDetector(
                          onTap: () => Future.delayed(Duration.zero, () {
                            Navigator.pushReplacementNamed(context, '/home');
                          }),
                          child: Text(
                            OnboardingConstants.SKIP,
                            style: TextStyle(
                              fontFamily: OnboardingConstants.OPEN_SANS,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                  ),
                  Container(
                    alignment: AlignmentDirectional.bottomCenter,
                    margin: EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < sliderArrayList.length; i++)
                          if (i == _currentPage)
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
