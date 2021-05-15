import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'dart:ui' as ui;

class SurveyScreenNew extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SurveyScreenNew>
    with TickerProviderStateMixin {
  AnimationController _animateController;
  AnimationController _longPressController;
  AnimationController _secondStepController;
  AnimationController _thirdStepController;
  AnimationController _fourStepController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username, number;
  getUsername(n) {
    this.username = n;
  }

  getNumber(a) {
    this.number = a;
  }

  int curIndex = 0;

  createData() {
    DocumentReference ds =
        Firestore.instance.collection('Covid Survey').document();
    Map<String, dynamic> post = {
      'User Full Name': username,
      'User Contact': number,
      'First Ans': firstAns,
      'Last Updated': FieldValue.serverTimestamp(),
    };

    ds.setData(post).whenComplete(() {
      print('Post Created');
    });
  }

  Animation<double> longPressAnimation;
  Animation<double> secondTranformAnimation;
  Animation<double> thirdTranformAnimation;
  Animation<double> fourTranformAnimation;

  @override
  void initState() {
    super.initState();

    _animateController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    _longPressController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _secondStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _thirdStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    _fourStepController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    longPressAnimation =
        Tween<double>(begin: 1.0, end: 2.0).animate(CurvedAnimation(
            parent: _longPressController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    fourTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _fourStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    secondTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _secondStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    thirdTranformAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: _thirdStepController,
            curve: Interval(
              0.1,
              1.0,
              curve: Curves.fastOutSlowIn,
            )));

    _longPressController.addListener(() {
      setState(() {});
    });

    _secondStepController.addListener(() {
      setState(() {});
    });

    _thirdStepController.addListener(() {
      setState(() {});
    });

    _fourStepController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _animateController.dispose();
    _secondStepController.dispose();
    _thirdStepController.dispose();
    _fourStepController.dispose();
    _longPressController.dispose();
    super.dispose();
  }

  Future _startAnimation() async {
    try {
      await _animateController.forward().orCancel;
      setState(() {});
    } on TickerCanceled {}
  }

  Future _startThirdStepAnimation() async {
    try {
      await _thirdStepController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    final ui.Size logicalSize = MediaQuery.of(context).size;
    final double _width = logicalSize.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: _animateController.isCompleted
              ? getPages(_width)
              : AnimationBox(
                  controller: _animateController,
                  screenWidth: _width - 32.0,
                  onStartAnimation: () {
                    _startAnimation();
                  },
                ),
        ),
      ),
      bottomNavigationBar: _animateController.isCompleted
          ? BottomAppBar(
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey.withAlpha(200))]),
              height: 50.0,
              child: curIndex == 2
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/surveyLastScreen');
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Text(
                            'Finish',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          curIndex += 1;
                          if (curIndex == 1) {
                            _startThirdStepAnimation();
                          } else if (curIndex == 2) {
                            Navigator.pushReplacementNamed(
                                context, '/surveyLastScreen');
                            //Navigator.pop(context);
                          }
                        });
                      },
                      child: Center(
                          child: Text(
                        curIndex < 1 ? 'Continue' : 'Finish',
                        style: TextStyle(fontSize: 20.0, color: redColor),
                      )),
                    ),
            ))
          : null,
    );
  }

  Widget getPages(double _width) {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 30.0),
              height: 10.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(2, (int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: index <= curIndex ? redColor : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    height: 10.0,
                    width: (_width - 32.0 - 15.0) / 2.0,
                    margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                  );
                }),
              ),
            ),
            curIndex == 0 ? _getFirstStep() : _getThirdStep(),
          ],
        ));
  }

  bool first = false,
      second = false,
      third = false,
      fourth = false,
      fifth = false,
      sixth = false,
      seventh = false,
      eighth = false;
  String firstAns = '';
  Widget _getFirstStep() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Do you plan to get vaccinated?',
              style: TextStyle(
                  color: blueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  firstAns = 'Yes, I have already booked a slot.';
                  first = true;
                  second = false;
                  third = false;
                  fourth = false;
                  fifth = false;
                  sixth = false;
                  seventh = false;
                  eighth = false;
                  print(firstAns);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        width: 1.5, color: first ? redColor : Colors.grey)),
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Yes, I have already booked a slot.',
                  style: TextStyle(
                      color: first ? redColor : blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  firstAns =
                      'Yes, i am waiting for a slot to become available.';
                  second = true;
                  first = false;
                  third = false;
                  fourth = false;
                  fifth = false;
                  sixth = false;
                  seventh = false;
                  eighth = false;
                  print(firstAns);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        width: 1.5, color: second ? redColor : Colors.grey)),
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Yes, i am waiting for a slot to become available.',
                  style: TextStyle(
                      color: second ? redColor : blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  firstAns = 'No, I\'m worried about the side effects.';
                  third = true;
                  first = false;
                  second = false;
                  fourth = false;
                  fifth = false;
                  sixth = false;
                  seventh = false;
                  eighth = false;
                  print(firstAns);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        width: 1.5, color: third ? redColor : Colors.grey)),
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'No, I\'m worried about the side effects.',
                  style: TextStyle(
                      color: third ? redColor : blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  fourth = true;
                  first = false;
                  second = false;
                  third = false;
                  firstAns = 'No, I\'m worried about waiting in the crowd.';
                  fifth = false;
                  sixth = false;
                  seventh = false;
                  eighth = false;
                  print(firstAns);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        width: 1.5, color: fourth ? redColor : Colors.grey)),
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'No, I\'m worried about waiting in the crowd.',
                  style: TextStyle(
                      color: fourth ? redColor : blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  fifth = true;
                  first = false;
                  second = false;
                  third = false;
                  fourth = false;
                  firstAns = 'No, I don\'t think the vaccine works.';
                  sixth = false;
                  seventh = false;
                  eighth = false;
                  print(firstAns);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        width: 1.5, color: fifth ? redColor : Colors.grey)),
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'No, I don\'t think the vaccine works.',
                  style: TextStyle(
                      color: fifth ? redColor : blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  sixth = true;
                  first = false;
                  second = false;
                  third = false;
                  fourth = false;
                  fifth = false;
                  firstAns = 'No, I\'m worried about COVID-19 anymore.';
                  seventh = false;
                  eighth = false;
                  print(firstAns);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        width: 1.5, color: sixth ? redColor : Colors.grey)),
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'No, I\'m worried about COVID-19 anymore.',
                  style: TextStyle(
                      color: sixth ? redColor : blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  seventh = true;
                  first = false;
                  second = false;
                  third = false;
                  fourth = false;
                  fifth = false;
                  sixth = false;
                  firstAns = 'I\'m already vaccinated.';
                  print(firstAns);
                  eighth = false;
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        width: 1.5, color: seventh ? redColor : Colors.grey)),
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'I\'m already vaccinated.',
                  style: TextStyle(
                      color: seventh ? redColor : blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  eighth = true;
                  first = false;
                  second = false;
                  third = false;
                  fourth = false;
                  fifth = false;
                  sixth = false;
                  seventh = false;
                  firstAns = 'Other';
                  print(firstAns);
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        width: 1.5, color: eighth ? redColor : Colors.grey)),
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Other',
                  style: TextStyle(
                      color: eighth ? redColor : blueColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getThirdStep() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 34.0),
        child: Transform(
          transform: new Matrix4.translationValues(
              0.0, 50.0 * (1.0 - thirdTranformAnimation.value), 0.0),
          child: Opacity(
            opacity: thirdTranformAnimation.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(survey2))),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 50.0, bottom: 20.0, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Thank you for taking the survey!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: blueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22.0),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          '#StaySafe',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: blueColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimationBox extends StatelessWidget {
  AnimationBox(
      {Key key, this.controller, this.screenWidth, this.onStartAnimation})
      : width = Tween<double>(
          begin: screenWidth,
          end: 40.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.1,
              0.3,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        alignment = Tween<AlignmentDirectional>(
          begin: AlignmentDirectional.bottomCenter,
          end: AlignmentDirectional.topStart,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        radius = BorderRadiusTween(
          begin: BorderRadius.circular(20.0),
          end: BorderRadius.circular(2.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.6,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 40.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.8,
              curve: Curves.ease,
            ),
          ),
        ),
        movement = EdgeInsetsTween(
          begin: EdgeInsets.only(top: 0.0),
          end: EdgeInsets.only(top: 30.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.3,
              0.6,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        scale = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        opacity = Tween<double>(
          begin: 1.0,
          end: 0.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        numberOfStep = IntTween(
          begin: 1,
          end: 4,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        super(key: key);

  final VoidCallback onStartAnimation;
  final Animation<double> controller;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<AlignmentDirectional> alignment;
  final Animation<BorderRadius> radius;
  final Animation<EdgeInsets> movement;
  final Animation<double> opacity;
  final Animation<double> scale;
  final Animation<int> numberOfStep;
  final double screenWidth;
  final double overral = 2.0;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return Stack(
          alignment: alignment.value,
          children: <Widget>[
            Opacity(
              opacity: 1.0 - opacity.value,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 30.0),
                    height: 10.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(2, (int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: index == 0 ? redColor : Colors.grey,
                            borderRadius:
                                BorderRadius.all(Radius.circular(2.0)),
                          ),
                          height: 10.0,
                          width: (screenWidth - 15.0) / 2.0,
                          margin: EdgeInsets.only(left: index == 0 ? 0.0 : 5.0),
                        );
                      }),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 34.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Do you plan to get vaccinated?',
                            style: TextStyle(
                                color: blueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                      width: 1.5, color: Colors.grey)),
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text(
                                'Yes, I have already booked a slot.',
                                style:
                                    TextStyle(color: blueColor, fontSize: 18),
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                      width: 1.5, color: Colors.grey)),
                              margin: EdgeInsets.only(top: 16.0),
                              child: Text(
                                'Yes, i am waiting for a slot to become available.',
                                style:
                                    TextStyle(color: blueColor, fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Opacity(
              opacity:
                  controller.status == AnimationStatus.dismissed ? 1.0 : 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(trapocarebluered))),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Vaccination \nSurvey',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 28.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(survey1))),
                  )),
                  Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 90.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey!',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: blueColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Thank you for opting to take part in this survey.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: blueColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'We\'d like to get to know your outlook on \ngetting yourself vaccinated against COVID-19',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: blueColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'This should take less than 1 min \nAll responses will remain confidencial.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: blueColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Opacity(
              opacity: opacity.value,
              child: GestureDetector(
                onTap: onStartAnimation,
                child: Transform.scale(
                  scale: scale.value,
                  child: Container(
                    margin: movement.value,
                    width: width.value * 1.4,
                    child: GestureDetector(
                      child: Container(
                        height: height.value * 1.4,
                        decoration: BoxDecoration(
                            color: redColor, borderRadius: radius.value * 1.4),
                        child: Center(
                          child: controller.status == AnimationStatus.dismissed
                              ? Text(
                                  'Start Survey',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20.0),
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
//
          ],
        );
      },
    );
  }
}

class SecondQuestion {
  final String identifier;
  final String displayContent;

  SecondQuestion(this.identifier, this.displayContent);
}

class ThirdQuestion {
  final String displayContent;
  bool isSelected;

  ThirdQuestion(this.displayContent, this.isSelected);
}
