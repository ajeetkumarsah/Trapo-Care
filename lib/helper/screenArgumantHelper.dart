class OxygenPostViewScreenArguments {
  final String username,
      hospitalName,
      hContact,
      otherInfo,
      hAddress,
      resourcestype,
      verifiedBy,
      verifiedOn;

  OxygenPostViewScreenArguments(
      this.username,
      this.hospitalName,
      this.hContact,
      this.otherInfo,
      this.hAddress,
      this.resourcestype,
      this.verifiedBy,
      this.verifiedOn);
}

class PlasmaBloodPostViewScreenArguments {
  final String username,
      hospitalName,
      hContact,
      otherInfo,
      hAddress,
      resourcestype,
      verifiedBy;

  PlasmaBloodPostViewScreenArguments(
      this.username,
      this.hospitalName,
      this.hContact,
      this.otherInfo,
      this.hAddress,
      this.resourcestype,
      this.verifiedBy);
}

class HomeCarePostViewScreenArguments {
  final String username,
      hospitalName,
      hContact,
      otherInfo,
      hAddress,
      resourcestype,
      verifiedBy,
      pricePerDay;

  HomeCarePostViewScreenArguments(
      this.username,
      this.hospitalName,
      this.hContact,
      this.otherInfo,
      this.hAddress,
      this.resourcestype,
      this.verifiedBy,
      this.pricePerDay);
}
