enum InspectionType { preInception, beforeRepair, supplement, afterRepair, rightSave }

extension InspectionTypeExtension on InspectionType {
  String get apiName {
    switch (this) {
      case InspectionType.preInception:
        return 'preInception';
      case InspectionType.beforeRepair:
        return 'beforeRepair';
      case InspectionType.supplement:
        return 'supplement';
      case InspectionType.afterRepair:
        return 'afterRepair';
      case InspectionType.rightSave:
        return 'rightSave';
    }
  }

  String get arName {
    switch (this) {
      case InspectionType.preInception:
        return 'اصدار';
      case InspectionType.beforeRepair:
        return 'قبل الاصلاح';
      case InspectionType.supplement:
        return 'ملحق';
      case InspectionType.afterRepair:
        return 'بعد الاصلاح';
      case InspectionType.rightSave:
        return 'حفظ حق';
    }
  }

  String get enName {
    switch (this) {
      case InspectionType.preInception:
        return 'Pre-Inception';
      case InspectionType.beforeRepair:
        return 'Before Repair';
      case InspectionType.supplement:
        return 'Supplement';
      case InspectionType.afterRepair:
        return 'After Repair';
      case InspectionType.rightSave:
        return 'Right Save';
    }
  }
}

enum Steps { created, policeReport, bRepair, supplement, resurvey, aRepair, rightSave, billing }

extension StepsExtention on Steps {
  String get title {
    switch (this) {
      case Steps.created:
        return 'FNOL';
      case Steps.policeReport:
        return 'Police Images';
      case Steps.bRepair:
        return 'Before Repair Images';
      case Steps.supplement:
        return 'Supplement Images';
      case Steps.resurvey:
        return 'Resurvey Images';
      case Steps.aRepair:
        return 'After Repair';
      case Steps.rightSave:
        return 'Right Save';
      case Steps.billing:
        return 'Billing';
    }
  }

  String get status {
    switch (this) {
      case Steps.created:
        return 'FNOL';
      case Steps.policeReport:
        return 'Police Report';
      case Steps.bRepair:
        return 'Before Repair';
      case Steps.supplement:
        return 'Supplement';
      case Steps.resurvey:
        return 'Resurvey';
      case Steps.aRepair:
        return 'After Repair';
      case Steps.rightSave:
        return 'Right Save';
      case Steps.billing:
        return 'Billing';
    }
  }

  String get subtitle {
    switch (this) {
      case Steps.created:
        return 'Accident Details';
      case Steps.policeReport:
        return 'Police Images';
      case Steps.bRepair:
        return 'Before Repair Images';
      case Steps.supplement:
        return 'Supplement Images';
      case Steps.resurvey:
        return 'Resurvey Images';
      case Steps.aRepair:
        return 'After Repair Location';
      case Steps.rightSave:
        return 'Right Save Location';
      case Steps.billing:
        return 'Billing';
    }
  }

  String get name {
    switch (this) {
      case Steps.created:
        return 'created';
      case Steps.policeReport:
        return 'policeReport';
      case Steps.bRepair:
        return 'bRepair';
      case Steps.supplement:
        return 'supplement';
      case Steps.resurvey:
        return 'resurvey';
      case Steps.aRepair:
        return 'aRepair';
      case Steps.rightSave:
        return 'rightSave';
      case Steps.billing:
        return 'billing';
    }
  }
}

enum InspectionsStatus {
  all,
  pending,
  finished,
  done,
}

enum SideMenu {
  dashboard,
  serviceRequests,
  accidentReports,
  fnol,
  beforeRepair,
  afterRepair,
  collectData,
  insurancePolicy,
  inspectionAssessment,
  preInception,
  beforeRepairInspection,
  supplementInspection,
  afterRepairInspection,
  rightSaveInspection,
  inspections,
  pendingInspections,
  finishedInspections,
  inspectors,
  reports,
  users,
  clients,
  drivers,
  inspectorsUsers,
  insuranceUsers,
  vehicles,
  driversMap,
  settings,
  adminCars,
  corporates,
  config,
  corporatePackageUsers,
  promoCodes,
  packagesPromoCodes,
  corporateUsers,
  packages,
  driversStatistics,
  busyDriversStatistics,
  freeDriversStatistics,
  offlineDriversStatistics,
  onlineDriversStatistics,
  vehiclesStatistics,
  busyVehiclesStatistics,
  freeVehiclesStatistics,
  onlineVehiclesStatistics,
  offlineVehiclesStatistics,
}

