class RPregnancyGetModel {
  List<RecordP>? recordP;

  RPregnancyGetModel({this.recordP});

  RPregnancyGetModel.fromJson(Map<String, dynamic> json) {
    if (json['recordP'] != null) {
      recordP = <RecordP>[];
      json['recordP'].forEach((v) {
        recordP!.add(new RecordP.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recordP != null) {
      data['recordP'] = this.recordP!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecordP {
  int? id;
  int? pid;
  String? inspectionDate;
  int? pressure;
  int? heart;
  int? child;
  int? needle;

  RecordP(
      {this.id,
        this.pid,
        this.inspectionDate,
        this.pressure,
        this.heart,
        this.child,
        this.needle});

  RecordP.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    inspectionDate = json['inspectionDate'];
    pressure = json['pressure'];
    heart = json['heart'];
    child = json['child'];
    needle = json['needle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['inspectionDate'] = this.inspectionDate;
    data['pressure'] = this.pressure;
    data['heart'] = this.heart;
    data['child'] = this.child;
    data['needle'] = this.needle;
    return data;
  }
}
