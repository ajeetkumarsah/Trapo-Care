import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/helper/imageHelper.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/get_post.dart';

class DoctorsScreen extends StatefulWidget {
  @override
  _DoctorsScreenState createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  int defaultChoiceIndex;

  List<String> _choicesList = [
    'All',
    'COVID Consultation',
    'General Physician',
    'Pediatrician',
    'Gynaecologist',
    'Dentist',
    'Ophthalmologist',
    'Dermatologist',
    'Urologist',
    'ENT (Ear, Nose, Throat)',
    'Dietician',
    'Physiotherapist',
    'Neurologist',
    'Cardiologist',
    'Orthopedist',
    'Homeopath',
    'Ayurveda',
    'General Surgeon',
    'Gastroenterologist',
    'Psychologist',
  ];

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: whiteColor,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          onPressed: () => Navigator.pop(context),
          title: 'Doctors',
          child: kBackBtn,
        ),
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('Have any Leads')
                .where('Status', isEqualTo: 'Verified')
                .where('Resource Type', isEqualTo: 'Doctor')
                .where('Resource Subtype',
                    isEqualTo: defaultChoiceIndex == 1
                        ? 'COVID Consultation'
                        : defaultChoiceIndex == 2
                            ? 'General Physician'
                            : defaultChoiceIndex == 3
                                ? 'Pediatrician'
                                : defaultChoiceIndex == 4
                                    ? 'Gynaecologist'
                                    : defaultChoiceIndex == 5
                                        ? 'Dentist'
                                        : defaultChoiceIndex == 6
                                            ? 'Ophthalmologist'
                                            : defaultChoiceIndex == 7
                                                ? 'Dermatologist'
                                                : defaultChoiceIndex == 8
                                                    ? 'Urologist'
                                                    : defaultChoiceIndex == 9
                                                        ? 'ENT (Ear, Nose, Throat)'
                                                        : defaultChoiceIndex ==
                                                                10
                                                            ? 'Dietician'
                                                            : defaultChoiceIndex ==
                                                                    11
                                                                ? 'Physiotherapist'
                                                                : defaultChoiceIndex ==
                                                                        12
                                                                    ? 'Neurologist'
                                                                    : defaultChoiceIndex ==
                                                                            13
                                                                        ? 'Cardiologist'
                                                                        : defaultChoiceIndex ==
                                                                                14
                                                                            ? 'Orthopedist'
                                                                            : defaultChoiceIndex == 15
                                                                                ? 'Homeopath'
                                                                                : defaultChoiceIndex == 16
                                                                                    ? 'Ayurveda'
                                                                                    : defaultChoiceIndex == 17
                                                                                        ? 'General Surgeon'
                                                                                        : defaultChoiceIndex == 18
                                                                                            ? 'Gastroenterologist'
                                                                                            : defaultChoiceIndex == 19
                                                                                                ? 'Psychologist'
                                                                                                : null)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.data.documents.isEmpty) {
                return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Row(children: [
                            new Flexible(
                                child: new CustomScrollView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    slivers: <Widget>[
                                  new SliverPadding(
                                    padding: const EdgeInsets.all(6.0),
                                    sliver: new SliverList(
                                      delegate: new SliverChildListDelegate(
                                        <Widget>[
                                          Wrap(
                                              spacing: 8.0,
                                              children: List.generate(
                                                  _choicesList.length, (index) {
                                                return ChoiceChip(
                                                  labelPadding:
                                                      EdgeInsets.all(2.0),
                                                  label: Text(
                                                    _choicesList[index],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                  selected:
                                                      defaultChoiceIndex ==
                                                          index,
                                                  selectedColor: redColor,
                                                  backgroundColor: blueColor
                                                      .withOpacity(0.4),

                                                  onSelected: (value) {
                                                    setState(() {
                                                      defaultChoiceIndex = value
                                                          ? index
                                                          : defaultChoiceIndex;
                                                    });
                                                  },
                                                  // backgroundColor: color,
                                                  elevation: 1,
                                                  padding: EdgeInsets.all(8.0),
                                                );
                                              }))
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                          ]),
                        ),
                        SizedBox(
                          height: _height * 0.3,
                        ),
                        Center(
                          child: Material(
                            type: MaterialType.transparency,
                            elevation: 10.0,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    empty,
                                    height: _height * 0.2,
                                    width: _width * 0.3,
                                    fit: BoxFit.fitWidth,
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
                        )
                      ],
                    ));
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Row(children: [
                        new Flexible(
                            child: new CustomScrollView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                slivers: <Widget>[
                              new SliverPadding(
                                padding: const EdgeInsets.all(6.0),
                                sliver: new SliverList(
                                  delegate: new SliverChildListDelegate(
                                    <Widget>[
                                      Wrap(
                                          spacing: 8.0,
                                          children: List.generate(
                                              _choicesList.length, (index) {
                                            return ChoiceChip(
                                              labelPadding: EdgeInsets.all(2.0),
                                              label: Text(
                                                _choicesList[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                              ),
                                              selected:
                                                  defaultChoiceIndex == index,
                                              selectedColor: redColor,
                                              backgroundColor:
                                                  blueColor.withOpacity(0.4),

                                              onSelected: (value) {
                                                setState(() {
                                                  defaultChoiceIndex = value
                                                      ? index
                                                      : defaultChoiceIndex;
                                                });
                                              },
                                              // backgroundColor: color,
                                              elevation: 1,
                                              padding: EdgeInsets.all(8.0),
                                            );
                                          }))
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                      ]),
                    ),
                    GetPosts(
                      snapshot: snapshot,
                    ),
                  ]),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
