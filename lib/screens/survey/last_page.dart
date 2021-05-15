import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';

class SurveyLastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'Get Vaccine',
        child: kBackBtn,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 34.0, left: 20, right: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Find COVID-19 Vaccine!',
                style: TextStyle(
                    color: blueColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(survey1))),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/coWinScreen');
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Visit CoWIN Website',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/vaccineHospital');
                    },
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Text(
                          'Find a Vaccine Location',
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                  ))
            ]),
      ),
    );
  }
}
