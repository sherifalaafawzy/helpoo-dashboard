import 'package:flutter/cupertino.dart';

class _PartModel {
  String? name;
  String? price;

  _PartModel();

  _PartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }

  @override
  toString() => '$name - $price';
}

class _PartViewModel {
  GlobalKey? globalKey;
  TextEditingController? textEditingController;
  List<PartModel>? partsListView;
  PartModel? selectedPart;

  _PartViewModel({
    this.selectedPart,
  })
      : globalKey = GlobalKey(),
        textEditingController = TextEditingController();

  factory _PartViewModel.fromJson(Map<String, dynamic> json) {
    return _PartViewModel(
        selectedPart: PartModel(
          name: json['name'],
          price: json['price'],
        )
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': selectedPart?.name,
      'price': selectedPart?.price,
    };
  }
}


class PartModel {
  String? name;
  String? price;

  PartModel({
    this.name,
    this.price,
  });

  PartModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
    };
  }

  @override
  toString() => '$name - $price';
}

class PartViewModel {
  TextEditingController? partNameTextEditingController;
  TextEditingController? partPriceTextEditingController;

  PartViewModel({String? name, String? price})
      : partNameTextEditingController = TextEditingController(text: name),
        partPriceTextEditingController = TextEditingController(text: price);

  factory PartViewModel.fromJson(Map<String, dynamic> json) {
    return PartViewModel(
        name: json['name'],
        price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': partNameTextEditingController?.text,
      'price': partPriceTextEditingController?.text,
    };
  }
}
