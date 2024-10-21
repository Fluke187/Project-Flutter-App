class Notigetmodel {
  List<RecordNoti>? recordNoti;

  Notigetmodel({this.recordNoti});

  Notigetmodel.fromJson(Map<String, dynamic> json) {
    if (json['recordNoti'] != null) {
      recordNoti = <RecordNoti>[];
      json['recordNoti'].forEach((v) {
        recordNoti!.add(new RecordNoti.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recordNoti != null) {
      data['recordNoti'] = this.recordNoti!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecordNoti {
  int? id;
  int? pid;
  DateTime? inspectionDate;

  RecordNoti({this.id, this.pid, this.inspectionDate});

  RecordNoti.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pid = json['pid'];
    inspectionDate = DateTime.parse(json['inspectionDate'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pid'] = this.pid;
    data['inspectionDate'] = this.inspectionDate;
    return data;
  }
}