enum Rules {
  Admin,
  Insurance,
  Corporate,
  Broker,
  Manager,
  Super,
  SuperVisor,
  Inspector,
  CallCenter,
  InspectionManager,
  client,
  none;

  bool get isAdmin => this == Rules.Admin;

  bool get isInsurance => this == Rules.Insurance;

  bool get isCorporate => this == Rules.Corporate;

  bool get isBroker => this == Rules.Broker;

  bool get isManager => this == Rules.Manager;

  bool get isSuper => this == Rules.Super;

  bool get isSuperVisor => this == Rules.SuperVisor;

  bool get isInspector => this == Rules.Inspector;

  bool get isCallCenter => this == Rules.CallCenter;

  bool get isInspectionManager => this == Rules.InspectionManager;

  bool get isClient => this == Rules.client;

  bool get isNone => this == Rules.none;

  // get rule by name
  static Rules? getRuleByName(String name) {
    return Rules.values.firstWhere((element) => element.name == name);
  }
}
// enum Rules {
//   Insurance,
//   InspectionManager,
//   Inspector,
//   Corporate,
//   none,
// }

// const Roles = {
//   Admin: 'Admin', // Can do anything
//   Broker: 'Broker', // Can access Accidents , policies
//   CallCenter: 'CallCenter', // Can access Users, Cars, SR, Pkgs, PC
//   Client: 'Client',
//   Corporate: 'Corporate',
//   Driver: 'Driver',
//   Inspector: 'Inspector', // Can access Accidents , policies
//   Insurance: 'Insurance', // Can access Accidents , policies
//   Manager: 'Manager', // Can access Accidents , policies
//   Super: 'Super', // Can do anything
//   Supervisor: 'Supervisor', // Can access Accidents , policies, insurance CRU
// };

extension RulesExtension on Rules {
  String get name {
    switch (this) {
      case Rules.Insurance:
        return 'Insurance';
      case Rules.InspectionManager:
        return 'InspectionManager';
      case Rules.Inspector:
        return 'Inspector';
      case Rules.Corporate:
        return 'Corporate';
      case Rules.Admin:
        return 'Admin';
      case Rules.Broker:
        return 'Broker';
      case Rules.Manager:
        return 'Manager';
      case Rules.Super:
        return 'Super';
      case Rules.SuperVisor:
        return 'Supervisor';
      case Rules.CallCenter:
        return 'CallCenter';
      case Rules.client:
        return 'Client';
      case Rules.none:
        return 'none';
    }
  }

  int get id {
    switch (this) {
      case Rules.Insurance:
        return 8;
      case Rules.InspectionManager:
        // return -1;
        return 13;
      case Rules.Inspector:
        return 9;
      case Rules.Corporate:
        return 24;
      case Rules.Admin:
        return 3;
      case Rules.Broker:
        return 11;
      case Rules.Manager:
        return 1;
      case Rules.Super:
        return 2;
      case Rules.SuperVisor:
        return 7;
      case Rules.CallCenter:
        return 10;
      case Rules.client:
        return 5;
      case Rules.none:
        return 0;
    }
  }
}

enum InspectionStatus {
  pending,
  accepted,
  done,
  // separated
  finished,

  //
  cancelled,
}

enum InspectorTypes {
  company,
  individual,
}

extension InspectorTypesExtension on InspectorTypes {
  String get name {
    switch (this) {
      case InspectorTypes.company:
        return 'company';
      case InspectorTypes.individual:
        return 'individual';
    }
  }
}

enum CommitmentStatus {
  committed('committed', 'committed', 'بالتزام'),
  notCommitted('notCommitted', 'notCommitted', 'بدون التزام');

  const CommitmentStatus(this.val, this.enName, this.arName);

  final String val;
  final String enName;
  final String arName;
}

