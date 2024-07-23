class ImageModel {
  String? text;
  String? reco64;
  String? imagePath;
  String? audioText;

  ImageModel({this.text, this.reco64, this.imagePath, this.audioText});

  ImageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? '';
    reco64 = json['audioPath'] ?? '';
    imagePath = json['imagePath'] ?? '';
    audioText = json['audioText'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = imagePath;
    data['text'] = text;
    data['audio'] = reco64;
    data['audioText'] = audioText;
    return data;
  }
}

class SupplementImageModel {
  String? text;
  String? reco64;
  String? imagePath;
  String? audioText;

  SupplementImageModel({this.text, this.reco64, this.imagePath, this.audioText});

  SupplementImageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'] ?? '';
    reco64 = json['audioPath'] ?? '';
    imagePath = json['imagePath'] ?? '';
    audioText = json['audioText'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imagePath'] = imagePath;
    data['text'] = text;
    data['audioPath'] = reco64;
    data['audioText'] = audioText;
    return data;
  }
}

class UploadImageModel {
  String? text;
  String? image;

  UploadImageModel({
    this.text,
    this.image,
  });

  UploadImageModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'image': image,
    };
  }
}
