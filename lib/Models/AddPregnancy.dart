class AddPregnancyResponseModel {
  int? pId;

  AddPregnancyResponseModel({this.pId});

  AddPregnancyResponseModel.fromJson(Map<String, dynamic> json) {
    pId = json['pId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pId'] = this.pId;
    return data;
  }
}