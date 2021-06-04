import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/screens/tabs/edit/helper/helper.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/myTextFormField.dart';

class EmergencyScreen extends StatefulWidget {
  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _btnEnabled = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
//controller

  //strings
  String username, contactNumber, otherDetails;

  ///  states and cites

  String selectedState;
  String selectedCity;
  String countryValue = '';
  // //resources
  List<String> resource = [];
  String selectedResourceType;
  String selectedResourceSubtype;

  getUserName(n) {
    this.username = n;
  }

  getContact(c) {
    this.contactNumber = c;
  }

  getResourceType(r) {
    this.selectedResourceType = r;
  }

  getSubResource(s) {
    this.selectedResourceSubtype = s;
  }

  getOtherDetails(o) {
    this.otherDetails = o;
  }

////data create
  createData() {
    DocumentReference ds =
        Firestore.instance.collection('Emergency').document();
    Map<String, dynamic> post = {
      "State": selectedState,
      "City": selectedCity,
      "Resource Type": selectedResourceType,
      "Resource Subtype": selectedResourceSubtype,
      'Contact Number': contactNumber,
      'User Full Name': username,
      'createdAt': FieldValue.serverTimestamp(),
      'Status': 'Incomplete',
      'Other Details': otherDetails,
    };

    ds.setData(post).whenComplete(() {
      print('Post Created');
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(
              title: Text(
                'Trapo Care',
                textAlign: TextAlign.center,
              ),
              content: Text(
                'Thank you for your help!',
                textAlign: TextAlign.center,
              ),
            );
          });
    });
  }

  List<String> eresources = [
    'Resource Type*',
    'Oxygen',
    'Bed | ICU',
    'Blood | Plasma',
    'Ambulance',
    'Food',
    'Medicine',
    'Covid Testing',
    'Home Care Facilities',
    'Doctor',
    'Hospital',
    'Helpline and Other Resources',
    'COVID Consultation with Doctor',
    'Mortuary Van',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'Emergency Details',
        child: kBackBtn,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1.2,
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      Center(
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                CSCPicker(
                                  showStates: true,
                                  showCities: true,
                                  defaultCountry: DefaultCountry.India,
                                  flagState: CountryFlag.DISABLE,
                                  onCountryChanged: (value) {
                                    setState(() {
                                      countryValue = value;
                                    });
                                  },
                                  onStateChanged: (value) {
                                    setState(() {
                                      selectedState = value;
                                    });
                                  },
                                  onCityChanged: (value) {
                                    setState(() {
                                      selectedCity = value;
                                    });
                                  },
                                  selectedItemStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  dropdownHeadingStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                  dropdownItemStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  dropdownDialogRadius: 10.0,
                                  searchBarRadius: 10.0,
                                ),
                              ],
                            )),
                      ),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            padding: EdgeInsets.only(left: 30, right: 30),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(
                                color: Colors.grey[300],
                                width: 1.5,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                            child: DropdownButton<String>(
                              hint: Text('Resource Type*'),
                              value: selectedResourceType,
                              isExpanded: true,
                              items: eresources.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (r) {
                                if (r == 'Oxygen') {
                                  resource = oxygenResource;
                                } else if (r == 'Bed | ICU') {
                                  resource = bedicuResource;
                                } else if (r == 'Blood | Plasma') {
                                  resource = bloodplasmaResource;
                                } else if (r == 'Ambulance') {
                                  resource = ambulanceResource;
                                } else if (r == 'Medicine') {
                                  resource = medicineResource;
                                } else if (r == 'Food') {
                                  resource = foodResource;
                                } else if (r == 'Covid Testing') {
                                  resource = covidTestingResource;
                                } else if (r == 'Home Care Facilities') {
                                  resource = homeCareFacilitiesResource;
                                } else if (r == 'Doctor') {
                                  resource = doctorResource;
                                } else if (r == 'Hospital') {
                                  resource = hospitalResource;
                                } else if (r ==
                                    'Helpline and Other Resources') {
                                  resource = helplineAndOtherResource;
                                } else {
                                  resource = [];
                                }
                                setState(() {
                                  selectedResourceSubtype = null;
                                  selectedResourceType = r;
                                  getResourceType(r);
                                });
                              },
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(
                                  color: Colors.grey[300],
                                  width: 1.5,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              child: DropdownButton<String>(
                                hint: Text('Resource Subtype'),
                                value: selectedResourceSubtype,
                                isExpanded: true,
                                items: resource.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (resource) {
                                  setState(() {
                                    selectedResourceSubtype = resource;
                                    getSubResource(resource);
                                  });
                                },
                              ))),
                      MyTextFormField(
                        labelText: 'Your Number',
                        requiredField: true,
                        isNumber: true,
                        limit: true,
                        onChanged: (String a) {
                          getContact(a);
                          setState(() =>
                              _btnEnabled = _formKey.currentState.validate());
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Contact Number is empty';
                          } else if (text.length < 10) {
                            return 'Number is not <10';
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        labelText: 'Your Full Name',
                        requiredField: true,
                        onChanged: (String o) {
                          getUserName(o);
                          setState(() =>
                              _btnEnabled = _formKey.currentState.validate());
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Your name is empty';
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        labelText: 'Other Details (Optional)',
                        onChanged: (String o) {
                          getOtherDetails(o);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // ignore: deprecated_member_use
                          RaisedButton(
                              color: redColor,
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.white),
                              )),
                          // This button results in adding the contact to the database
                          // ignore: deprecated_member_use
                          _btnEnabled
                              // ignore: deprecated_member_use
                              ? RaisedButton(
                                  color: blueColor,
                                  onPressed: () {
                                    if (_formKey.currentState.validate() &&
                                        selectedCity != null &&
                                        selectedState != null &&
                                        selectedResourceType != null &&
                                        countryValue == 'India') {
                                      createData();
                                    } else if (countryValue != 'India') {
                                      // ignore: deprecated_member_use
                                      _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  "Selected Country is not 'India'")));
                                    } else {
                                      // ignore: deprecated_member_use
                                      _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  'Provide the required fields!')));
                                    }
                                  },
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
                                  ))
                              // ignore: deprecated_member_use
                              : RaisedButton(
                                  color: Colors.grey,
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      // ignore: deprecated_member_use
                                      _scaffoldKey.currentState.showSnackBar(
                                          new SnackBar(
                                              content: new Text(
                                                  'Fill the required fields!')));
                                    }
                                  },
                                  child: const Text(
                                    "Submit",
                                    style: TextStyle(color: Colors.white),
                                  )),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
