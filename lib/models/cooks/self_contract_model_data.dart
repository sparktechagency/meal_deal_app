class SelfContractModelData {
  String? sId;
  String? title;
  String? noticeLine;
  List<String>? descriptions;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SelfContractModelData(
      {this.sId,
        this.title,
        this.noticeLine,
        this.descriptions,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  SelfContractModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    noticeLine = json['noticeLine'];
    descriptions = json['descriptions'].cast<String>();
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
