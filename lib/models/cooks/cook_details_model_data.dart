class CookDetailsModelData {
  Cook? cook;
  List<Meals>? meals;
  List<Reviews>? reviews;

  CookDetailsModelData({this.cook, this.meals, this.reviews});

  CookDetailsModelData.fromJson(Map<String, dynamic> json) {
    cook = json['cook'] != null ? new Cook.fromJson(json['cook']) : null;
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(new Meals.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
  }
}

class Cook {
  String? sId;
  String? userId;
  String? cookName;
  String? businessNumber;
  String? profileImage;
  List<String>? kitchenImages;
  List<String>? certificates;
  String? approvedAt;
  String? rejectionReason;
  String? totalOrders;
  String? completedOrders;
  String? rejectedOrders;
  int? rating;
  String? stars;
  String? totalReviews;
  bool? isKlzhRegistered;
  bool? isCookApproved;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Cook(
      {this.sId,
        this.userId,
        this.cookName,
        this.businessNumber,
        this.profileImage,
        this.kitchenImages,
        this.certificates,
        this.approvedAt,
        this.rejectionReason,
        this.totalOrders,
        this.completedOrders,
        this.rejectedOrders,
        this.rating,
        this.stars,
        this.totalReviews,
        this.isKlzhRegistered,
        this.isCookApproved,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Cook.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    cookName = json['cookName'];
    businessNumber = json['businessNumber'];
    profileImage = json['profileImage'];
    kitchenImages = json['kitchenImages'].cast<String>();
    certificates = json['certificates'].cast<String>();
    approvedAt = json['approvedAt'];
    rejectionReason = json['rejectionReason'];
    totalOrders = json['totalOrders'];
    completedOrders = json['completedOrders'];
    rejectedOrders = json['rejectedOrders'];
    rating = json['rating'];
    stars = json['stars'];
    totalReviews = json['totalReviews'];
    isKlzhRegistered = json['isKlzhRegistered'];
    isCookApproved = json['isCookApproved'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class Meals {
  String? sId;
  String? cookId;
  String? mealName;
  String? description;
  String? cuisineName;
  int? availablePortion;
  String? dietaryCategories;
  String? category;
  String? fitnessFlow;
  String? cheatFlow;
  String? timeForOrder;
  String? timeForPickUpFood;
  double? pricePerPortion;
  String? servedWarm;
  double? coldReheatPrice;
  List<String>? ingredients;
  String? allergyInformation;
  double? price;
  String? location;
  String? pickUpTime;
  String? offer;
  String? kcalories;
  List<String>? imageUrls;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Meals(
      {this.sId,
        this.cookId,
        this.mealName,
        this.description,
        this.cuisineName,
        this.availablePortion,
        this.dietaryCategories,
        this.category,
        this.fitnessFlow,
        this.cheatFlow,
        this.timeForOrder,
        this.timeForPickUpFood,
        this.pricePerPortion,
        this.servedWarm,
        this.coldReheatPrice,
        this.ingredients,
        this.allergyInformation,
        this.price,
        this.location,
        this.pickUpTime,
        this.offer,
        this.kcalories,
        this.imageUrls,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Meals.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cookId = json['cookId'];
    mealName = json['mealName'];
    description = json['description'];
    cuisineName = json['cuisineName'];
    availablePortion = json['availablePortion'];
    dietaryCategories = json['dietaryCategories'];
    category = json['category'];
    fitnessFlow = json['fitnessFlow'];
    cheatFlow = json['cheatFlow'];
    timeForOrder = json['timeForOrder'];
    timeForPickUpFood = json['timeForPickUpFood'];
    pricePerPortion = json['pricePerPortion'];
    servedWarm = json['servedWarm'];
    coldReheatPrice = json['coldReheatPrice'];
    ingredients = json['ingredients'].cast<String>();
    allergyInformation = json['allergyInformation'];
    price = json['price'];
    location = json['location'];
    pickUpTime = json['pickUpTime'];
    offer = json['offer'];
    kcalories = json['kcalories'];
    imageUrls = json['imageUrls'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class Reviews {
  String? sId;
  UserId? userId;
  String? cookId;
  int? rating;
  String? comment;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Reviews(
      {this.sId,
        this.userId,
        this.cookId,
        this.rating,
        this.comment,
        this.isDeleted,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Reviews.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId =
    json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    cookId = json['cookId'];
    rating = json['rating'];
    comment = json['comment'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}

class UserId {
  String? sId;
  String? name;

  UserId({this.sId, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }
}
