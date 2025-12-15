
class CookUseModelData {
  String? sId;
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? role;
  bool? isActive;
  bool? isVerified;
  bool? isDeleted;
  int? trackStep;
  bool? isCookOtpVerified;
  bool? isKlzhRegistered;
  bool? pdfSent;
  String? klzhNumberExpiry;
  bool? isSelfResContract;
  bool? isHygiened;
  bool? isBecomeCook;
  bool? isCookIdVerified;
  String? expiresAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CookUseModelData(
      {this.sId,
        this.name,
        this.email,
        this.phoneNumber,
        this.password,
        this.role,
        this.isActive,
        this.isVerified,
        this.isDeleted,
        this.trackStep,
        this.isCookOtpVerified,
        this.isKlzhRegistered,
        this.klzhNumberExpiry,
        this.isSelfResContract,
        this.pdfSent,
        this.isHygiened,
        this.isBecomeCook,
        this.isCookIdVerified,
        this.expiresAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CookUseModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    role = json['role'];
    isActive = json['isActive'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    trackStep = json['trackStep'];
    isCookOtpVerified = json['isCookOtpVerified'];
    isKlzhRegistered = json['isKlzhRegistered'];
    pdfSent = json['pdfSent'];
    klzhNumberExpiry = json['klzhNumberExpiry'];
    isSelfResContract = json['isSelfResContract'];
    isHygiened = json['isHygiened'];
    isHygiened = json['isBecomeCook'];
    isCookIdVerified = json['isCookIdVerified'];
    expiresAt = json['expiresAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
