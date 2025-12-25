class CookUseModelData {
  String? sId;
  String? cookId;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  bool? isActive;
  String? otp;
  bool? isVerified;
  bool? isDeleted;
  String? passwordChangedAt;
  int? trackStep;
  bool? isCookOtpVerified;
  bool? isKlzhRegistered;
  String? klzhNumberExpiry;
  bool? isSelfResContract;
  bool? isHygiened;
  bool? isCookIdVerified;
  String? expiresAt;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? klzhNumber;
  bool? pdfSent;
  bool? isBecomeCook;
  String? profileImage;
  bool? isCookVideo;
  bool? isCookPdf;
  bool? isCookQuiz;
  bool? isCookfullyVerified;

  CookUseModelData(
      {this.sId,
        this.cookId,
        this.name,
        this.email,
        this.phoneNumber,
        this.role,
        this.isActive,
        this.otp,
        this.isVerified,
        this.isDeleted,
        this.passwordChangedAt,
        this.trackStep,
        this.isCookOtpVerified,
        this.isKlzhRegistered,
        this.klzhNumberExpiry,
        this.isSelfResContract,
        this.isHygiened,
        this.isCookIdVerified,
        this.expiresAt,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.klzhNumber,
        this.pdfSent,
        this.isBecomeCook,
        this.profileImage,
        this.isCookVideo,
        this.isCookPdf,
        this.isCookQuiz,
        this.isCookfullyVerified});

  CookUseModelData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cookId = json['cookId'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    role = json['role'];
    isActive = json['isActive'];
    otp = json['otp'];
    isVerified = json['isVerified'];
    isDeleted = json['isDeleted'];
    passwordChangedAt = json['passwordChangedAt'];
    trackStep = json['trackStep'];
    isCookOtpVerified = json['isCookOtpVerified'];
    isKlzhRegistered = json['isKlzhRegistered'];
    klzhNumberExpiry = json['klzhNumberExpiry'];
    isSelfResContract = json['isSelfResContract'];
    isHygiened = json['isHygiened'];
    isCookIdVerified = json['isCookIdVerified'];
    expiresAt = json['expiresAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    klzhNumber = json['klzhNumber'];
    pdfSent = json['pdfSent'];
    isBecomeCook = json['isBecomeCook'];
    profileImage = json['profileImage'];
    isCookVideo = json['isCookVideo'];
    isCookPdf = json['isCookPdf'];
    isCookQuiz = json['isCookQuiz'];
    isCookfullyVerified = json['isCookfullyVerified'];
  }
}
