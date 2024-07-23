class TranslationModel {
  late String login;
  late String enterEmail;
  late String enterPassword;
  late String loginError;
  late String inspectors;
  late String home;
  late String inspections;
  late String logout;

  late String totalInspections;
  late String totalTodayInspections;
  late String totalCompletedTodayInspections;
  late String totalPendingTodayInspections;
  late String totalAcceptedTodayInspections;
  late String totalCompletedInspections;

  late String inGeneral;
  late String inToday;
  late String welcome;
  late String completedInspections;

  late String total;
  late String today;

  late String todayInspections;
  late String pending;
  late String accepted;
  late String completed;
  late String createInspection;
  late String updateInspection;

  late String newInspection;
  late String beforeInspection;
  late String afterInspection;
  late String editInspection;
  late String cancel;
  late String errorOccurred;

  late String dashboard;
  late String accidentReports;
  late String insurancePolicy;
  late String serviceRequests;
  late String createNew;

  TranslationModel.fromJson(Map<String, dynamic> json) {
    errorOccurred = json['errorOccurred'];
    createInspection = json['createInspection'];
    updateInspection = json['updateInspection'];
    cancel = json['cancel'];
    newInspection = json['newInspection'];
    beforeInspection = json['beforeInspection'];
    afterInspection = json['afterInspection'];
    editInspection = json['editInspection'];
    todayInspections = json['todayInspections'];
    pending = json['pending'];
    accepted = json['accepted'];
    completed = json['completed'];

    total = json['total'];
    today = json['today'];

    completedInspections = json['completedInspections'];
    welcome = json['welcome'];
    inGeneral = json['inGeneral'];
    inToday = json['inToday'];

    totalInspections = json['totalInspections'];
    totalTodayInspections = json['totalTodayInspections'];
    totalCompletedTodayInspections = json['totalCompletedTodayInspections'];
    totalPendingTodayInspections = json['totalPendingTodayInspections'];
    totalAcceptedTodayInspections = json['totalAcceptedTodayInspections'];
    totalCompletedInspections = json['totalCompletedInspections'];

    home = json['home'];
    inspections = json['inspections'];
    logout = json['logout'];
    inspectors = json['inspectors'];
    loginError = json['loginError'];
    login = json['login'];
    enterEmail = json['enterEmail'];
    enterPassword = json['enterPassword'];
    dashboard = json['dashboard'];
    accidentReports = json['accidentReports'];
    insurancePolicy = json['insurancePolicy'];
    serviceRequests = json['serviceRequests'];
    createNew = json['createNew'];
  }
}
