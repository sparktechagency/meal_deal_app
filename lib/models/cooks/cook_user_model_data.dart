class CookUseModelData {
  String? role;
  String? accessToken;
  String? refreshToken;
  String? onboardingUrl;
  User? user;

  CookUseModelData(
      {this.role,
        this.accessToken,
        this.refreshToken,
        this.onboardingUrl,
        this.user});

  CookUseModelData.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    onboardingUrl = json['onboardingUrl'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}

class User {
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
  String? klzhNumberExpiry;
  bool? isSelfResContract;
  bool? isHygiened;
  bool? isCookIdVerified;
  String? expiresAt;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User(
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
        this.isHygiened,
        this.isCookIdVerified,
        this.expiresAt,
        this.createdAt,
        this.updatedAt,
        this.iV});

  User.fromJson(Map<String, dynamic> json) {
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
    klzhNumberExpiry = json['klzhNumberExpiry'];
    isSelfResContract = json['isSelfResContract'];
    isHygiened = json['isHygiened'];
    isCookIdVerified = json['isCookIdVerified'];
    expiresAt = json['expiresAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
