import 'package:flutter/cupertino.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/splashScreen/onboardingScreen/constants/constants.dart';

class Slider {
  final String sliderImageUrl;
  final String sliderHeading;
  final String sliderSubHeading;

  Slider(
      {@required this.sliderImageUrl,
      @required this.sliderHeading,
      @required this.sliderSubHeading});
}

final sliderArrayList = [
  Slider(
      sliderImageUrl: slider1,
      sliderHeading: OnboardingConstants.SLIDER_HEADING_1,
      sliderSubHeading: OnboardingConstants.SLIDER_DESC1),
  Slider(
      sliderImageUrl: slider2,
      sliderHeading: OnboardingConstants.SLIDER_HEADING_2,
      sliderSubHeading: OnboardingConstants.SLIDER_DESC2),
  Slider(
      sliderImageUrl: slider3,
      sliderHeading: OnboardingConstants.SLIDER_HEADING_3,
      sliderSubHeading: OnboardingConstants.SLIDER_DESC3),
];
