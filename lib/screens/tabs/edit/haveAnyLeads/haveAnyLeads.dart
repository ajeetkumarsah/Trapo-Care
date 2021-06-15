import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:trapo_care/controller/color.dart';
import 'package:trapo_care/screens/tabs/edit/helper/helper.dart';
import 'package:trapo_care/screens/widgets/custom_appbar.dart';
import 'package:trapo_care/screens/widgets/myTextFormField.dart';

class HaveAnyLeads extends StatefulWidget {
  final String lusername, lphone;

  const HaveAnyLeads({Key key, this.lusername, this.lphone}) : super(key: key);
  @override
  _HaveAnyLeadsState createState() => _HaveAnyLeadsState();
}

class _HaveAnyLeadsState extends State<HaveAnyLeads> {
  final _formKey = GlobalKey<FormState>();
  bool _btnEnabled = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
//controller

  //strings
  String username,
      rCity,
      rState,
      costperUnit,
      contactPerson,
      usercontactNumber,
      contactNumber,
      informationSource,
      otherDetails;

  ///  states and cites
  List<String> city = [];
  String selectedState;
  String selectedCity;

  ///resources
  List<String> resource = [];
  String selectedResourceType;
  String selectedResourceSubtype;
//selected availability
  String selctedAvailability;

  /////csc
  String countryValue = '';

  String address;
  getUserName(n) {
    this.username = n;
  }

  getAddress(a) {
    this.address = a;
  }

  getContact(c) {
    this.usercontactNumber = c;
  }

  getCostperUnit(r) {
    this.costperUnit = r;
  }

  getContactPerson(r) {
    this.contactPerson = r;
  }

  getContactNumber(n) {
    this.contactNumber = n;
  }

  getInformationSource(o) {
    this.informationSource = o;
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

//data create
  createData() {
    DocumentReference ds =
        Firestore.instance.collection('Have any Leads').document();
    Map<String, dynamic> post = {
      "State": selectedState,
      "City": selectedCity,
      'Address': address,
      "Resource Type": selectedResourceType,
      "Resource Subtype": selectedResourceSubtype,
      'searchKey': selectedCity[0].toUpperCase(),
      'Cost per Unit': costperUnit,
      'Contact or Organization': contactPerson,
      'Contact Number': contactNumber,
      'Information Source': informationSource,
      'User Full Name': username,
      'Last Updated': FieldValue.serverTimestamp(),
      'createdAt': FieldValue.serverTimestamp(),
      'userContact': usercontactNumber,
      'Status': 'Unverified',
      'Other Details': otherDetails,
      'Verified By': '',
    };

    ds.setData(post).whenComplete(() {
      print('Post Created');
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(Duration(seconds: 2), () {
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

  void _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(40),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                new CircularProgressIndicator(),
                new Text(
                  "Please wait...",
                  style: TextStyle(
                    color: blueColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    new Future.delayed(new Duration(seconds: 3), () {
      Navigator.pop(context); //pop dialog
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      key: _scaffoldKey,
      appBar: CustomAppBar(
        onPressed: () => Navigator.pop(context),
        title: 'Add verified information',
        fontSize: 20,
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
                      SizedBox(
                        height: 10,
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
                              items: resources.map((String value) {
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
                                } else if (r == 'Blood Bank') {
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
                        labelText: 'Address (Optional)',
                        onChanged: (String n) {
                          getAddress(n);
                        },
                      ),
                      MyTextFormField(
                        labelText: 'Cost per Unit in ₹ (Optional)',
                        isNumber: true,
                        // requiredField: true,
                        onChanged: (String n) {
                          getCostperUnit(n);
                        },
                      ),
                      MyTextFormField(
                        labelText: 'Contact Person or Organization Name',
                        onChanged: (String h) {
                          getContactPerson(h);
                          getContact(widget.lphone);
                          getUserName(widget.lusername);
                        },
                        requiredField: true,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Field can\'t be empty!';
                          }
                          return null;
                        },
                      ),
                      MyTextFormField(
                        labelText: 'Contact Number',
                        requiredField: true,
                        isNumber: true,
                        limit: true,
                        onChanged: (String a) {
                          getContactNumber(a);
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
                        labelText: 'Information Source',
                        onChanged: (String c) {
                          getInformationSource(c);
                        },
                      ),
                      MyTextFormField(
                        labelText: 'Your Full Name',
                        requiredField: true,
                        initialValue: widget.lusername,
                        //controller: _usernameController,
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
                                      _onLoading();
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
                                                  'Provide the required fields!')));
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
