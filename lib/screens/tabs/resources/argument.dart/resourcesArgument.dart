import 'package:cloud_firestore/cloud_firestore.dart';

class ResourcesArguments {
  final String state,
      city,
      address,
      resourceType,
      resourceSubtype,
      otherDetails,
      costperUnit,
      contactPerson,
      contactNumber,
      informationSource,
      userFullName;
  final Timestamp date;

  ResourcesArguments(
      this.state,
      this.city,
      this.address,
      this.resourceType,
      this.resourceSubtype,
      this.otherDetails,
      this.costperUnit,
      this.contactPerson,
      this.contactNumber,
      this.informationSource,
      this.userFullName,
      this.date);
}
