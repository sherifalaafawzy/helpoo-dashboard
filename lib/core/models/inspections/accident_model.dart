class AccidentModel {
  String? description;
  String? opinion;

  AccidentModel({
    this.description,
    this.opinion,
  });

  AccidentModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    opinion = json['opinion'];
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'opinion': opinion,
    };
  }
}

