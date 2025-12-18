

class CategoryModelData {
  String? sId;
  String? name;
  String? type;

  CategoryModelData({this.sId, this.name, this.type});

  CategoryModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    type = json['type'];
  }
}
