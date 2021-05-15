class Post {
  String _username;
  String _hName;
  String _hContact;
  String _otherInfo;
  String _resourcestype;
  String _hAddress;
  String _verifiedBy;
  Post(this._username, this._hName, this._hContact, this._otherInfo,
      this._resourcestype, this._hAddress, this._verifiedBy);

  Post.map(dynamic obj) {
    this._username = obj['username'];
    this._hName = obj['hName'];
    this._hContact = obj['hContact'];
    this._otherInfo = obj['otherInfo'];
    this._resourcestype = obj['resourcestype'];
    this._hAddress = obj['hAddress'];
    this._verifiedBy = obj['verifiedBy'];
  }

  String get userName => _username;
  String get hospitalName => _hName;
  String get hospitalContact => _hContact;
  String get otherInfo => _otherInfo;
  String get resourcesType => _resourcestype;
  String get hospitalAddress => _hAddress;
  String get verifiedBy => _verifiedBy;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['username'] = _username;
    map['hName'] = _hName;
    map['hContact'] = _hContact;
    map['otherInfo'] = _otherInfo;
    map['resourcestype'] = _resourcestype;
    map['hAddress'] = _hAddress;
    map['verifiedBy'] = _verifiedBy;
    return map;
  }

  Post.fromMap(Map<String, dynamic> map) {
    this._username = map['username'];
    this._hName = map['hName'];
    this._hContact = map['hContact'];
    this._otherInfo = map['otherInfo'];
    this._resourcestype = map['resourcestype'];
    this._hAddress = map['hAddress'];
    this._verifiedBy = map['verifiedBy'];
  }
}

class OxygenPost {
  String _username;
  String _hName;
  String _hContact;
  String _otherInfo;
  String _resourcestype;
  String _hAddress;
  String _verifiedBy;
  String _verifiedOn;

  OxygenPost(this._username, this._hName, this._hContact, this._otherInfo,
      this._resourcestype, this._hAddress, this._verifiedBy, this._verifiedOn);

  OxygenPost.map(dynamic obj) {
    this._username = obj['username'];
    this._hName = obj['hName'];
    this._hContact = obj['hContact'];
    this._otherInfo = obj['otherInfo'];
    this._resourcestype = obj['resourcestype'];
    this._hAddress = obj['hAddress'];
    this._verifiedBy = obj['verifiedBy'];
    this._verifiedOn = obj['verifiedOn'];
  }

  String get userName => _username;
  String get hospitalName => _hName;
  String get hospitalContact => _hContact;
  String get otherInfo => _otherInfo;
  String get resourcesType => _resourcestype;
  String get hospitalAddress => _hAddress;
  String get verifiedBy => _verifiedBy;
  String get verifiedOn => _verifiedOn;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['username'] = _username;
    map['hName'] = _hName;
    map['hContact'] = _hContact;
    map['otherInfo'] = _otherInfo;
    map['resourcestype'] = _resourcestype;
    map['hAddress'] = _hAddress;
    map['verifiedBy'] = _verifiedBy;
    map['verifiedOn'] = _verifiedOn;
    return map;
  }

  OxygenPost.fromMap(Map<String, dynamic> map) {
    this._username = map['username'];
    this._hName = map['hName'];
    this._hContact = map['hContact'];
    this._otherInfo = map['otherInfo'];
    this._resourcestype = map['resourcestype'];
    this._hAddress = map['hAddress'];
    this._verifiedBy = map['verifiedBy'];
  }
}

class HomeCareModel {
  String _username;
  String _hName;
  String _hContact;
  String _otherInfo;
  String _resourcestype;
  String _hAddress;
  String _verifiedBy;
  String _pricePerDay;
  HomeCareModel(this._username, this._hName, this._hContact, this._otherInfo,
      this._resourcestype, this._hAddress, this._verifiedBy, this._pricePerDay);

  HomeCareModel.map(dynamic obj) {
    this._username = obj['username'];
    this._hName = obj['hName'];
    this._hContact = obj['hContact'];
    this._otherInfo = obj['otherInfo'];
    this._resourcestype = obj['resourcestype'];
    this._hAddress = obj['hAddress'];
    this._verifiedBy = obj['verifiedBy'];
    this._pricePerDay = obj['pricePerDay'];
  }

  String get userName => _username;
  String get hospitalName => _hName;
  String get hospitalContact => _hContact;
  String get otherInfo => _otherInfo;
  String get resourcesType => _resourcestype;
  String get hospitalAddress => _hAddress;
  String get verifiedBy => _verifiedBy;
  String get pricePerDay => _pricePerDay;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['username'] = _username;
    map['hName'] = _hName;
    map['hContact'] = _hContact;
    map['otherInfo'] = _otherInfo;
    map['resourcestype'] = _resourcestype;
    map['hAddress'] = _hAddress;
    map['verifiedBy'] = _verifiedBy;
    map['pricePerDay'] = _pricePerDay;
    return map;
  }

  HomeCareModel.fromMap(Map<String, dynamic> map) {
    this._username = map['username'];
    this._hName = map['hName'];
    this._hContact = map['hContact'];
    this._otherInfo = map['otherInfo'];
    this._resourcestype = map['resourcestype'];
    this._hAddress = map['hAddress'];
    this._verifiedBy = map['verifiedBy'];
    this._pricePerDay = map['pricePerDay'];
  }
}

class UpdatedPosts {
  String state,
      city,
      resourceType,
      resourceSubtype,
      availability,
      costperUnit,
      contactPerson,
      contactNumber,
      informationSource,
      userFullName;

  UpdatedPosts(
      this.state,
      this.city,
      this.resourceType,
      this.resourceSubtype,
      this.availability,
      this.costperUnit,
      this.contactPerson,
      this.contactNumber,
      this.informationSource,
      this.userFullName);

  UpdatedPosts.map(dynamic obj) {
    this.state = obj['State'];
    this.city = obj['City'];
    this.resourceType = obj['Resource Type'];
    this.resourceSubtype = obj['Resource Subtype'];
    this.availability = obj['Availability'];
    this.costperUnit = obj['Cost per Unit'];
    this.contactPerson = obj['Contact Person'];
    this.contactNumber = obj['Contact Number'];
    this.informationSource = obj['Information Source'];
    this.userFullName = obj['User Full Name'];
  }

  String get stateName => state;
  String get cityName => city;
  String get resourceTypeName => resourceType;
  String get resourceSubtypeName => resourceSubtype;
  String get availabilityName => availability;
  String get costperUnitName => costperUnit;
  String get contactPersonName => contactPerson;
  String get contactNumberName => contactNumber;
  String get informationSourceName => informationSource;
  String get userFullNameName => userFullName;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['State'] = state;
    map['City'] = city;
    map['Resource Type'] = resourceType;
    map['Resource Subtype'] = resourceSubtype;
    map['Availability'] = availability;
    map['Cost per Unit'] = costperUnit;
    map['Contact Person'] = contactPerson;
    map['Contact Number'] = contactNumber;
    map['Information Source'] = informationSource;
    map['User Full Name'] = userFullName;

    return map;
  }

  UpdatedPosts.fromMap(Map<String, dynamic> map) {
    this.state = map['State'];
    this.city = map['City'];
    this.resourceType = map['Resource Type'];
    this.resourceSubtype = map['Resource Subtype'];
    this.availability = map['Availability'];
    this.costperUnit = map['Cost per Unit'];
    this.contactPerson = map['Contact Person'];
    this.contactNumber = map['Contact Number'];
    this.informationSource = map['Information Source'];
    this.userFullName = map['User Full Name'];
  }
}
